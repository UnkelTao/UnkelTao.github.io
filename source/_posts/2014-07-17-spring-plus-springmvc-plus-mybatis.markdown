---
layout: post
title: "spring+springmvc+mybatis环境搭建"
date: 2014-07-17 14:46:31 +0100
comments: true
categories: [Java]
keywords: java,spring,springmvc,mybatis
description: 'spring+springmvc+mybatis整合，环境搭建' 
---

学习了一下这个框架的整合，跟SSH还是有区别的，将Struts2换成了springmvc，hibernate换成了mybatis。

当然管理包什么的，还是Maven靠谱，IDE从MyEclipse换到了Eclipse，快了不少。不过Maven插件需要自己安装了。
<!-- more -->


##环境搭建

###Maven

*	配置: 下载Maven包配置环境变量即可，配置文件中修改库的位置等相关信息  
*	使用： 安装Eclipse插件，将Maven安装路径配置进去  
*	在**pom.xml**中加入包的配置即可。  

> <dependency>  
>   <groupId>org.springframework</groupId>  
>   <artifactId>spring-test</artifactId>  
>   <version>3.2.0.RELEASE</version>  
> </dependency>  
            
*	其中版本号可以在[http://search.maven.org](http://search.maven.org/) 中查询.  
下面是我搭建环境中所使用到的jar包  

```
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
	<modelVersion>4.0.0</modelVersion>
	<groupId>unkeltao.testmybatis</groupId>
	<artifactId>testmybatis</artifactId>
	<packaging>war</packaging>
	<version>0.0.1-SNAPSHOT</version>
	<name>testmybatis Maven Webapp</name>
	<url>http://maven.apache.org</url>

	<dependencies>
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-test</artifactId>
			<version>3.2.0.RELEASE</version>
		</dependency>
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-webmvc</artifactId>
			<version>3.2.0.RELEASE</version>
		</dependency>
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-core</artifactId>
			<version>3.2.0.RELEASE</version>
		</dependency>
		<dependency>
			<groupId>org.mybatis</groupId>
			<artifactId>mybatis</artifactId>
			<version>3.1.1</version>
		</dependency>
		<dependency>
			<groupId>org.mybatis</groupId>
			<artifactId>mybatis-spring</artifactId>
			<version>1.1.1</version>
		</dependency>
		<dependency>
			<groupId>mysql</groupId>
			<artifactId>mysql-connector-java</artifactId>
			<version>5.1.21</version>
		</dependency>
		<dependency>
			<groupId>junit</groupId>
			<artifactId>junit</artifactId>
			<version>4.11</version>
			<scope>test</scope>
		</dependency>
		<dependency>
			<groupId>com.alibaba</groupId>
			<artifactId>druid</artifactId>
			<version>0.2.9</version>
		</dependency>
		<dependency>
			<groupId>org.aspectj</groupId>
			<artifactId>aspectjweaver</artifactId>
			<version>1.7.1</version>
		</dependency>
		<dependency>
			<groupId>org.aspectj</groupId>
			<artifactId>aspectjrt</artifactId>
			<version>1.7.1</version>
		</dependency>
		<dependency>
			<groupId>org.codehaus.jackson</groupId>
			<artifactId>jackson-mapper-asl</artifactId>
			<version>1.9.11</version>
		</dependency>
		<dependency>
			<groupId>org.codehaus.jackson</groupId>
			<artifactId>jackson-core-asl</artifactId>
			<version>1.9.11</version>
		</dependency>

		<dependency>
			<groupId>commons-fileupload</groupId>
			<artifactId>commons-fileupload</artifactId>
			<version>1.2.2</version>
		</dependency>
		<dependency>
			<groupId>javax.servlet</groupId>
			<artifactId>servlet-api</artifactId>
			<version>3.0-alpha-1</version>
		</dependency>
		<dependency>
			<groupId>log4j</groupId>
			<artifactId>log4j</artifactId>
			<version>1.2.17</version>
		</dependency>
		<dependency>
			<groupId>com.alibaba</groupId>
			<artifactId>fastjson</artifactId>
			<version>1.1.26</version>
		</dependency>
		<dependency>
			<groupId>jstl</groupId>
			<artifactId>jstl</artifactId>
			<version>1.2</version>
		</dependency>
		<dependency>
			<groupId>taglibs</groupId>
			<artifactId>standard</artifactId>
			<version>1.1.2</version>
		</dependency>
		<dependency>
			<groupId>cglib</groupId>
			<artifactId>cglib-nodep</artifactId>
			<version>3.1</version>
		</dependency>
	</dependencies>
	<build>
	</build>
</project>
```

###相关xml配置    

####spring.xml 用来配置spring    

```
<?xml version="1.0" encoding="UTF-8"?>
		<beans xmlns="http://www.springframework.org/schema/beans" 
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
		xmlns:aop="http://www.springframework.org/schema/aop"      
		xmlns:context="http://www.springframework.org/schema/context" 
		xsi:schemaLocation="
		http://www.springframework.org/schema/beans
		http://www.springframework.org/schema/beans/spring-beans-3.0.xsd
		http://www.springframework.org/schema/context
		http://www.springframework.org/schema/context/spring-context-3.0.xsd
		http://www.springframework.org/schema/aop
		http://www.springframework.org/schema/aop/spring-aop-3.0.xsd"
>
	<!-- 启动对@AspectJ注解的支持 -->
    <aop:aspectj-autoproxy/>
	<!-- 引入属性文件 -->
	<context:property-placeholder location="classpath:config.properties" />
	<!-- 自动扫描(自动注入) -->
	<context:component-scan base-package="unkeltao.service" />
</beans>  
```

####spring-mvc.xml 配置springmvc,用不到的可以删掉  

```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans" xmlns:mvc="http://www.springframework.org/schema/mvc" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:p="http://www.springframework.org/schema/p" xmlns:context="http://www.springframework.org/schema/context" xsi:schemaLocation="http://www.springframework.org/schema/beans 
http://www.springframework.org/schema/beans/spring-beans-3.0.xsd 
http://www.springframework.org/schema/context 
http://www.springframework.org/schema/context/spring-context-3.0.xsd 
http://www.springframework.org/schema/mvc 
http://www.springframework.org/schema/mvc/spring-mvc-3.0.xsd">
	<!-- 自动扫描controller包下的所有类，使其认为spring mvc的控制器 -->
	<context:component-scan base-package="unkeltao.controller" />
	<!-- 避免IE执行AJAX时,返回JSON出现下载文件 -->
	<bean id="mappingJacksonHttpMessageConverter" class="org.springframework.http.converter.json.MappingJacksonHttpMessageConverter">
		<property name="supportedMediaTypes">
			<list>
				<value>application/json;charset=UTF-8</value>
			</list>
		</property>
	</bean>
	<!-- 启动Spring MVC的注解功能，完成请求和注解POJO的映射 -->
	<bean class="org.springframework.web.servlet.mvc.annotation.AnnotationMethodHandlerAdapter">
		<property name="messageConverters">
			<list>
				<ref bean="mappingJacksonHttpMessageConverter" /><!-- json转换器 -->
			</list>
		</property>
	</bean>
	<!-- 对模型视图名称的解析，即在模型视图名称添加前后缀 -->
	<bean class="org.springframework.web.servlet.view.InternalResourceViewResolver" p:prefix="/" p:suffix=".jsp" />
	<bean id="multipartResolver" class="org.springframework.web.multipart.commons.CommonsMultipartResolver">
		<property name="defaultEncoding">
			<value>UTF-8</value>
		</property>
		<property name="maxUploadSize">
			<value>32505856</value><!-- 上传文件大小限制为31M，31*1024*1024 -->
		</property>
		<property name="maxInMemorySize">
			<value>4096</value>
		</property>
	</bean>
</beans>
```

####spring-mybatis.xml,里面为mybatis的一些配置   

```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:tx="http://www.springframework.org/schema/tx" xmlns:aop="http://www.springframework.org/schema/aop" xsi:schemaLocation="
http://www.springframework.org/schema/beans 
http://www.springframework.org/schema/beans/spring-beans-3.0.xsd 
http://www.springframework.org/schema/tx 
http://www.springframework.org/schema/tx/spring-tx-3.0.xsd
http://www.springframework.org/schema/aop 
http://www.springframework.org/schema/aop/spring-aop-3.0.xsd"
>
	<!-- JNDI方式配置数据源 -->
	<!-- <bean id="dataSource" class="org.springframework.jndi.JndiObjectFactoryBean"> <property name="jndiName" value="${jndiName}"></property> </bean> -->
	<!-- 配置数据源 -->
	<bean name="dataSource" class="com.alibaba.druid.pool.DruidDataSource" init-method="init" destroy-method="close">
		<property name="url" value="${jdbc_url}" />
		<property name="username" value="${jdbc_username}" />
		<property name="password" value="${jdbc_password}" />
		<!-- 初始化连接大小 -->
		<property name="initialSize" value="0" />
		<!-- 连接池最大使用连接数量 -->
		<property name="maxActive" value="20" />
		<!-- 连接池最大空闲 -->
		<property name="maxIdle" value="20" />
		<!-- 连接池最小空闲 -->
		<property name="minIdle" value="0" />
		<!-- 获取连接最大等待时间 -->
		<property name="maxWait" value="60000" />
		<!-- <property name="poolPreparedStatements" value="true" /> <property name="maxPoolPreparedStatementPerConnectionSize" value="33" /> -->
		<property name="validationQuery" value="${validationQuery}" />
		<property name="testOnBorrow" value="false" />
		<property name="testOnReturn" value="false" />
		<property name="testWhileIdle" value="true" />
		<!-- 配置间隔多久才进行一次检测，检测需要关闭的空闲连接，单位是毫秒 -->
		<property name="timeBetweenEvictionRunsMillis" value="60000" />
		<!-- 配置一个连接在池中最小生存的时间，单位是毫秒 -->
		<property name="minEvictableIdleTimeMillis" value="25200000" />
		<!-- 打开removeAbandoned功能 -->
		<property name="removeAbandoned" value="true" />
		<!-- 1800秒，也就是30分钟 -->
		<property name="removeAbandonedTimeout" value="1800" />
		<!-- 关闭abanded连接时输出错误日志 -->
		<property name="logAbandoned" value="true" />
		<!-- 监控数据库 -->
		<!-- <property name="filters" value="stat" /> -->
		<property name="filters" value="mergeStat" />
	</bean>
	<!-- myBatis文件 -->
	<bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
		<property name="dataSource" ref="dataSource" />
		<!-- 自动扫描entity目录, 省掉Configuration.xml里的手工配置 -->
		<property name="mapperLocations" value="classpath:unkeltao/mapping/*.xml" />
	</bean>
	<bean class="org.mybatis.spring.mapper.MapperScannerConfigurer">
		<property name="basePackage" value="unkeltao.dao" />
		<property name="sqlSessionFactoryBeanName" value="sqlSessionFactory" />
	</bean>
	<!-- 配置事务管理器 -->
	<bean id="transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
		<property name="dataSource" ref="dataSource" />
	</bean>
	<!-- 注解方式配置事物 -->
	<!-- <tx:annotation-driven transaction-manager="transactionManager" /> -->
	<!-- 拦截器方式配置事物 -->
	<tx:advice id="transactionAdvice" transaction-manager="transactionManager">
		<tx:attributes>
			<tx:method name="add*" propagation="REQUIRED" />
			<tx:method name="append*" propagation="REQUIRED" />
			<tx:method name="insert*" propagation="REQUIRED" />
			<tx:method name="save*" propagation="REQUIRED" />
			<tx:method name="update*" propagation="REQUIRED" />
			<tx:method name="modify*" propagation="REQUIRED" />
			<tx:method name="edit*" propagation="REQUIRED" />
			<tx:method name="delete*" propagation="REQUIRED" />
			<tx:method name="remove*" propagation="REQUIRED" />
			<tx:method name="repair" propagation="REQUIRED" />
			<tx:method name="delAndRepair" propagation="REQUIRED" />
			<tx:method name="get*" propagation="SUPPORTS" />
			<tx:method name="find*" propagation="SUPPORTS" />
			<tx:method name="load*" propagation="SUPPORTS" />
			<tx:method name="search*" propagation="SUPPORTS" />
			<tx:method name="datagrid*" propagation="SUPPORTS" />
			<tx:method name="*" propagation="SUPPORTS" />
		</tx:attributes>
	</tx:advice>
	<aop:config>
		<aop:pointcut id="transactionPointcut" expression="execution(* unkeltao.service..*Impl.*(..))" />
		<aop:advisor pointcut-ref="transactionPointcut" advice-ref="transactionAdvice" />
	</aop:config>
	<!-- 配置druid监控spring jdbc -->
	<bean id="druid-stat-interceptor" class="com.alibaba.druid.support.spring.stat.DruidStatInterceptor">
	</bean>
	<bean id="druid-stat-pointcut" class="org.springframework.aop.support.JdkRegexpMethodPointcut" scope="prototype">
		<property name="patterns">
			<list>
				<value>unkeltao.service.*</value>
			</list>
		</property>
	</bean>
	<aop:config>
		<aop:advisor advice-ref="druid-stat-interceptor" pointcut-ref="druid-stat-pointcut" />
	</aop:config>
</beans>
```  

其中使用到了数据库的一些配置信息，可以直接写进去，但也可以从配置中读取，配置文件config.propertiew,里面写着一些相关的配置，在xml中就可以导入就可以了.

```
#hibernate.dialect=org.hibernate.dialect.OracleDialect
#driverClassName=oracle.jdbc.driver.OracleDriver
#validationQuery=SELECT 1 FROM DUAL
#jdbc_url=jdbc:oracle:thin:@localhost:1521:orcl
#jdbc_username=sypro
#jdbc_password=sypro
hibernate.dialect=org.hibernate.dialect.MySQLDialect
driverClassName=com.mysql.jdbc.Driver
validationQuery=SELECT 1
jdbc_url=jdbc:mysql://localhost:3306/demo?useUnicode=true&characterEncoding=UTF-8&zeroDateTimeBehavior=convertToNull
jdbc_username=root
jdbc_password=1qazwsx
#hibernate.dialect=org.hibernate.dialect.SQLServerDialect
#driverClassName=net.sourceforge.jtds.jdbc.Driver
#validationQuery=SELECT 1
#jdbc_url=jdbc:jtds:sqlserver://127.0.0.1:1433/sy
#jdbc_username=sa
#jdbc_password=123456
#hibernate.dialect=org.hibernate.dialect.DerbyDialect
#driverClassName=org.apache.derby.jdbc.EmbeddedDriver
#validationQuery=SELECT 1
#jdbc_url=jdbc:derby:sy;create=true
#jdbc_username=sypro
#jdbc_password=sypro
#jndiName=java:comp/env/dataSourceName
hibernate.hbm2ddl.auto=update
hibernate.show_sql=false
hibernate.format_sql=true
sessionInfoName=sessionInfo
uploadFieldName=filedata
uploadFileMaxSize=20971520
uploadFileExts=txt,rar,zip,doc,docx,xls,xlsx,jpg,jpeg,gif,png,swf,wmv,avi,wma,mp3,mid
uploadDirectory=attached
```  

这样配置就算完成了。。。可以做做简单的测试



