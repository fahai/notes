# Tool  
------

## 查看端口号占用(已80端口号为例)
- windows cmd
> netstat -aon | findstr "80"
> tasklist | findstr $pid
> taskkill /pid $pid /F

- linux terminal
> netstat -anl | grep 80
> lsof -i:80
> kill $pid

## linux 检查端口是否启用
> lsof -i:$portNumber

## linux 检查MySQL服务运行状态
> ps -eo pid,stat | grep $PID


## windows 启动服务
- windows cmd
> net start service_name
> net stop service_name

## 修改Windos服务名称
regedit
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ ->
双击右侧的DisplayName，在‘数值数据’中输入你想改成的服务名，
然后退出注册表编辑器，再重启机器即可。


## Chrome删除一条网址提示
出现提示网址的提示后，按键盘上的“箭头下”，即时只有一个也按下键；让蓝色阴影选中第一个网址，然后按shift+delete


## Useful Website
http://www.cnblogs.com/
http://news.dbanotes.net/
http://toutiao.io/
http://www.importnew.com/
http://www.javaranger.com/


## Win7下安装Oracle 10g
http://www.jb51.net/article/32348.htm

如果由安装过客户端，建议先全部删光光，再安装服务端
删除环境变量ORACLE_HOME和PATH，注册表，C盘的Oracle目录

IMP-00058：
没有显示任何信息，使用sqlplus或者plsql登录用户

如何查看服务器有多少个数据库
右击我的电脑--管理--服务，查找跟oracle有关的那个服务。
我的oracle是10g版本的。
比方说我的oracle中就有两个数据库(WANG和ORCL)：就有这两个数据库的服务名。
              OracleServiceWANG
              OracleServiceORCL
你要查多少个数据库是不是，就看看你的服务中，不管启动没启动的，有多少个类似这种服务名的。


http://www.cnblogs.com/smartvessel/archive/2009/07/06/1517690.html
新建表空间
 create tablespace TSS datafile 'D:\oracle\product\10.2.0\oradata\orcl\tss_data.dbf' size 500M;
新建用户tss
create user news identified by news default tablespace news_tablespace;
授权用户
SQL> grant connect,resource to news;  --表示把 connect,resource权限授予news用户
SQL> grant dba to news;  --表示把 dba权限授予给news用户


## 在Windows中根据IP地址来查询计算机名
ping -a 192.168.1.111        //查看计算机名
或者
nbtstat -a 192.168.1.111     //查看的是计算机名、工作组和MAC地址
再或者使用软件Lansee

查看网上邻居的共享：
net view 192.168.1.111      //查看的是计算机描述和相关的共享文件

## Informatica
Dev domain 信息：
   Domain Name：Domain_cnsz03vl0261
   Gateway Host： informatica-dev.sf-express.com
   Gateway Port：6005
Dev domain公用账户：PUB_DEV/PUB_DEV，只有读的权限，没有写的权限

Uat domain 信息：
   Domain Name：Domain_cnsz03vl0269
   Gateway Host： informatica-uat.sf-express.com
   Gateway Port：6005


## Sublime Text Notes
Command Panel : Ctrl + Shift + P
Shift Files : Ctrl + P
Goto Anythinf : Ctrl + P  @ # :
Package Control
  Control + `
  import urllib2,os; pf='Package Control.sublime-package'; ipp = sublime.installed_packages_path(); os.makedirs( ipp ) if not os.path.exists(ipp) else None; urllib2.install_opener( urllib2.build_opener( urllib2.ProxyHandler( ))); open( os.path.join( ipp, pf), 'wb' ).write( urllib2.urlopen( 'http://sublime.wbond.net/' +pf.replace( ' ','%20' )).read()); print( 'Please restart Sublime Text to finish installation')
  Check the install : Preferences -> Package Settings

## Linux
cd -      #回到上次所在目录，这个技巧我原来还真是不知道，感觉还是比较有用，省略了很多输入。
cd !$     #把上个命令的参数作为输入。
cd        #回到主目录
cd ~      #同样也是回到主目录


## 护眼色 参数
色调85，饱和度90，亮度205

## TC 显示SVN文件夹图标
在Total command中显示Tortoise svn叠置图标的方法
Tortoise svn默认做为Windows 资源管理器的插件，只在Windows 资源管理器中显示叠置图标。Total command是资源管理的王牌软件，要在Total command中显示Tortoise svn叠置图标，需要进行如下修改：
1、Total command的[配置]->[选项]->[图标]，勾选“显示叠置图标，如快捷方式的箭头图标”
2、Total command的[配置]->[选项]->[操作方式]，选择“使用鼠标左键选择（Windows标准操作方式）”
3、Total commannd安装插件“ShellDetails”，下载地址http://www.ghisler.com/plugins.htm#filesys
4、Tortoise svn的[设置]->[图标叠加]，取消勾选“仅在资源管理器中显示图标覆盖”
完成修改后，重启Total commannd即可以正确显示Tortoise svn叠置图标。

以上使用的是Total command和Tortoise svn的中文版本，对应的英文版本的更改方式为：
1、Total command : Configuration -> Options -> Layout -> Display，勾选"Show overlay icons, e.g. for links"
2、Total command : Configuration -> Options -> Operation -> Mouse selection mode，勾选"Left mouse button (Windows standard)"
3、Total command : 安装插件“ShellDetails”，下载地址http://www.ghisler.com/plugins.htm#filesys
4、Tortoise svn　：settings -> Look and Feel，取消勾选"Show overlays only in explorer"

## Word Excel Powerpoint
excel的查找函数用作转义
  =LOOKUP(E20, {1,2,3}, {"我是1","我是2","我是3"})

## Coding Standards 编码规范  
1. action
前端控制器，处理与界面的数据交换以及界面切换或跳转，注意不要混入业务逻辑代码，action只简单的把接到的数据传给biz，并将biz返回的数据填充。

2. biz
业务模型，处理相关业务，注意不要把biz变成dao的代理，biz不和dao对应，而应和action对应，biz接口的函数签名必须明确声明并注释参数，返回值及异常等契约，不要传入一个笼统的Map或大对象，那样会使调用者分不清哪些属性值是必需的。

3. dao
数据持久化操作门面，封装数据持久化增删改查的细节。

4. domain
领域模型，与现实场景中事物的领域建模对等体。通常为POJO，只有属性的存取方法(包括关联属性)。

5. exception
异常体系模型，对非正常场景建模的对等体，在这里定义访模块的所有异常类。

6. util
工具类。

7. META-INF
每个模块下均有相应META-INF子目录，所有配置都放在此目录下，如：
  7.1. readme.txt
  此文件为该模块的自述文件，简单描述该模块的功能点
  7.2. action.xml
  里面放该模块struts的action配置
  7.3. beans.xml
  里面放该模块spring的beans配置
  7.4. mapping.xml
  放该模块hibernate的实体映射配置
  7.5. i18n
  存放国际化资源文件，菜单类命名规则：menu_{字符集}.properties，字符串类命名规则：messages_{字符集}properties  


## Informatica

### 开发步骤
- 定义源  
- 定义目标  
- 创建映射  
- 定义任务  
- 创建工作流  
- 工作流任务调度  


### 开发准备  
源数据库：执行新建用户脚本
目标数据库：执行新建用户脚本


## ToDoList  
配置ToDoList：
  默认选项
    关闭最小化，显示在状态栏

查看ToDoList的命令
   1）、Category（类别）的设置可以参考学习GTD中常用设置，如：

     收集/待整理：@Inbox（收集箱）；

     需要行动：
     @Next Action（下一步行动，马上要做的），@Calendar（安排至日程表，特定时间再做），@Waiting For（已经委派给他人做了，现等待结果）；

     无需行动：@Someday/Maybe（将来也许会做），@Reference（灵感或参考资料）；

     或者单独以场景来分类：@Computer（在电脑上），@Call（在电话里），@Home（在家），@Work（在公司），@Errands（在外），@AnyWhere（随便什么位置）；

   2）、States（状态），

     可以设置为人的状态，即任务对精力、体力的要求：巅峰、旺盛、一般、疲惫；

     也可以设置为任务状态：#Doing Now（正在做），#Do it ASAP（尽快做），#In Calendar（放入日程表中，将来做），#Waiting（暂定/等待），#Done（已经完成），#Review（待回顾）;

   3）、Allocated By（指派人），可以设置为：上级领导、同事、客户、供应商、常打交道的一些联系人、朋友、家人、自我…

   4）、Allocated To（接收人），可以设置为：同上，也可以将此字段看做一个任务的预期目的，进一步细化，如：个人-健康，个人-情义，个人-理财，个人-学习，个人-兴趣……
分类：
状态：


cmd命令：
  td -pid 6 -nt "title" -cm "comment"

四象限分类法：
1重要不紧急
2重要且紧急
3不重要但紧急
4不重要不紧急

Status
收集/待整理：
  @Inbox（收集箱）；
需要行动：
  @Next Action（下一步行动，马上要做的），
  @Calendar（安排至日程表，特定时间再做），
  @Waiting For（已经委派给他人做了，现等待结果）；
无需行动：
  @Someday/Maybe（将来也许会做），
  @Reference（灵感或参考资料）；

@Inbox
@Next Action
@Calendar
@Waiting For
@Someday/Maybe
@Reference

5W2H 七何分析法  
(1) WHY——为什么？为什么要这么做？理由何在？原因是什么？
(2) WHAT——是什么？目的是什么？做什么工作？
(3) WHERE——何处？在哪里做？从哪里入手？
(4) WHEN——何时？什么时间完成？什么时机最适宜？
(5) WHO——谁？由谁来承担？谁来完成？谁负责？
(6) HOW——怎么做？如何提高效率？如何实施？方法怎样？
(7) HOW MUCH——多少？做到什么程度？数量如何？质量水平如何？费用产出如何？

## git  
把用户目录下的.ssh里的公钥和密钥拷贝到git bash目录下的.ssh目录里就可以直接在cmd里用git了

windows下git push报Permission denied的解决方案
E:\Workspaces\hta\iReader&gt;git push origin master
Permission denied (publickey).
fatal: The remote end hung up unexpectedly
百般折腾，终于发现，只要在 git 附带的 bash （Git Bash 可以在开始菜单的 git 目标里面找到）里面运行命令，就可以一切正常。

$ ssh git@github.com
The authenticity of host 'github.com (207.97.227.239)' can't be established.
RSA key fingerprint is 16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'github.com,207.97.227.239' (RSA) to the list of kno
n hosts.
Hi greatghoul! You've successfully authenticated, but GitHub does not provide s
ell access.
Connection to github.com closed.

git fork project

git init

git remote add origin git@github.com:fahai/java-design-patterns.git

git pull origin master

## MongoDB  


db.createCollection("collection_name")

use db_name
db.COLLECTION_NAME.drop()


## 发布研发环境  



## secureCRT远程连接Linux，Alt+.快捷键被secureCRT占用
option -> session options -> termianl -> emulation -> use alt as meta key



## 云服务器  

第一次使用云服务器的旅行
root用户登录，新建普通用户fahai
vim /etc/passwd
vim /etc/group
vim /etc/shadow
useradd -m fahai
passwd fahai
putty不显示当前所在目录，tab键不能补全
  跟ssh客户端配置没有关系，跟用户所用的bash shell有关系
  查看用户有没有配置bash shell：vim /etc/passwd | grep fahai
  chsh -s /bin/bash 不生效
  userdel fahai
  useradd -m -s /bin/bash fahai
  passwd fahai

需要把软件安装到/opt目录，把/opt的目录权限赋给fahai用户
  root用户把软件解压到/opt目录，再把目录权限改成fahai

使用FTP传输文件
http://help.aliyun.com/knowledge_detail/5973937.html?spm=5176.788314854.3.3.fhRVd1
4.0注册码
——– FlashFXP Registration Data START ——–
FLASHFXPvwCYA16pvwAAAAC2WpcNKwTnwbveeFsasruCD7nTNE
qX/qsvG2UWCyyzmq8cYPqQAZVLclU3WLP9a1BBDpcCDPBi37v4
mlDCL0hAL/D+yVcY1xiEyEGWJ9msVQ9BN1PN8n9o5TtxNH6GPs
Kd1655TdjSJqvksIQfOMeVcG/KngWSJxpEAqPTLU0kJSkjKktd
vdUni+hN2AQVCxco22m/XzEyVMSz34G2eBU55WXffnsVnfObC7
VFmA==
——– FlashFXP Registration Data END ———-

安装JDK
  解压安装文件
  配置环境变量
  验证安装是否成功

安装tomcat
  解压安装文件即可使用

安装MySQL


安装PHP


安装apache2
  sudo apt-get install apache2
  安装完成。 
  运行如下命令重启下：
  sudo /etc/init.d/apache2 restart
  在浏览器里输入http://localhost或者是http://127.0.0.1，如果看到了It works!，那就说明Apache就成功的安装了，Apache的默认安装，会在/var下建立一个名为www的目录，这个就是Web目录了，所有要能过浏览器访问的Web文件都要放到这个目录里。

  AH00558: apache2: Could not reliably determine the server's fully qualified domain name
  找到apache2的配置文件目录：wereis apache2
  vim /etc/apache2/apache2.conf
  [root@server conf]# vi httpd.conf
  #ServerName www.example.com:80
  ServerName localhost:80



验证php是否生效
vim /var/www/html/test.php
<?php
  phpinfo()
?>
http://112.74.15.179/test.php


fahai
sg5Flq1tpP68VOUjMO


迁移wordpress站点
  迁移数据库
  迁移网站文件
