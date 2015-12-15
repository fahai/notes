# Redis

## Install  
可能需要root权限
find / -name 'redis*' ------ 在根目录下查找名称中含有redis的文件.  
Redis的版本选取目前的稳定版本2.8.9。 客户端选用了Redis的Java版本jedis 2.4.2。  
```  
$ find / -name 'redis*'
$ wget http://labfile.oss.aliyuncs.com/files0422/redis-2.8.9.tar.gz  
$ tar xvfz redis-2.8.9.tar.gz
$ cd redis-2.8.9
$ make
$ make install  
```  

在安装成功之后，可以运行测试，确认Redis的功能是否正常    
`$ make test`
将可执行文件放置在$PATH环境目录下，便于以后执行程序时可以不用输入完整的路径    
```   
$　cp redis-server /usr/local/bin/
$　cp redis-cli /usr/local/bin/
```  
启动Redis  
`$ redis-server`  
查看Redis进程  
```  
$ ps -ef | grep redis
$ netstat -nlt|grep 6379
```  
启动redis-cli  
`$ redis-cli`

## Redis数据类型  

### String  
- 常用命令  
set:设置一个key-value
get:获取对应key的value值
mset:多个key-value的设置
mget:获取value数组
del:删除一个key

- 实操例子  
```  
shiyanlou:src/ $ redis-cli
127.0.0.1:6379> set fahai "dashi"
OK
127.0.0.1:6379> get fahai
"dashi"
127.0.0.1:6379> mset a 1 b 2 c 3
OK
127.0.0.1:6379> mget a b c
1) "1"
2) "2"
3) "3"
127.0.0.1:6379>     
```

- 文字说明  
字符串是一种最基本的Redis值类型。Redis字符串是二进制安全的，这意味着一个Redis字符串能包含任意类型的数据，例如： 一张JPEG格式的图片或者一个序列化的Ruby对象。一个字符串类型的值最多能存储512M字节的内容。  
Redis可以运用MSET and MGET 命令完成一次性的完成多个key-value的对应关系，使用MGET命令，Redis返回一个value数组。   

### List  
- 常用命令  
lpush:插入一个新的元素到头部，即列表的左边；
rpush:插入一个新的元素到尾部，即列表的右边；
lrange:查看一定范围的元素；
lpop:取出列表头部的素，即左边的第一个元素；
rpop:取出列表尾部的素，即右边的第一个元素；

- 实操例子  
```  
127.0.0.1:6379> rpush myList A
(integer) 1
127.0.0.1:6379> rpush myList B
(integer) 2
127.0.0.1:6379> lpush myList firstValue
(integer) 3
127.0.0.1:6379> rpush mylist caseSentive
(integer) 1
127.0.0.1:6379> lrange myList 0 -1
1) "firstValue"
2) "A"
3) "B"
127.0.0.1:6379> rpop myList
"B"
127.0.0.1:6379> lrange myList 0 -1
1) "firstValue"
2) "A"
127.0.0.1:6379> lpop myList
"firstValue"
127.0.0.1:6379> lrange myList 0 -1
1) "A"
127.0.0.1:6379>
```  

- 文字说明  
Redis列表是简单的字符串列表，按照插入顺序排序。你可以添加一个元素导列表的头部（左边）或者尾部（右边） LPUSH 命令插入一个新的元素到头部, 而 RPUSH插入一个新元素到尾部.当一个这两个操作在一个空的Key上被执行的时候一个新的列表被创建。相似的，如果一个列表操作清空一个列表那么对应的key将被从key空间删除。  
在Redis的命令操作中，还有一类重要的操作：POP，取出list元素。和PUSH操作类似，POP命令可以选择不同的方向取出元素.POP命令返回值为取出的元素。

### Hashes  
- 常用命令  
hmset:设置一个多域的hash表;  
hget:获取指定的单域;  
hmget:类似于HGET，获取指定的多域;  
hgetall:获取指定key的所有信息;  

- 实操例子  
```  
127.0.0.1:6379> hmset user username fahai age 18
OK
127.0.0.1:6379> hget user username
"fahai"
127.0.0.1:6379> hgetall user
1) "username"
2) "fahai"
3) "age"
4) "18"
127.0.0.1:6379> hmget user username age
1) "fahai"
2) "18"
127.0.0.1:6379>
```  
- 文字说明  
Redis Hashes是字符串字段和字符串值之间的映射,因此他们是展现对象的完美数据类型。 (例如:一个有名，姓，年龄等等属性的用户):一个带有一些字段的hash仅仅需要一块很小的空间存储,因此你可以存储数以百万计的对象在一个小的Redis实例中。 哈希主要用来表现对象，他们有能力存储很多对象，因此你可以将哈希用于许多其他的任务。


### Set  
- 常用命令  
sadd:生成一个无序集合
smembers:查看集合的元素  
sismember:判断集合是否存在指定元素。匹配成功返回1，匹配失败返回0；

- 实操例子  
```  
127.0.0.1:6379> sadd myset a b c
(integer) 3
127.0.0.1:6379> smembers myset
1) "c"
2) "a"
3) "b"
127.0.0.1:6379> sismember myset a
(integer) 1
127.0.0.1:6379> sismember myset d
(integer) 0
127.0.0.1:6379>
```  
- 文字说明  
Redis 集合（Set）是一个无序的字符串集合. 你可以以O(1)的时间复杂度 (无论集合中有多少元素时间复杂度都是常量)完成添加，删除，以及测试元素是否存在。 Redis 集合拥有令人满意的不允许包含相同成员的属性。多次添加相同的元素，最终在集合里只会有一个元素。 实际上说这些就是意味着在添加元素的时候无须检测元素是否存在。 一个Redis集合的非常有趣的事情是他支持一些服务端的命令从现有的集合出发去进行集合运算，因此你可以在非常短的时间内进行合并（unions）, 求交集（intersections）,找出不同的元素（differences of sets）。  

### 有序集合  
- 常用命令  
zadd:与sadd类似，多了一个用于排序的权值参数
zrange:查看正序的集合
zrevrange:查看反序的集合

- 实操例子  
```  
127.0.0.1:6379> zadd hackers 1990 fahai
(integer) 1
127.0.0.1:6379> zadd hackers 1995 dashi
(integer) 1
127.0.0.1:6379> zadd hackers 2000 wubian
(integer) 1
127.0.0.1:6379> zrange hackers
(error) ERR wrong number of arguments for 'zrange' command
127.0.0.1:6379> zrange hackers 0 -1
1) "fahai"
2) "dashi"
3) "wubian"
127.0.0.1:6379> zrevrange hackers 0 -1
1) "wubian"
2) "dashi"
3) "fahai"
127.0.0.1:6379> zrange hackers 0 -1 withscores
1) "fahai"
2) "1990"
3) "dashi"
4) "1995"
5) "wubian"
6) "2000"
127.0.0.1:6379>   
```  

- 文字说明  
Redis有序集合与普通集合非常相似，是一个没有重复元素的字符串集合。不同之处是有序集合的没有成员都关联了一个评分，这个评分被用来按照从最低分到最高分的方式排序集合中的成员。集合的成员是唯一的，但是评分可以是重复了。 使用有序集合你可以以非常快的速度（O(log(N))）添加，删除和更新元素。因为元素是有序的, 所以你也可以很快的根据评分（score）或者次序（position）来获取一个范围的元素。访问有序集合的中间元素也是非常快的,因此你能够使用有序集合作为一个没有重复成员的智能列表。在有序集合中，你可以很快捷的访问一切你需要的东西：有序的元素，快速的存在性测试，快速访问集合的中间元素！ 简而言之使用有序集合你可以做完成许多对性能有极端要求的任务，而那些任务使用其他类型的数据库真的是很难完成的。  

See Aslo:
http://redis.io/topics/data-types-intro  


## Redis系统管理  
在Redis中，命令大小写不敏感。  

### 适合全体类型的常用命令  
| 命令        | 说明           |  
| ------------- |:-------------|  
| EXISTS key    | 判断一个key是否存在;存在返回 1;否则返回0 |
| DEL key      | 删除某个key,或是一系列key;DEL key1 key2 key3 key4。成功返回1，失败返回0（key值不存在）  |  
| TYPE key | 返回某个key元素的数据类型 ( none:不存在,string:字符,list,set,zset,hash)，key不存在返回空  |
| KEYS key—pattern |  返回匹配的key列表 (KEYS foo*:查找foo开头的keys) |  
| RANDOMKEY | 随机获得一个已经存在的key，如果当前数据库为空，则返回空字符串 |  
| CLEAR | 清除界面 |
| RENAME oldname newname | 改key的名字，新键如果存在将被覆盖 |  
| RENAMENX oldname newname | 更改key的名字，如果名字存在则更改失败 |


### 时间相关命令  
（1）限定key生存时间

这同样是一个无视数据类型的命令，对于临时存储很有用处。避免进行大量的DEL操作。

EXPIRE：设置某个key的过期时间（秒）,(EXPIRE bruce 1000：设置bruce这个key1000秒后系统自动删除)注意：如果在还没有过期的时候，对值进行了改变，那么那个值会被清除。

（2）查询key剩余生存时间

限时操作可以再SET命令中实现，并且可用TTL命令查询key剩余生存时间。 TTL：查找某个key还有多长时间过期,返回时间秒
127.0.0.1:6379> set b haha ex 30
OK
127.0.0.1:6379> ttl b
(integer) 27
127.0.0.1:6379> ttl b
(integer) 26
127.0.0.1:6379>

（3）清除key

FLUSHDB：清空当前数据库中的所有键

FLUSHALL：清空所有数据库中的所有键


## Redis设置相关命令  
Redis有其配置文件，可以通过client-command窗口查看或者更改相关配置。相关命令介绍如下：

（1）CONFIG GET and CONFIG SET
CONFIG GET：用来读取运行Redis服务器的配置参数。 CONFIG SET：用于更改运行Redis服务器的配置参数。 AUTH : 认证密码 下面针对Redis密码的示例：

> config get requirepass （查看密码）

> config set requirepass test123 （设置密码为test123 ）

> config get requirepass  （报错，没有认证）

> auth test123

> config get requirepass

（2）重置报告
CONFIG RESETSTAT：重置数据统计报告，通常返回值为'OK"。


四、查询信息
INFO [section] ：查询Redis相关信息。 INFO命令可以查询Redis几乎所有的信息，其命令选项有如下：

server: Redis server的常规信息
clients: Client的连接选项
memory: 存储占用相关信息
persistence: RDB and AOF 相关信息
stats: 常规统计
replication: Master/slave请求信息
cpu: CPU 占用信息统计
cluster: Redis 集群信息
keyspace: 数据库信息统计
all: 返回所有信息
default: 返回常规设置信息
若命令参数为空，info命令返回所有信息。  

http://redis.io/commands/config-resetstat


## Redis的高级应用  
一、安全性
设置在客户端连接是需要指定的密码（由于redis速度相当的快，一秒钟可以150K次的密码尝试，所以需要设置一个密码强度很大的密码）。

设置密码的方式有两种：

（1） 使用config set 命令的requirepass 参数，具体格式为config set requirepass “password”。 （2） 配置redis.conf 中设置requirepass属性，后面为密码。

输入认证的方式也有两种：

（1） 登录时可以 redis-cli -a password

（2）登录后使用 auth password

（1）设置密码
第一种密码设置方式在上一个实验中已经提到，（在CONFIG SET命令讲解的实例），此处我们来看看第二种方式设置密码。

首先需要进入Redis的安装目录，然后修改配置文件redis.conf。根据grep命令的结果，使用vi编辑器修改“# requirepass foobared” 为“requirepass test123”，然后保存退出。

$ grep -n requirepass /etc/redis/redis.conf
$ sudo vim /etc/redis/redis.conf
编辑redis.conf的结果：



（2）重启redis-server 与redis-cli
重启redis server。

$ sudo service redis-server restart
进入到redis-cli交互界面进行验证

$ redis-cli

> info

> auth test123

> info

> exit
操作截图：

图片描述信息

结果表明第一次info命令失败，在auth认证之后info命令正常返回。最后退出redis-cli。

另外一种密码认证方式：


$ redis-cli -a test123

> info
操作截图：

图片描述信息

二、主从复制
由于环境的原因，在此处笔者大致讲解主从复制的工作流程，不做实验。

Redis的主从复制配置和使用都比较简单，通过主从复制可以允许多个slave server拥有和master server相同的数据库副本。

从服务器只能读，不能写。

Redis主从复制特点：

1、master可以拥有多个slave。

2、多个slave可以连接同一个master外，还可以连接到其他的slave。（当master宕机后，相连的slave转变为master）

3、主从复制不会阻塞master，再同步数据时，master可以继续处理client请求。

4、提高了系统的可伸缩性。

Redis主从复制的过程：

1、Slave与master建立连接，发送sync同步命令。

2、 Master会启动一个后台进程，将数据库快照保存到文件中，同时Master主进程会开始收集新的写命令并缓存。

3、 后台完成保存后，就将此文件发送给Slave。

4、 Slave将此文件保存到磁盘上。

三、事务处理
Redis的事务处理比较简单。只能保证client发起的事务中的命令可以连续的执行，而且不会插入其他的client命令，当一个client在连接中发出multi命令时，这个连接就进入一个事务的上下文，该连接后续的命令不会执行，而是存放到一个队列中，当执行exec命令时，redis会顺序的执行队列中的所有命令。如果其中执行出现错误，执行正确的不会回滚，不同于关系型数据库的事务。

> multi

> set name a

> set name b

> exec

> get name
操作截图：

图片描述信息

四、持久化机制
Redis是一个支持持久化的内存数据库，Redis需要经常将内存中的数据同步到磁盘来保证持久化。

Redis支持两种持久化方式：

1、snapshotting（快照），将数据存放到文件里，默认方式。

是将内存中的数据已快照的方式写入到二进制文件中，默认文件dump.rdb，可以通过配置设置自动做快照持久化的方式。可配置Redis在n秒内如果超过m个key被修改就自动保存快照。

save 900 1 #900秒内如果超过1个key被修改，则发起快照保存

save 300 10 #300秒内如果超过10个key被修改，则快照保存

2、 Append-only file（缩写为aof），将读写操作存放到文件中。

由于快照方式在一定间隔时间做一次，所以如果Redis意外down掉的话，就会丢失最后一次快照后的所有修改。

aof比快照方式有更好的持久化性，是由于使用aof时，redis会将每一个收到的写命令都通过write函数写入到文件中当redis启动时会通过重新执行文件中保存的写命令来在内存中重新建立整个数据库的内容。

由于os会在内核中缓存write做的修改，所以可能不是立即写到磁盘上，这样aof方式的持久化也还是有可能会丢失一部分数据。可以通过配置文件告诉redis我们想要通过fsync函数强制os写入到磁盘的时机。

配置文件中的可配置参数：

appendonly   yes     //启用aof持久化方式

#appendfsync  always //收到写命令就立即写入磁盘，最慢，但是保证了数据的完整持久化

appendfsync   everysec  //每秒中写入磁盘一次，在性能和持久化方面做了很好的折中

#appendfsync  no     //完全依赖os，性能最好，持久化没有保证
在redis-cli的命令中，SAVE命令是将数据写入磁盘中。

> help save

>save
操作截图：

图片描述信息
五、虚拟内存的使用
虚拟内存管理在2.6及之上版本取消了，在安装实验中，选择的是2.8.9版本的redis ，所有实验中的配置文件中没有虚拟内存管理功能的配置选项。此处仅为讲解

Redis的虚拟内存是暂时把不经常访问的数据从内存交换到磁盘中，从而腾出内存空间用于其他的访问数据，尤其对于redis这样的内存数据库，内存总是不够用的。除了分隔到多个redis server外，提高数据库的容量的方法就是使用虚拟内存，把那些不常访问的数据交换到磁盘上。

通过配置vm相关的redis.config配置：

vm-enable  yes                   #开启vm功能

vm-swap-file    /tmp/redis.swap  #交换出来的value保存的文件路径

vm-max-memory    10000000        #redis使用的最大内存上线

 vm-page-size   32       #每个页面的大小32字节

vm-pages     123217729    #最多使用多小个页面

vm-max-threads     4        #用于执行value对象换入的工作线程数量
参考文档
http://m.blog.csdn.net/blog/fengshizty/42936073#
