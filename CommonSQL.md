## MySQL常用SQL  

### 查看版本信息  
查看服务端：  
mysql>status;  
mysql>select version();
查看客户端：  
$mysql -V
$mysql --help | grep Distrib  

### 获取服务器当前时间  
mysql> select now();
mysql> select curtime();
mysql> select sysdate();
mysql> 
mysql> 
mysql> 
mysql> 
mysql> 

### 常用函数 
Chapter 12. Functions and Operators 
CONCAT 字符串拼接  
str_to_date 字符串转date
mysql> select str_to_date("2010-11-23 14:39:51",'%Y-%m-%d %H:%i:%s');

### limit的语法
select t.* from user limit startNumber, endNumber;

### 查询锁表
show OPEN TABLES where In_use > 0;

### 修改表名
alter table table_name rename table_new_name;

### mysql 子查询删除记录
使用mysql进行delete from操作时，若子查询的 FROM 字句和更新/删除对象使用同一张表，会出现错误。

mysql> DELETE FROM tab1 WHERE col1 = ( SELECT MAX( col1 ) FROM tab1 );
ERROR 1093 (HY000): You can’t specify target table ‘tab1′ for update in FROM clause

针对“同一张表”这个限制，撇开效率不谈，多数情况下都可以通过多加一层select 别名表来变通解决，像这样
DELETE FROM tab1
WHERE col1 = (
SELECT MAX( col1 )
FROM (
SELECT * FROM tab1
) AS t
);

可以通过临时表来解决。

### 创建触发器
CREATE TRIGGER `trib_css_sms` BEFORE INSERT ON `css_sms` FOR EACH ROW BEGIN
	SET @msg_type = RIGHT(NEW.SEND_MSG_TYPE, 2);
	SET @remsg = REPLACE(NEW.RECEIVE_MSG, '+', '');
	SET @remsg = REPLACE(@remsg, '＋', '');
	SET @remsg = LOWER(@remsg);
	SET @re_type = LEFT(@remsg, 2);
	IF(@msg_type = 'YM') THEN
		IF(@msg_type = 'cd') THEN
			SET NEW.OPMODE = 2;
		ELSE
			IF(@msg_type <=> 'xd') THEN
				 SET new.OPMODE = 3;
			ELSE
				IF(@remsg = 'xd1' OR @remsg = 'xd2' OR @remsg = 'xd3' OR @remsg = 'xdy') THEN
					SET NEW.OPMODE = 1;
				ELSE
				 	SET NEW.OPMODE = 2;
				END IF;
			END IF;
		END IF;
	ELSE
		SET NEW.OPMODE = 2;
	END IF;
END


## 分区管理
http://www.simlinux.com/archives/133.html#i-10
http://blog.sina.com.cn/s/blog_5f54f0be01015tag.html
http://database.51cto.com/art/200905/123237.htm
http://www.cnblogs.com/silenceli/p/3592306.html








## Oracle常用SQL  
--- 

### 修改表结构
- 增加一个列
> ALTER TABLE 表名 ADD(列名,数据类型);
> ALTER TABLE custphone add (lang, VARCHAR2(4));

- 为表字段添加注释
> COMMENT ON COLUMN custphone.lang IS '电话号码的默认语种'; 

- 编辑表字段
> ALTER TABLE 表名 MODIFY 列名 数据类型;  

- 重命名列名
> ALTER TABLE 表名 RENAME COLUMN 当前列名 TO 新列名;  

- 删除一个列
> ALTER TABLE 表名 drop column 列名;
> ALTER TABLE TSS_ATTENDANCE drop column GROUPNAME;

- 重命名表名  
> ALTER TABLE 当前表名 RENAME TO 新表名;  


### 查询IVRLOG纯自助服务的数据  
```  
SELECT decode(t.BUSSTYPE, 'bill', '自助查询', 'porder', '自助下单', '其它') 类型,
       decode(t.isok, 1, '成功', '失败') 状态,
       count(*) 数量
  FROM IVRLOG T
WHERE t.BUSSTYPE in ('bill', 'porder') and t.ismanual='0'
   and t.CREATETIME >= to_date('18-09-2014 00:00:00', 'dd-mm-yyyy hh24:mi:ss')
and t.createtime < to_date('18-09-2014 23:59:59', 'dd-mm-yyyy hh24:mi:ss')
group by t.BUSSTYPE, t.isok;  
```  

### 查询IVRLOG每小时的来电数量  
```    
select to_char(i.createtime, 'hh24'),i.isok,count(*)
  from ivrlog i
where to_char(i.createtime, 'yyyy-mm-dd') = '2014-09-24'
and i.busstype='porder'
group by (to_char(i.createtime, 'hh24'), i.isok)
order by to_char(i.createtime, 'hh24');
```  



### Oracle删除当前用户下的所有表、视图、序列、函数、存储过程、包  
``` 
--delete tables 
select 'drop table ' || table_name ||';'||chr(13)||chr(10) from user_tables;   

--delete views 
select 'drop view ' || view_name||';'||chr(13)||chr(10) from user_views;   

--delete seqs 
select 'drop sequence ' || sequence_name||';'||chr(13)||chr(10) from user_sequences;  

--delete functions 
select 'drop function ' || object_name||';'||chr(13)||chr(10) from user_objects where object_type='FUNCTION';  

--delete procedure 
select 'drop procedure ' || object_name||';'||chr(13)||chr(10) from user_objects where object_type='PROCEDURE';   

--delete package 
select 'drop package ' || object_name||';'||chr(13)||chr(10) from user_objects where object_type='PACKAGE'; 
```  


### 查看Oracle版本  
``` 
select * from v$version;   
```  

### Oracle中查看所有表和字段以及表注释.字段注释
- 获取表  
> select table_name from user_tables; // 当前用户的表
> select table_name from all_tables; // 所有用户的表  
> select table_name from dba_tables; // 包括系统表
> select table_name from all_tables where owner='user'; // 指定用户的表  
- 获取表字段  
> select * from user_tab_columns where Table_Name='用户表';
- 获取表注释  
> select * from user_tab_comments;  
- 获取字段注释
> select * from user_col_comments;  

### 查询锁表  
- 
select sess.sid,
       sess.serial#,
       lo.oracle_username,
       lo.os_user_name,
       ao.object_name,
       lo.locked_mode
  from v$locked_object lo, dba_objects ao, v$session sess
 where ao.object_id = lo.object_id
   and lo.session_id = sess.sid;
   
   
alter system kill session 'sid,serial#';  


### plsql登录，提示框“没有登录”_oracle  
> 检查ORACLE_HOME环境变量，若无，添加之  
> 以管理员身份运行客户端的执行程序：例如"C:\Program Files\PLSQL Developer\PlSqlDev.exe"  


### 判断表是否存在，如果存在则删除
```  
declare 
      num   number; 
begin 
      select count(1) into num from all_tables where TABLE_NAME = 'EMP' and OWNER='SCOTT'; 
      if   num=1   then 
          execute immediate 'drop table EMP'; 
      end   if; 
end; 
/ 
CREATE TABLE EMP
       (EMPNO NUMBER(4) NOT NULL,
        ENAME VARCHAR2(10),
        JOB VARCHAR2(9),
        MGR NUMBER(4),
        HIREDATE DATE,
        SAL NUMBER(7, 2),
        COMM NUMBER(7, 2),
        DEPTNO NUMBER(2));
```  

### 查看序列的当前值
select * from dba_sequences where  sequence_name='SEQ_TSS_CUSTOMER_BASE' AND SEQUENCE_OWNER = 'TSS';
或者  
查看该序列的定义的start with值  
note: 不能修改序列对象的当前值。除非删除重新创建  



### 查询和编辑外键
```  
-- 查询删除所有外键约束的记录 
select 'alter table ' || table_name || ' drop constraint ' ||
       constraint_name || ';'
  from user_constraints
 where constraint_type = 'R';
 
-- 查询禁用外键约束的记录 
select 'alter table ' || table_name || ' disable constraint ' ||
       constraint_name || ';'
  from user_constraints
 where constraint_type = 'R';

-- 查询启用外键约束的记录 
select 'alter table ' || table_name || ' enable constraint ' ||
       constraint_name || ';'
  from user_constraints
 where constraint_type = 'R';

```  

### 备份和恢复  
http://www.2cto.com/database/201305/210262.html 
http://blog.sina.com.cn/s/blog_65a2b63201011720.html

drop table TSS_CALL_RECORD;
drop table TSS_RECYCLE_DETAIL;
drop table TSS_DISTRIBUTE_DETAIL;
drop table TSS_FORM_SUBMIT_RECORD;
drop table TSS_RESERVE_RECORD;
drop table TSS_CUSTOMIZED_FIELD_VALUES;
drop table TSS_CUSTOMER_BASE;
drop table TSS_IMP_RECORD; 


imp tss/tss_admin@sit38 file=e:\tss20150113.dmp tables=(TSS_CALL_RECORD,TSS_RECYCLE_DETAIL,TSS_DISTRIBUTE_DETAIL,TSS_FORM_SUBMIT_RECORD,TSS_RESERVE_RECORD,TSS_CUSTOMIZED_FIELD_VALUES)

imp tss/tss_admin@sit38 file=d:\tss20150113.dmp tables=(TSS_CUSTOMER_BASE, TSS_IMP_RECORD)

### Oracle-sqlplus导入sql文件  
使用PLSQL Developer导入insert语句，数据量过大会死掉，所以直接使用命令行的方式导入insert语句

命令行进入sqlplus：
sqlplus 用户名/密码@127.0.0.1:1521/tiger
sql>@full_path/test.sql;   

例：sql>@D:/test.sql; 
test.sql 里面最后加上一个commit;


## 查询锁表的SQL  
SELECT /*+ rule */ s.username,
decode(l.type,'TM','TABLE LOCK',
'TX','ROW LOCK',
NULL) LOCK_LEVEL,
o.owner,o.object_name,o.object_type,
s.sid,s.serial#,s.terminal,s.machine,s.program,s.osuser
FROM v$session s,v$lock l,dba_objects o
WHERE l.sid = s.sid
AND l.id1 = o.object_id(+)
AND s.username is NOT NULL  

> 杀进程  
alter system kill session '235,59729';


## 备份数据到备份表
-- 新建备份表
create table tss_call_record_bak as
  select * from tss_call_record where 1 = 2;
-- 备份呼叫历史表数据
insert into tss_call_record_bak
select * from tss_call_record tcr where tcr.project_id = ioldid;
commit;


## 语句块实例
```  
declare
  inewid Number;
  ioldid Number;
begin
  inewid := 0;
  ioldid := 0;
  select tp.id into inewid from tss_prj tp where tp.name = '客户维护项目-日常维护';
  select tp.id into ioldid from tss_prj tp where tp.name = '客户维护项目-异动';
  
  update tss_call_record tcr
     set tcr.project_id = inewid
  where tcr.project_id = ioldid;  
  commit;     
                 
  update tss_attention_record tar 
     set tar.project_id = inewid
  where tar.project_id = ioldid; 
  commit;
  
  update tss_reserve_record trr
      set trr.project_id = inewid
  where trr.project_id  = ioldid;
  commit;
end;
```  



## SQL 怎么把这四个列合并成三个列
select tdr.to_id, count(tdd.id)
  from tss.tss_distribute_record tdr, tss.tss_distribute_detail tdd
 where tdr.project_id = 60358179
   and tdr.finished_flag = 1
   and tdr.id = tdd.dist_id
   and tdr.dist_type <> 'P'
   group by tdr.to_id;

select tcr.creater, count(tcr.customer_id)
  from tss.tss_call_record tcr
 where tcr.project_id = 60358179
   group by tcr.creater;


查询结果1		查询结果2					合并结果
sfit0676	15	sfit0676	21				sfit0676	15 	21
660786		6	660786		9		--> 	660786		6 	9
660789		1								660789		1 	0
		
解决方案：
select a.to_id, a.dist_num, b.call_num
  from (select tdr.to_id, count(tdd.id) dist_num
          from tss.tss_distribute_record tdr, tss.tss_distribute_detail tdd
         where tdr.project_id = 60358179
           and tdr.finished_flag = 1
           and tdr.id = tdd.dist_id
           and tdr.dist_type <> 'P'
         group by tdr.to_id) a,
       (select tcr.creater, count(tcr.customer_id) call_num
          from tss.tss_call_record tcr
         where tcr.project_id = 60358179
         group by tcr.creater) b
 where a.to_id = b.creater(+);

 注意(+)的语法

 ## 只更新字段的日期部分
 比如有数据库字段FTime，类型为DateTime，现在想将日期部分统一更新成'1900-01-01'（即不关心日期），具体做法如下：
Update T1 set FTime = to_date('1900-01-01' || to_char(FTime,'HH24:mi:ss'),'yyyy-MM-dd HH24:mi:ss');
执行即可。


### in 和 exists
对于in 和 exists的性能区别: 
  如果子查询得出的结果集记录较少，主查询中的表较大且又有索引时应该用in,反之如果外层的主查询记录较少，子查询中的表大，又有索引时使用exists。 
  其实我们区分in和exists主要是造成了驱动顺序的改变（这是性能变化的关键），如果是exists，那么以外层表为驱动表，先被访问，如果是IN，那么先执行子查询，所以我们会以驱动表的快速返回为目标，那么就会考虑到索引及结果集的关系了 
另外IN时不对NULL进行处理 
如： 
select 1 from dual where null in (0,1,2,null);
为空

对于not in 和 not exists的性能区别： 
  not in 只有当子查询中，select 关键字后的字段有not null约束或者有这种暗示时用not in,另外如果主查询中表大，子查询中的表小但是记录多，则应当使用not in,并使用anti hash join. 
  如果主查询表中记录少，子查询表中记录多，并有索引，可以使用not exists,另外not in最好也可以用/*+ HASH_AJ */或者外连接+is null 
NOT IN 在基于成本的应用中较好 


http://www.cnblogs.com/yf520gn/archive/2009/01/12/1374359.html





数据接口监控
callInterfaceCountInfo对象对于监控数据量的不通用
totalCount，总次数如何定义

数据库监控的端口和服务名是否做成配置(3306和mysqld)

与monitor-6 单采集信息提交API的区别

ccs-monitor-client读取ccs-config下的sysconfig.properties的路径配置方法



集成模块五分钟统计一次，怎么与ccs-monitor-client采集的信息同步上报到ccs-monitor-core

private String systemName;
private String interfaceName;
private long executeTime;
private int executeResult;



private String alarmLevel;
private String alarmCode;
private String alarmContent;


INSERT INTO `ccs5`.`param_config` (`paramType`, `paramKey`, `paramValue`, `sortNum`, `status`, `remark`, `editor`, `editTime`, `creater`, `createTime`, `ISSHOWTOPAGE`) VALUES ('8', 'INTERFACE_INFO_REPORT', 'http://10.118.132.116:8083/monitor/reportAlarmInfo.pub', '1', '1', 'monitor-6 单采集信息提交API', '449631', '2015-10-02 11:57:46', 'system', '2015-10-02 11:57:46', 'Y');



	// 最大执行时间
	private String largeExecuteTime;
	// 平均执行时间
	private String avgExecuteTime;
	// 执行失败次数
	private String failedCount;
	// 执行总次数
	private String totalCount;




	// 执行时间
	private Long executeTime;
	// 执行结果
	private Integer executeResult;


	
add: fahai: 1
add: dahsi: 106
add: wubian: 1
add: fahai: 1
add: dahsi: 1
add: wubian: 1
add: fahai: 1


save: fahai: 5
save: dahsi: 105
save: wubian: 2005
save: fahai: 1
save: dahsi: 0
save: wubian: 1
save: fahai: 1
save: dahsi: 1
save: wubian: 1	


验证executePostAndGetString方法


