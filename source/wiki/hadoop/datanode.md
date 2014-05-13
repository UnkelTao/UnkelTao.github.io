---
layout: wiki
title: "Hadoop"
date: 2014-05-13 17:16:26 +0800
keywords: wiki,markow,datanode
description: 'datanode, 无法启动datanode'
---

*   [datanode](#toc1)
    *   [1. 无法启动datanode](#toc_1.1)

</div>
<div class="neirong">

<h2 id="toc_1.1">1. 无法启动datanode</h2>

>	ERROR org.apache.hadoop.hdfs.server.datanode.DataNode: org.apache.hadoop.ipc.RemoteException: java.io.IOException: verifyNodeRegistration: unknown datanode sist01:50010

*	可能原因:   
配置文件中配置了禁止该节点。   
*	解决方案:   
>	找到excludes文件(根据自己配置)，删除对应的节点。  
>	在主节点中刷新节点信息:  hadoop dfsadmin -refreshNodes   
>	在datanode节点执行如下命令: hadoop-daemon.sh start datanode
>	或者重启集群 ： stop-all.sh  start-all.sh  #代价比较大