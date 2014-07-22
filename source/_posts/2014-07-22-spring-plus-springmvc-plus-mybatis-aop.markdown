---
layout: post
title: "Spring+SpringMVC+Mybatis  利用AOP自定义注解实现可配置日志快照记录"
date: 2014-07-22 10:05:38 +0100
comments: true
categories: [Java,Spring]
keywords: java,spring,springmvc,mybatis
description: 'spring+springmvc+mybatis整合，环境搭建' 
---

##目的： 
需要对一些事物的操作进行日志记录，如果在service内进行记录，大量的代码重复，并且维护比较麻烦。所以采用AOP的方式对service进行拦截。使用自定义注解的目的则是判断是否需要记录日志和传递额外的信息。

##方式
本次解决方案十分感谢[博主-跳刀的兔子的博文](http://www.cnblogs.com/shipengzhi/articles/2716004.html) 本文绝大部分参考与本文，略有不同，所以做一些整理，[博主](http://www.cnblogs.com/shipengzhi/articles/2716004.html)的文章更详细一些。

<!-- more -->

###1.首先新建自定义注解  	
```
@Target({ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented  
@Inherited
public @interface LogWrite {
    /**
     *@param 模块名字 
     */
    String modelName() default "";
    
    /**
     *@param 操作类型 
     */
    String option();
}
```  

*	其中@Target注解用于描述该注解的范围，我们需要注解的方法，所以值为METHOD，相关含义如下表：  

| 取值 | 含义 |
|--------|--------|
|   CONSTRUCTOR     |    描述构造器    |
|	FIELD	|	描述域	|
|	LOCAL_VARIABLE	|	用于描述局部变量	|
|	METHOD	|	用于描述方法	|
|	PACKAGE	|	用于描述包	|
|	PARAMETER	| 用于描述参数	|
|	TYPE	|	用于描述类或接口	|

*	@Retention 用于描述注解的生命周期（即：被描述的注解在什么范围内有效），其取值有：  

| 取值 | 含义 |
|--------|--------|
|	SOURCE	|	在源文件中有效（即源文件保留）	|
|	CLASS	|	在 class 文件中有效（即 class 保留）	|
|	RUNTIME	|	在运行时有效(即运行时保留)	|

*	@Documented 在默认的情况下javadoc命令不会将我们的annotation生成再doc中去的，所以使用该标记就是告诉jdk让它也将annotation生成到doc中去  

*	@Inherited 比如有一个类A，在他上面有一个标记annotation，那么A的子类B是否不用再次标记annotation就可以继承得到呢，答案是肯定的  

###2.利用AOP方式拦截
*	配置AOP，我使用的是利用注解的方式来配置AOP，方法有很多，就不详细说了。
*	使用的是@Around 环绕通知，因为需要记录该方法是否被执行成功了。
*	实现@Around方法中，记录日志：  获取拦截的方法，判断该方法是否含有自定义注解，如果没有的则不进行记录，否则，按照自己的方式进行记录。 我主要记录的是操作的方法，所属模块，以及所有参数所构成的Json字符串。  

```
@Aspect
@Component
public class SnapshotLogWriteService {
	private LogService logService;
	public LogService getLogService() {
		return logService;
	}

	//自动注入日志记录service
	@Autowired
	public void setLogService(LogService logService) {
		this.logService = logService;
	}
	//环绕通知方法
	@Around("execution(* unkeltao.service.*.*(..))")
	public Object doWriteLog(ProceedingJoinPoint pjp) throws Throwable {
		System.err.println("拦截方法,进入日志记录");
		// 拦截的实体类
		Object target = pjp.getTarget();
		// 拦截的方法名称
		String methodName = pjp.getSignature().getName();
		// 拦截的方法参数
		Object[] args = pjp.getArgs();
		
		// 拦截的放参数类型
		Class[] parameterTypes = ((MethodSignature) pjp.getSignature())
				.getMethod().getParameterTypes();

		Object object = null;
		
		//需要转换成Json的HashMap
		Map<String, Object> maps = new HashMap<String, Object>();
		Map<String, Object> parammaps = new HashMap<String, Object>();
		// 获得被拦截的方法
		Method method = target.getClass().getMethod(methodName, parameterTypes);
		if (null != method) {
			// 判断是否包含自定义的注解
			if (method.isAnnotationPresent(MyAnnotation.class)) {
				// 获取自定义注解实体
				MyAnnotation myAnnotation = method
						.getAnnotation(MyAnnotation.class);
				//日志类实体类
				OptionLog log = new OptionLog();
				
				log.setUserid(myAnnotation.userid());
				log.setModelname(myAnnotation.modelName());
				log.setOp(myAnnotation.option());
				maps.put("方法名", method.getName());
				parammaps.put("方法名", method.getName());
                //循环获得所有参数对象
				for(int i=0; i<args.length; i++){
					if (null != args[i]) {
						parammaps.put("args["+i+"]", args[i]);
					}
					else {
						parammaps.put("args["+i+"]", "空参数");
					}
				}
				maps.put("参数", parammaps);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
				maps.put("操作时间", sdf.format(new Date()));
				// 获取服务运行结果
				try {
					object = pjp.proceed();// 执行该方法
					maps.put("状态", "成功");
					log.setStatus(1);
				} catch (Exception e) {
					System.err.println(e.getMessage());
					maps.put("状态", "失败");
					log.setStatus(0);
					log.setComments(e.getMessage());
				}
				//将参数转化为Json字符串
				log.setJs(new JSONObject(maps).toJSONString());
				log.setOptime(new Date());
				System.err.println(new JSONObject(maps).toJSONString());  
				
				//记录相关日志
				if (null != logService) {
					try {
						if(1 == logService.Save(log)){
							System.err.println("日志记录成功");
						}
						else{
							System.err.println("日志记录失败");
						}
						
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				else{
					System.err.println("自动注入失败，日志未记录");
				}

			} else { // 没有包含该注解则不进行其他处理
				object = pjp.proceed();// 执行该方法
			}

		} else { // 不需要拦截，直接运行
			object = pjp.proceed(); // 执行该方法
		}
		return object;
	}
}
```

###记录结果  
![记录结果](http://unkeltao.qiniudn.com/wailian/TestLog2.png)  

###最终的Json效果图  
![效果图](http://unkeltao.qiniudn.com/wailian/LogTest.png)

