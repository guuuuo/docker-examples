# Dockerfile for Java Web
为Java Web应用开发者准备的快速部署Java Web应用的镜像
### 1. 特性：
- 使用Apache作为前端代理，实现动静态资源的分离；
- 默认使用JDK8，可以在构建镜像时指定JDK版本；
- 使用Tomcat7，可以在构建镜像时指定Tomcat版本；
- 内建了apr支持；
- 使用Supervisor实现对镜像内多进程的管理；

### 2. 配置目录与文件说明
<table style="border-collapse:collapse;" width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr><td></td><td>镜像内</td><td>GitHub代码</td></tr>
	<tr><td>Apache Proxy及虚拟主机配置目录</td><td>/data/wwwconf</td><td>conf/data/wwwconf</td></tr>
    <tr><td>Apache DocumentRoot</td><td>/data/wwwroot</td><td>conf/wwwroot</td></tr>
    <tr><td>Tomcat 目录</td><td>/data/tomcat</td><td>N/A</td></tr>
    <tr><td>Tomcat 应用目录</td><td>/data/tomcat/webapps</td><td>可以在运行时通过 -v /home/xxx/webapps:/data/tomcat/webapps的方式映射到host上Java Web应用所在的目录</td></tr>
    <tr><td>Tomcat 配置目录</td><td>/data/tomcat/conf</td><td>conf/tomcat</td></tr>
    <tr><td>Tomcat 日志目录</td><td>/data/tomcat/logs</td><td>可以在运行时通过 -v /home/xxx/logs/tomcat:/data/tomcat/logs 的方式映射到host上，方便查看日志 </td></tr>
    <tr><td>Supervisor 配置文件</td><td>/etc/supervisord.conf</td><td>conf/supervisor/supervisord.conf</td></tr>
    <tr><td>Supervisor Tomcat运行脚本路径</td><td>/data/tomcat/bin/supervisord_tomcat.sh</td><td>conf/supervisor/supervisord_tomcat.sh</td></tr>
</table>

### 3. 环境变量说明
- JAVA_VERSION：JDK的大版本号, BUILD_VERSION：JDK的小版本号, JAVA_VERSION与BUILD_VERSION一起组成了JDK的版本号,可以在构建镜像时指定，例如：
```bash
-e JAVA_VERSION=8u45 -e BUILD_VERSION=b14
```
必须保证：http://download.oracle.com/otn-pub/java/jdk/$JAVA_VERSION-$BUILD_VERSION/jdk-$JAVA_VERSION-linux-x64.rpm 该文件是存在的，否则下载出错，构建出错。

- TOMCAT_VERSION：Tomcat版本号，可以在构建镜像时指定，例如：
```bash
-e TOMCAT_VERSION=7.0.62
```
必须保证：http://mirrors.cnnic.cn/apache/tomcat/tomcat-7/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.zip 该文件是存在的，否则下载出错，构建出错。

### 4. 使用方法
1. 克隆Docker及相关配置文件到本地
``` bash
git clone https://github.com/docker-images/Dockerfile-javaweb.git
```

2. 构建
``` bash
cd Dockerfile-javaweb
./build.sh
```
或者
``` bash
docker build -t guuuo/javaweb ./Dockerfile-javaweb
```

3. 运行
``` bash
cd Dockerfile-javaweb
./run.sh
```
或者
``` bash
docker run -p 80:80 -p 9001:9001 -p 8080:8080 -t -i guuuo/javaweb
```
或者 指定静态资源与Java Web应用程序的路径
``` bash
docker run -v /c/Users/xxx/javaproject/static:/data/wwwroot/static -v /c/Users/xxx/javaproject/webapps:/data/tomcat/webapps -p 80:80 -p 9001:9001 -p 8080:8080 -t -i guuuo/javaweb
```

4. 浏览与高度
 - Supervisor控制台： http://< docker-ip >:9001, 比如: http://192.168.59.103:9001
 - Tomcat控制台: http://< docker-ip >/manager or http://< docker-ip >:8080/manager, 比如: http://192.168.59.103/manager
 - 静态资源: http://< docker-ip >/static, 比如: http://192.168.59.103/static
 - Java Web应用：http://< docker-ip >/< context root of java web application >, 比如：http://192.168.59.103/hello-world