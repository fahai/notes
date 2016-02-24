
## 查看Linux的登录日志
more /var/log/secure
who /var/log/wtmp


## 查看判断式的语法
test命令
> test -e /root
> man test

## 配置crontab任务
一次性的工作任务使用atd和at
循环性的工作任务使用crontab
需要唤醒停机期间的工作任务使用anacron

一般来说只有root用户才能配置crontab，可在/etc/cron.allow文件配置可以配置crontabd的用户。

指定用户执行工作调度
crontab [-u username] [-l|-e|-r]
crontab -u username -e

crontab表达式配置

系统的配置文件/etc/crontab

重启crond服务，让配置立即生效
serverice crond restart

查看工作调度的运行日志
vim /var/log/cron

## 查看系统配置信息  
- 查看内核/操作系统/CPU信息
$uname -a
- 查看操作系统版本
$head -n 1 /etc/issue
- 查看CPU信息
$cat /proc/cpuinfo
- 查看计算机名
$hostname
- 列出所有PCI设备
$lspci -tv
- 列出所有USB设备
$lsusb -tv
- 列出加载的内核模块
$lsmod
- 查看环境变量 资源
$env
- 查看内存使用量和交换区使用量
$free -m
- 查看各分区使用情况
$df -h
- 查看指定目录的大小
$du -sh
- 查看内存总量
$grep MemTotal /proc/meminfo
- 查看空闲内存量
$grep MemFree /proc/meminfo
- 查看系统运行时间、用户数、负载
$uptime
- 查看系统负载 磁盘和分区
$cat /proc/loadavg
- 查看挂接的分区状态
$mount | column -t
- 查看所有分区
$fdisk -l
- 查看所有交换分区
$swapon -s
- 查看磁盘参数(仅适用于IDE设备)
$hdparm -i /dev/hda
- 查看启动时IDE设备检测状况 网络
$dmesg | grep IDE
- 查看所有网络接口的属性
$ifconfig
- 查看防火墙设置
$iptables -L
- 查看路由表
$route -n
- 查看所有监听端口
$netstat -lntp
- 查看所有已经建立的连接
$netstat -antp
- 查看网络统计信息 进程
$netstat -s
- 查看所有进程
$ps -ef
- 实时显示进程状态 用户
$top
- 查看活动用户
$w
- 查看指定用户信息
$id
- 查看用户登录日志
$last
- 查看系统所有用户
$cut -d: -f1 /etc/passwd
- 查看系统所有组
$cut -d: -f1 /etc/group
- 查看当前用户的计划任务 服务
$crontab -l
- 列出所有系统服务
$chkconfig –list
- 列出所有启动的系统服务 程序
$chkconfig –list | grep on
- 查看所有安装的软件包
$rpm -qa 

## shell脚本打印带时间戳的日志
`date "+%Y-%m-%d %H:%M:%S"`

## 用find命令删除Linux下乱码文件及文件夹
每个文件都有一个节点编号，利用此节点编号定位乱码的文件，首先查看乱码文件的节点号
ls -i
22413314 12 ?..??mp3
前面的就是节点号了，接下来使用find命令查询并且删除.
find -inum 22413314 -delete
-inum指根据节点号查询；-delete顾名思义就是删除操作了。这样就成功删除乱码文件了。值得注意的是，此方法只适用于删除文件或空的文件夹。

对于文件夹，尤其是非空的文件夹，上面的方法就不适用了，要用到另外的参数来实现，首先相同的是查看乱码文件夹的节点号
ls -i
18612483 瑗块.?.. - Thank you, Love(128kbps) 2011.06.22

接下来使用find命令删除
find -inum 18612483 -exec rm -rf {} \;
find: ./瑗块.?.. - Thank you, Love(128kbps) 2011.06.22: No such file or directory

虽然提示我们找不到此文件或文件夹，但其实已经表明删除了。-exec作用是查找后执行命令，其中{}代表前面查询到的结果，空格+\;是结束符，其它就不说了。-exec后可以跟任何常用命令，因此这方法不但适用于文件夹，文件也可以。

批量删除
文件
for n in 22413315 22413314;do find -inum $n -delete;done

文件夹
for n in 22413315 22413314;do find -inum $n -exec rm -rf {} \;;done
$n是变量名，与for后面定义的一致，其它没啥好说的，适用其它操作。


while ( sleep 1 ) ; do ps -p 7172 -o %cpu,%mem,rss ; done


## Bash快捷键  
编辑命令
Ctrl + a ：移到命令行首
Ctrl + e ：移到命令行尾
Ctrl + f ：按字符前移（右向）
Ctrl + b ：按字符后移（左向）
Alt + f ：按单词前移（右向）
Alt + b ：按单词后移（左向）
Ctrl + xx：在命令行首和光标之间移动
Ctrl + u ：从光标处删除至命令行首
Ctrl + k ：从光标处删除至命令行尾
Ctrl + w ：从光标处删除至字首
Alt + d ：从光标处删除至字尾
Ctrl + d ：删除光标处的字符
Ctrl + h ：删除光标前的字符
Ctrl + y ：粘贴至光标后
Alt + c ：从光标处更改为首字母大写的单词
Alt + u ：从光标处更改为全部大写的单词
Alt + l ：从光标处更改为全部小写的单词
Ctrl + t ：交换光标处和之前的字符
Alt + t ：交换光标处和之前的单词
Alt + Backspace：与 Ctrl + w ~~相同~~类似，分隔符有些差别 [感谢 rezilla 指正]

重新执行命令
Ctrl + r：逆向搜索命令历史
Ctrl + g：从历史搜索模式退出
Ctrl + p：历史中的上一条命令
Ctrl + n：历史中的下一条命令
Alt + .：使用上一条命令的最后一个参数

控制命令
Ctrl + l：清屏
Ctrl + o：执行当前命令，并选择上一条命令
Ctrl + s：阻止屏幕输出
Ctrl + q：允许屏幕输出
Ctrl + c：终止命令
Ctrl + z：挂起命令

Bang (!) 命令
!!：执行上一条命令
!blah：执行最近的以 blah 开头的命令，如 !ls
!blah:p：仅打印输出，而不执行
!$：上一条命令的最后一个参数，与 Alt + . 相同
!$:p：打印输出 !$ 的内容
!*：上一条命令的所有参数
!:p：打印输出 ! 的内容
^blah：删除上一条命令中的 blah
^blah^foo：将上一条命令中的 blah 替换为 foo
^blah^foo^：将上一条命令中所有的 blah 都替换为 foo

_友情提示_：
以上介绍的大多数 Bash 快捷键仅当在 emacs 编辑模式时有效，若你将 Bash
配置为 vi 编辑模式，那将遵循 vi 的按键绑定。Bash 默认为 emacs
编辑模式。如果你的 Bash 不在 emacs 编辑模式，可通过 set -o emacs 设置。
^S、^Q、^C、^Z 是由终端设备处理的，可用 stty 命令设置。


## VIM
### 删除所有只有空白的行

:g/^$/d

### 只保留匹配内容行而删除其他行
:v/pattern/d

### 对每行只保留匹配内容而删除这一行中的其它内容
:%s/^.*pattern.*$/\1/g

### 删除包含特定字符串的行
:g/pattern/d

### 删除包含特定字符串的行,每次删除前都提示
:%s/^.*pattern.*\n//c

在命令模式下粘贴命令
Shift-Insert
or Ctrl-R

替换
:%s/^3/2/g

列出匹配行
例如列出所有包含substr的行，在vim命令模式下输入：
:g/substr/p

重定向输出(">"为写，">>"为追加)
:redir > result.txt
exec your command
:redir END

统计匹配个数
:help count-items
:50,100s/\<data\>//gn
