# Middleware-development-database
后端中间组件开发——MySQL、Redis和Ngix

# MySQL学习笔记（1）

 - 根据[老杜带你学_mysql入门基础（mysql基础视频+数据库实战)](https://www.bilibili.com/video/BV1Vy4y1z7EX?p=48&spm_id_from=pageDriver)整理的学习笔记

## 1.安装
在安装过程中，发现遇到了非常多的问题

 - [MySql和navicat完整安装使用](https://blog.csdn.net/weixin_42474930/article/details/82053523)
 - ==[新版本MySQl修改密码提示语法错误解决办法](https://blog.csdn.net/weixin_44341938/article/details/101684573)==
 - [MySQL8.0给新用户增加权限](https://blog.csdn.net/yl_mouse/article/details/93709312?spm=1001.2101.3001.6650.3&depth_1-utm_relevant_index=6)
 - [mysql安装navicat之后，出现2059，Authentication   
   plugin。以及本地链接虚拟机docker，远程链接服务器](https://blog.csdn.net/weixin_37127253/article/details/83279162)
 - [【VSCode管理MySql数据库](https://blog.csdn.net/sD7O95O/article/details/105479465)
## 2.基本概念
### 2.1 数据库、数据库管理系统、SQL 
#### 2.1.1 数据库：
	英文单词DataBase，简称DB。按照一定格式存储数据的一些文件的组合。顾名思义：存储数据的仓库，实际上就是一堆文件。这些文件中存储了具有特定格式的数据。
#### 2.1.2 数据库管理系统：
	DataBaseManagement，简称DBMS。数据库管理系统是专门用来管理数据库中数据的，数据库管理系统可以对数据库当中的数据进行增删改查。
	常见的数据库管理系统：MySQL、Oracle、MS SqlServer、DB2、sybase等....
#### 2.1.3 SQL：结构化查询语言
	程序员需要学习SQL语句，程序员通过编写SQL语句，然后DBMS负责执行SQL语句，最终来完成数据库中数据的增删改查操作。SQL是一套标准，程序员主要学习的就是SQL语句，这个SQL在mysql中可以使用，同时在Oracle中也可以使用，在DB2中也可以使用。
	* 三者之间的关系？
	==DBMS--执行--> SQL --操作--> DB==
	先安装数据库管理系统MySQL，然后学习SQL语句怎么写，编写SQL语句之后，DBMS对SQL语句进行执行，最终来完成数据库的数据管理。
#### 2.1.4 数据库元素
	数据库当中最基本的单元是表：table
	任何一张表都有行和列：
		行（row）：被称为数据/记录。
		列（column）：被称为字段。	
### 2.2 SQL语句分类
#### 2.2.1 DQL：
	数据查询语言（凡是带有select关键字的都是查询语句）
	select...
#### 2.2.2 DML：
	数据操作语言（凡是对表当中的数据进行增删改的都是DML）
	insert delete update
	insert 增
	delete 删
	update 改
	这个主要是操作表中的数据data。
#### 2.2.3 DDL：
	数据定义语言凡是带有create、drop、alter的都是DDL。DDL主要操作的是表的结构。不是表中的数据。
	create：新建，等同于增
	drop：删除
	alter：修改
	这个增删改和DML不同，这个主要是对表结构进行操作。
#### 2.2.4 TCL：
	事务控制语言
	包括：
		事务提交：commit;
		事务回滚：rollback;
#### 2.2.5 DCL：
	数据控制语言。
	例如：授权grant、撤销权限revoke....
## 3 常用命令
每一条命令需要以 ; 为结尾
#### 3.1. 查看mysql中有哪些数据库
```sql
show databases;
Query OK, 1 row affected (0.00 sec)
+--------------------+
| Database           |
+--------------------+
| bjpowernode        |
| hewei              |
| information_schema |
| mysql              |
| performance_schema |
| sys                |
| t_student          |
+--------------------+
```
#### 3.2. 使用某个数据库
```sql
mysql> use bjpowernode;
Database changed
```
#### 3.3.  创建数据库与
```sql
create database bjpowernode;
```
#### 3.4. 加载数据库
```sql
source C: \ Users \ HEWEI \ Desktop \ document \ bjpowernode.sql;
```
#### 3.5. 表 
```sql
show tables;
+-----------------------+
| Tables_in_bjpowernode |
+-----------------------+
| dept                  |
| emp                   |
| salgrade              |
| t_class               |
| t_student             |
+-----------------------+
```
#### 3.6. 看表结构 
```sql
desc dept;
+--------+-------------+------+-----+---------+-------+
| Field  | Type        | Null | Key | Default | Extra |
+--------+-------------+------+-----+---------+-------+
| DEPTNO | int         | NO   | PRI | NULL    |       |部门编号
| DNAME  | varchar(14) | YES  |     | NULL    |       |部门名字
| LOC    | varchar(13) | YES  |     | NULL    |       |地理位置
+--------+-------------+------+-----+---------+-------+
desc emp;
+----------+-------------+------+-----+---------+-------+
| Field    | Type        | Null | Key | Default | Extra |
+----------+-------------+------+-----+---------+-------+
| EMPNO    | int(4)      | NO   | PRI | NULL    |       |员工编号
| ENAME    | varchar(10) | YES  |     | NULL    |       |员工姓名
| JOB      | varchar(9)  | YES  |     | NULL    |       |工作岗位
| MGR      | int(4)      | YES  |     | NULL    |       |上级编号
| HIREDATE | date        | YES  |     | NULL    |       |入职日期
| SAL      | double(7,2) | YES  |     | NULL    |       |工资
| COMM     | double(7,2) | YES  |     | NULL    |       |补助
| DEPTNO   | int(2)      | YES  |     | NULL    |       |部门编号
+----------+-------------+------+-----+---------+-------+
desc salgrade;
+-------+---------+------+-----+---------+-------+
| Field | Type    | Null | Key | Default | Extra |
+-------+---------+------+-----+---------+-------+
| GRADE | int(11) | YES  |     | NULL    |       |工资等级
| LOSAL | int(11) | YES  |     | NULL    |       |最低工资
| HISAL | int(11) | YES  |     | NULL    |       |最高工资
+-------+---------+------+-----+---------+-------+
```
#### 3.7. 退出mysql  
```sql
exit;
```
#### 3.8. 查看版本
```sql
select version();
+-----------+
| version() |
+-----------+
| 8.0.28    |
+-----------+
```
#### 3.9. 查看版本
```sql
select database();
+-------------+
| database()  |
+-------------+
| bjpowernode |
+-------------+
```
#### 3.10. 查看表中数据(这种形式不推荐)
```sql
select * from EMP;
+-------+--------+-----------+------+------------+---------+---------+--------+
| EMPNO | ENAME  | JOB       | MGR  | HIREDATE   | SAL     | COMM    | DEPTNO |
+-------+--------+-----------+------+------------+---------+---------+--------+
|  7369 | SMITH  | CLERK     | 7902 | 1980-12-17 |  800.00 |    NULL |     20 |
|  7499 | ALLEN  | SALESMAN  | 7698 | 1981-02-20 | 1600.00 |  300.00 |     30 |
|  7521 | WARD   | SALESMAN  | 7698 | 1981-02-22 | 1250.00 |  500.00 |     30 |
|  7566 | JONES  | MANAGER   | 7839 | 1981-04-02 | 2975.00 |    NULL |     20 |
|  7654 | MARTIN | SALESMAN  | 7698 | 1981-09-28 | 1250.00 | 1400.00 |     30 |
|  7698 | BLAKE  | MANAGER   | 7839 | 1981-05-01 | 2850.00 |    NULL |     30 |
|  7782 | CLARK  | MANAGER   | 7839 | 1981-06-09 | 2450.00 |    NULL |     10 |
|  7788 | SCOTT  | ANALYST   | 7566 | 1987-04-19 | 3000.00 |    NULL |     20 |
|  7839 | KING   | PRESIDENT | NULL | 1981-11-17 | 5000.00 |    NULL |     10 |
|  7844 | TURNER | SALESMAN  | 7698 | 1981-09-08 | 1500.00 |    0.00 |     30 |
|  7876 | ADAMS  | CLERK     | 7788 | 1987-05-23 | 1100.00 |    NULL |     20 |
|  7900 | JAMES  | CLERK     | 7698 | 1981-12-03 |  950.00 |    NULL |     30 |
|  7902 | FORD   | ANALYST   | 7566 | 1981-12-03 | 3000.00 |    NULL |     20 |
|  7934 | MILLER | CLERK     | 7782 | 1982-01-23 | 1300.00 |    NULL |     10 |
+-------+--------+-----------+------+------------+---------+---------+--------+
```
```sql
select * from salgrade;
+-------+-------+-------+
| GRADE | LOSAL | HISAL |
+-------+-------+-------+
|     1 |   700 |  1200 |
|     2 |  1201 |  1400 |
|     3 |  1401 |  2000 |
|     4 |  2001 |  3000 |
|     5 |  3001 |  9999 |
+-------+-------+-------+
```
```sql
select *from dept;
+--------+------------+----------+
| DEPTNO | DNAME      | LOC      |
+--------+------------+----------+
|     10 | ACCOUNTING | NEW YORK |
|     20 | RESEARCH   | DALLAS   |
|     30 | SALES      | CHICAGO  |
|     40 | OPERATIONS | BOSTON   |
+--------+------------+----------+
```
#### 3.11. 查询字段
```sql
SELECT DNAME FROM DEPT;
+------------+
| DNAME      |
+------------+
| ACCOUNTING |
| RESEARCH   |
| SALES      |
| OPERATIONS |
+------------+
```
#### 3.12. 查询两个字段
```sql
select DEPTNO,
    DNAME deptname
from dept;
+--------+------------+
| deptno | dname      |
+--------+------------+
|     10 | ACCOUNTING |
|     20 | RESEARCH   |
|     30 | SALES      |
|     40 | OPERATIONS |
+--------+------------+
```
#### 3.13. 给字段起别名
```sql
select deptno,dname as deptname from dept;
+--------+------------+
| deptno | deptname   |
+--------+------------+
|     10 | ACCOUNTING |
|     20 | RESEARCH   |
|     30 | SALES      |
|     40 | OPERATIONS |
+--------+------------+
```

### 4 条件查询
	不是将表中所有数据都查出来。是查询出来符合条件的。
		语法格式：
			select
				字段1,字段2,字段3....
			from 
				表名
			where
				条件;
#### 4.1	= 等于
```sql
查询薪资等于800的员工姓名和编号
	select empno,ename from emp where sal = 800;
查询SMITH的编号和薪资？
	select empno,sal from emp where ename = 'SMITH'; //字符串使用单引号
```
#### 4.2 <>或!= 不等于
```sql
查询薪资不等于800的员工姓名和编号
	select empno,ename from emp where sal != 800;
	select empno,ename from emp where sal <> 800; // 小于号和大于号组成的不等号
```
#### 4.3 < 小于
```sql
	查询薪资小于2000的员工姓名和编号？
mysql> select empno,ename,sal from emp where sal < 2000;
	+-------+--------+---------+
	| empno | ename  | sal     |
	+-------+--------+---------+
	|  7369 | SMITH  |  800.00 |
	|  7499 | ALLEN  | 1600.00 |
	|  7521 | WARD   | 1250.00 |
	|  7654 | MARTIN | 1250.00 |
	|  7844 | TURNER | 1500.00 |
	|  7876 | ADAMS  | 1100.00 |
	|  7900 | JAMES  |  950.00 |
	|  7934 | MILLER | 1300.00 |
	+-------+--------+---------+
```
#### 4.4 <= 小于等于
```sql
查询薪资小于等于3000的员工姓名和编号？
	select empno,ename,sal from emp where sal <= 3000;
```

#### 4.5 > 大于
```sql
查询薪资大于3000的员工姓名和编号？
	select empno,ename,sal from emp where sal > 3000;
```
#### 4.6 >= 大于等于
```sql
查询薪资大于等于3000的员工姓名和编号？
	select empno,ename,sal from emp where sal >= 3000;
```

#### 4.7 between … and …. 两个值之间, 等同于 >= and <=
```sql
第一种方式：>= and <= （and是并且的意思。）
	select empno,ename,sal from emp where sal >= 2450 and sal <= 3000;
	+-------+-------+---------+
	| empno | ename | sal     |
	+-------+-------+---------+
	|  7566 | JONES | 2975.00 |
	|  7698 | BLAKE | 2850.00 |
	|  7782 | CLARK | 2450.00 |
	|  7788 | SCOTT | 3000.00 |
	|  7902 | FORD  | 3000.00 |
	+-------+-------+---------+
第二种方式：between … and …
	select 
		empno,ename,sal 
	from 
		emp 
	where 
		sal between 2450 and 3000;
```
#### 4.8 is null 为 null（is not null 不为空）
```sql
查询哪些员工的津贴/补助为null
select empno,ename,sal,comm from emp where comm = null;
Empty set (0.00 sec) --null使用=无效
select empno,ename,sal,comm from emp where comm is null;
+-------+--------+---------+------+
| empno | ename  | sal     | comm |
+-------+--------+---------+------+
|  7369 | SMITH  |  800.00 | NULL |
|  7566 | JONES  | 2975.00 | NULL |
|  7698 | BLAKE  | 2850.00 | NULL |
|  7782 | CLARK  | 2450.00 | NULL |
|  7788 | SCOTT  | 3000.00 | NULL |
|  7839 | KING   | 5000.00 | NULL |
|  7876 | ADAMS  | 1100.00 | NULL |
|  7900 | JAMES  |  950.00 | NULL |
|  7902 | FORD   | 3000.00 | NULL |
|  7934 | MILLER | 1300.00 | NULL |
+-------+--------+---------+------+
查询哪些员工的津贴/补助不为null？
select empno,ename,sal,comm from emp where comm is not null;
+-------+--------+---------+---------+
| empno | ename  | sal     | comm    |
+-------+--------+---------+---------+
|  7499 | ALLEN  | 1600.00 |  300.00 |
|  7521 | WARD   | 1250.00 |  500.00 |
|  7654 | MARTIN | 1250.00 | 1400.00 |
|  7844 | TURNER | 1500.00 |    0.00 |
+-------+--------+---------+---------+
```
#### 4.9 使用and
```sql
查询工作岗位是MANAGER并且工资大于2500的员工信息？
select 
	empno,ename,job,sal 
from 
	emp 
where 
	job = 'MANAGER' and sal > 2500;
+-------+-------+---------+---------+
| empno | ename | job     | sal     |
+-------+-------+---------+---------+
|  7566 | JONES | MANAGER | 2975.00 |
|  7698 | BLAKE | MANAGER | 2850.00 |
+-------+-------+---------+---------+
```
#### 4.10 使用or
```sql
查询工作岗位是MANAGER和SALESMAN的员工
select 
	empno,ename,job
from
	emp
where 
	job = 'MANAGER' or job = 'SALESMAN';
+-------+--------+----------+
| empno | ename  | job      |
+-------+--------+----------+
|  7499 | ALLEN  | SALESMAN |
|  7521 | WARD   | SALESMAN |
|  7566 | JONES  | MANAGER  |
|  7654 | MARTIN | SALESMAN |
|  7698 | BLAKE  | MANAGER  |
|  7782 | CLARK  | MANAGER  |
|  7844 | TURNER | SALESMAN |
+-------+--------+----------+
```
#### 4.11 使用in
```sql
in 包含，相当于多个 or （not in 不在这个范围中）
查询工作岗位是MANAGER和SALESMAN的员工？
	select empno,ename,job from emp where job = 'MANAGER' or job = 'SALESMAN';
	select empno,ename,job from emp where job in('MANAGER', 'SALESMAN');
	+-------+--------+----------+
	| empno | ename  | job      |
	+-------+--------+----------+
	|  7499 | ALLEN  | SALESMAN |
	|  7521 | WARD   | SALESMAN |
	|  7566 | JONES  | MANAGER  |
	|  7654 | MARTIN | SALESMAN |
	|  7698 | BLAKE  | MANAGER  |
	|  7782 | CLARK  | MANAGER  |
	|  7844 | TURNER | SALESMAN |
	+-------+--------+----------+
	注意：in不是一个区间。in后面跟的是具体的值。
```
#### 4.12 like 
模糊查询，支持%或下划线匹配
%匹配任意多个字符
下划线：任意一个字符。
（%是一个特殊的符号，_ 也是一个特殊符号）
```sql
找出名字中含有O的
mysql> select ename from emp where ename like '%O%';
+-------+
| ename |
+-------+
| JONES |
| SCOTT |
| FORD  |
+-------+
```
##### 4.12.1 找出名字以T结尾的？
```sql
select ename
from emp
where ename like '%T';
```
##### 4.12.2 找出名字以K开始的？
```sql
select ename
from emp
where ename like 'K%';
```
##### 4.12.3 找出第二个字每是A的？
```sql
select ename
from emp
where ename like '_A%';
```
##### 4.12.4 找出第三个字母是R的？
```sql
select ename
from emp
where ename like '__R%';
```
### 5 排序
####  5.1 查询所有员工薪资，排序
```sql
select 
	ename,sal
from
	emp
order by
	sal; // 默认是升序！！！
+--------+---------+
| ename  | sal     |
+--------+---------+
| SMITH  |  800.00 |
| JAMES  |  950.00 |
| ADAMS  | 1100.00 |
| WARD   | 1250.00 |
| MARTIN | 1250.00 |
| MILLER | 1300.00 |
| TURNER | 1500.00 |
| ALLEN  | 1600.00 |
| CLARK  | 2450.00 |
| BLAKE  | 2850.00 |
| JONES  | 2975.00 |
| FORD   | 3000.00 |
| SCOTT  | 3000.00 |
| KING   | 5000.00 |
+--------+---------+
```
#### 5.2 指定降序：
```sql
select 
	ename,sal
from
	emp
order by
	sal desc;
+--------+---------+
| ename  | sal     |
+--------+---------+
| KING   | 5000.00 |
| SCOTT  | 3000.00 |
| FORD   | 3000.00 |
| JONES  | 2975.00 |
| BLAKE  | 2850.00 |
| CLARK  | 2450.00 |
| ALLEN  | 1600.00 |
| TURNER | 1500.00 |
| MILLER | 1300.00 |
| MARTIN | 1250.00 |
| WARD   | 1250.00 |
| ADAMS  | 1100.00 |
| JAMES  |  950.00 |
| SMITH  |  800.00 |
+--------+---------+
```
#### 5.3 指定升序：
```sql
select 
	ename,sal
from
	emp
order by
	sal asc;
+--------+---------+
| ename  | sal     |
+--------+---------+
| SMITH  |  800.00 |
| JAMES  |  950.00 |
| ADAMS  | 1100.00 |
| WARD   | 1250.00 |
| MARTIN | 1250.00 |
| MILLER | 1300.00 |
| TURNER | 1500.00 |
| ALLEN  | 1600.00 |
| CLARK  | 2450.00 |
| BLAKE  | 2850.00 |
| JONES  | 2975.00 |
| FORD   | 3000.00 |
| SCOTT  | 3000.00 |
| KING   | 5000.00 |
+--------+---------+
```
#### 5.4 多个字段排序
```sql
查询员工名字和薪资，要求按照薪资升序，如果薪资一样的话，
再按照名字升序排列。
select 
	ename,sal
from
	emp
order by
	sal asc, ename asc; // sal在前，起主导，只有sal相等的时候，才会考虑启用ename排序。
+--------+---------+
| ename  | sal     |
+--------+---------+
| SMITH  |  800.00 |
| JAMES  |  950.00 |
| ADAMS  | 1100.00 |
| MARTIN | 1250.00 |
| WARD   | 1250.00 |
| MILLER | 1300.00 |
| TURNER | 1500.00 |
| ALLEN  | 1600.00 |
| CLARK  | 2450.00 |
| BLAKE  | 2850.00 |
| JONES  | 2975.00 |
| FORD   | 3000.00 |
| SCOTT  | 3000.00 |
| KING   | 5000.00 |
+--------+---------+
```
#### 5.5 根据字段的位置也可以排序
```sql
select ename,sal from emp order by 2; // 2表示第二列。第二列是sal
按照查询结果的第2列sal排序。
了解一下，不建议在开发中这样写，因为不健壮。
因为列的顺序很容易发生改变，列顺序修改之后，2就废了。
```
#### 5.6 综合案例：找出工资在1250到3000之间的员工信息，要求按照薪资降序排列。
```sql
找出工资在1250到3000之间的员工信息，要求按照薪资降序排列。
select 
	ename,sal
from
	emp
where
	sal between 1250 and 3000
order by
	sal desc;
+--------+---------+
| ename  | sal     |
+--------+---------+
| FORD   | 3000.00 |
| SCOTT  | 3000.00 |
| JONES  | 2975.00 |
| BLAKE  | 2850.00 |
| CLARK  | 2450.00 |
| ALLEN  | 1600.00 |
| TURNER | 1500.00 |
| MILLER | 1300.00 |
| MARTIN | 1250.00 |
| WARD   | 1250.00 |
+--------+---------+
关键字顺序不能变：
	select
		...
	from
		...
	where
		...
	order by
		...
	以上语句的执行顺序必须掌握：
		第一步：from
		第二步：where
		第三步：select
		第四步：order by（排序总是在最后执行！）
```
###  6 数据处理函数
#### 6.1 数据处理函数又被称为单行处理函数
	单行处理函数的特点：一个输入对应一个输出。
	和单行处理函数相对的是：多行处理函数。（多行处理函数特点：多个输入，对应1个输出！）

##### 6.2 常用函数
##### 6.2.1 lower 转换小写
```sql
select lower(ename) as ename
from emp;
+--------+
| ename  |
+--------+
| smith  |
| allen  |
| ward   |
| jones  |
| martin |
| blake  |
| clark  |
| scott  |
| king   |
| turner |
| adams  |
| james  |
| ford   |
| miller |
+--------+
```
##### 6.2.2 upper转换大写
```sql
select upper(name) as name
from t_student;
+----------+
| name     |
+----------+
| ZHANGSAN |
| LISI     |
| WANGWU   |
| JACK_SON |
+----------+
```
##### 6.2.3 substr 取子串（substr( 被截取的字符串, 起始下标,截取的长度)）
```sql
select substr(ename, 1, 1) as ename
from emp;
```
##### 6.2.4 concat函数进行字符串的拼接
```sql
select concat(empno,ename) 
from emp;
+---------------------+
| concat(empno,ename) |
+---------------------+
| 7369SMITH           |
| 7499ALLEN           |
| 7521WARD            |
| 7566JONES           |
| 7654MARTIN          |
| 7698BLAKE           |
| 7782CLARK           |
| 7788SCOTT           |
| 7839KING            |
| 7844TURNER          |
| 7876ADAMS           |
| 7900JAMES           |
| 7902FORD            |
| 7934MILLER          |
+---------------------+
```
##### 6.2.5 length 取长度
```sql
select length(ename) enamelength from emp;
+-------------+
| enamelength |
+-------------+
|           5 |
|           5 |
|           4 |
|           5 |
|           6 |
|           5 |
|           5 |
|           5 |
|           4 |
|           6 |
|           5 |
|           5 |
|           4 |
|           6 |
+-------------+
```
##### 6.2.6 trim 去空格
```sql
select * from emp where ename = trim('   KING');
+-------+-------+-----------+------+------------+---------+------+--------+
| EMPNO | ENAME | JOB       | MGR  | HIREDATE   | SAL     | COMM | DEPTNO |
+-------+-------+-----------+------+------------+---------+------+--------+
|  7839 | KING  | PRESIDENT | NULL | 1981-11-17 | 5000.00 | NULL |     10 |
+-------+-------+-----------+------+------------+---------+------+--------+
```

##### 6.2.7 str_to_date 将字符串转换成日期
##### 6.2.8 date_format 格式化日期
##### 6.2.9 format 设置千分位
##### 6.2.10 case..when..then..when..then..else..end
		当员工的工作岗位是MANAGER的时候，工资上调10%，当工作岗位是SALESMAN的时候，工资上调50%,其它正常。
		（注意：不修改数据库，只是将查询结果显示为工资上调）
```sql
select 
	ename,
	job, 
	sal as oldsal,
	(case job 
	when 'MANAGER' 
	then sal*1.1 
	when 'SALESMAN' 
	then sal*1.5 
	else sal 
	end) as newsal 
from 
	emp;
+--------+-----------+---------+---------+
| ename  | job       | oldsal  | newsal  |
+--------+-----------+---------+---------+
| SMITH  | CLERK     |  800.00 |  800.00 |
| ALLEN  | SALESMAN  | 1600.00 | 2400.00 |
| WARD   | SALESMAN  | 1250.00 | 1875.00 |
| JONES  | MANAGER   | 2975.00 | 3272.50 |
| MARTIN | SALESMAN  | 1250.00 | 1875.00 |
| BLAKE  | MANAGER   | 2850.00 | 3135.00 |
| CLARK  | MANAGER   | 2450.00 | 2695.00 |
| SCOTT  | ANALYST   | 3000.00 | 3000.00 |
| KING   | PRESIDENT | 5000.00 | 5000.00 |
| TURNER | SALESMAN  | 1500.00 | 2250.00 |
| ADAMS  | CLERK     | 1100.00 | 1100.00 |
| JAMES  | CLERK     |  950.00 |  950.00 |
| FORD   | ANALYST   | 3000.00 | 3000.00 |
| MILLER | CLERK     | 1300.00 | 1300.00 |
+--------+-----------+---------+---------+
```
##### 6.2.11 round 四舍五入
		select 字段 from 表名;
		select ename from emp;
		select 'abc' from emp; // select后面直接跟“字面量/字面值”
```sql
select 'abc' as bieming from emp;
+---------+
| bieming |
+---------+
| abc     |
| abc     |
| abc     |
| abc     |
| abc     |
| abc     |
| abc     |
| abc     |
| abc     |
| abc     |
| abc     |
| abc     |
| abc     |
| abc     |
+---------+
mysql> select round(1236.567, 0) as result from emp; //保留整数位。
+--------+
| result |
+--------+
|   1237 |
|   1237 |
|   1237 |
|   1237 |
|   1237 |
|   1237 |
|   1237 |
|   1237 |
|   1237 |
|   1237 |
|   1237 |
|   1237 |
|   1237 |
|   1237 |
+--------+

select round(1236.567, 1) as result from emp; //保留1个小数
select round(1236.567, 2) as result from emp; //保留2个小数
select round(1236.567, -1) as result from emp; // 保留到十位。
+--------+
| result |
+--------+
|   1240 |
|   1240 |
|   1240 |
|   1240 |
|   1240 |
|   1240 |
|   1240 |
|   1240 |
|   1240 |
|   1240 |
|   1240 |
|   1240 |
|   1240 |
|   1240 |
+--------+

select round(1236.567, -2) as result from emp;
+--------+
| result |
+--------+
|   1200 |
|   1200 |
|   1200 |
|   1200 |
|   1200 |
|   1200 |
|   1200 |
|   1200 |
|   1200 |
|   1200 |
|   1200 |
|   1200 |
|   1200 |
|   1200 |
+--------+
```
##### 6.2.12 rand() 生成随机数
```sql
select round(rand()*100,0) from emp; // 100以内的随机数
+---------------------+
| round(rand()*100,0) |
+---------------------+
|                  76 |
|                  29 |
|                  15 |
|                  88 |
|                  95 |
|                   9 |
|                  63 |
|                  89 |
|                  54 |
|                   3 |
|                  54 |
|                  61 |
|                  42 |
|                  28 |
+---------------------+
```

##### 6.2.13 ifnull 可以将 null 转换成一个具体值
	ifnull是空处理函数。专门处理空的。
	在所有数据库当中，只要有NULL参与的数学运算，最终结果就是NULL。
```sql
select ename, sal + comm as salcomm from emp;
+--------+---------+
| ename  | salcomm |
+--------+---------+
| SMITH  |    NULL |
| ALLEN  | 1900.00 |
| WARD   | 1750.00 |
| JONES  |    NULL |
| MARTIN | 2650.00 |
| BLAKE  |    NULL |
| CLARK  |    NULL |
| SCOTT  |    NULL |
| KING   |    NULL |
| TURNER | 1500.00 |
| ADAMS  |    NULL |
| JAMES  |    NULL |
| FORD   |    NULL |
| MILLER |    NULL |
+--------+---------+
计算每个员工的年薪？
年薪 = (月薪 + 月补助) * 12

select ename, (sal + comm) * 12 as yearsal from emp;
+--------+----------+
| ename  | yearsal  |
+--------+----------+
| SMITH  |     NULL |
| ALLEN  | 22800.00 |
| WARD   | 21000.00 |
| JONES  |     NULL |
| MARTIN | 31800.00 |
| BLAKE  |     NULL |
| CLARK  |     NULL |
| SCOTT  |     NULL |
| KING   |     NULL |
| TURNER | 18000.00 |
| ADAMS  |     NULL |
| JAMES  |     NULL |
| FORD   |     NULL |
| MILLER |     NULL |
+--------+----------+
```
	注意：NULL只要参与运算，最终结果一定是NULL。为了避免这个现象，需要使用ifnull函数。
	ifnull函数用法：ifnull(数据, 被当做哪个值)
	如果“数据”为NULL的时候，把这个数据结构当做哪个值。
	补助为NULL的时候，将补助当做0
```sql
select ename, (sal + ifnull(comm, 0)) * 12 as yearsal from emp;
+--------+----------+
| ename  | yearsal  |
+--------+----------+
| SMITH  |  9600.00 |
| ALLEN  | 22800.00 |
| WARD   | 21000.00 |
| JONES  | 35700.00 |
| MARTIN | 31800.00 |
| BLAKE  | 34200.00 |
| CLARK  | 29400.00 |
| SCOTT  | 36000.00 |
| KING   | 60000.00 |
| TURNER | 18000.00 |
| ADAMS  | 13200.00 |
| JAMES  | 11400.00 |
| FORD   | 36000.00 |
| MILLER | 15600.00 |
+--------+----------+
```
### 7 多行处理函数
	多行处理函数的特点：输入多行，最终输出一行。
	5个：
		count	计数
		sum	求和
		avg	平均值
		max	最大值
		min	最小值
	注意：
		分组函数在使用的时候必须先进行分组，然后才能用。
		如果你没有对数据进行分组，整张表默认为一组。
#### 7.1 找出最高工资？
```sql
select max(sal) from emp;
+----------+
| max(sal) |
+----------+
|  5000.00 |
+----------+
```

#### 7.2 找出最低工资？
```sql
select min(sal) from emp;
+----------+
| max(sal) |
+----------+
|  5000.00 |
+----------+
```
#### 7.3 计算工资和：
```sql
select sum(sal) from emp;
		+----------+
		| sum(sal) |
		+----------+
		| 29025.00 |
		+----------+
```
#### 7.4 计算平均工资
```sql
select avg(sal) from emp;
		+-------------+
		| avg(sal)    |
		+-------------+
		| 2073.214286 |
		+-------------+
```
#### 7.5 计算员工数量？
```sql
select count(ename) from emp;
		+--------------+
		| count(ename) |
		+--------------+
		|           14 |
		+--------------+
```

 - 分组函数在使用的时候需要注意哪些？

		第一点：分组函数自动忽略NULL，你不需要提前对NULL进行处理。
		第二点：分组函数中count(*)和count(具体字段)的区别
			count(具体字段)：表示统计该字段下所有不为NULL的元素的总数。
			count(*)：统计表当中的总行数。（只要有一行数据count则++）
			因为每一行记录不可能都为NULL，一行数据中有一列不为NULL，则这行数据就是有效的。
		第三点：分组函数不能够直接使用在where子句中。
		第四点：所有的分组函数可以组合起来一起用。

### 8 分组查询（非常重要：五颗星*****）
	在实际的应用中，可能有这样的需求，需要先进行分组，然后对每一组的数据进行操作。
	这个时候我们需要使用分组查询，怎么进行分组查询呢？
		select
			...
		from
			...
		group by
			...
		
		计算每个部门的工资和？
		计算每个工作岗位的平均薪资？
		找出每个工作岗位的最高薪资？
		....
#### 8.1 分组查询执行顺序
		select
			...
		from
			...
		where
			...
		group by
			...
		order by
			...
		
		以上关键字的顺序不能颠倒，需要记忆。
		执行顺序是什么？
			1. from
			2. where
			3. group by
			4. select
			5. order by
		
	为什么分组函数不能直接使用在where后面？
		select ename,sal from emp where sal > min(sal);//报错。
		因为分组函数在使用的时候必须先分组之后才能使用。
		where执行的时候，还没有分组。所以where后面不能出现分组函数。

		select sum(sal) from emp; 
		这个没有分组，为啥sum()函数可以用呢？
			因为select在group by之后执行。
#### 8.2 找出每个工作岗位的工资和
	实现思路：按照工作岗位分组，然后对工资求和。
```sql
select 
	job,sum(sal)
from
	emp
group by
	job;
+-----------+----------+
| job       | sum(sal) |
+-----------+----------+
| ANALYST   |  6000.00 |
| CLERK     |  4150.00 |
| MANAGER   |  8275.00 |
| PRESIDENT |  5000.00 |
| SALESMAN  |  5600.00 |
+-----------+----------+
```
```sql
select ename,job,sum(sal) from emp group by job;
+-------+-----------+----------+
| ename | job       | sum(sal) |
+-------+-----------+----------+
| SCOTT | ANALYST   |  6000.00 |
| SMITH | CLERK     |  4150.00 |
| JONES | MANAGER   |  8275.00 |
| KING  | PRESIDENT |  5000.00 |
| ALLEN | SALESMAN  |  5600.00 |
+-------+-----------+----------+
以上语句在mysql中可以执行，但是毫无意义。
以上语句在oracle中执行报错。
oracle的语法比mysql的语法严格。（mysql的语法相对来说松散一些！）
```
	重点结论：
		在一条select语句当中，如果有group by语句的话，
		select后面只能跟：参加分组的字段，以及分组函数。
		其它的一律不能跟。

#### 8.3 找出每个部门的最高薪资
	按照部门编号分组，求每一组的最大值。
```sql
select deptno,max(sal) from emp group by deptno;
+--------+----------+
| deptno | max(sal) |
+--------+----------+
|     10 |  5000.00 |
|     20 |  3000.00 |
|     30 |  2850.00 |
+--------+----------+
```

#### 8.4 找出“每个部门，不同工作岗位”的最高薪资？
	技巧：两个字段联合成1个字段看。（两个字段联合分组）
			
```sql
select 
	deptno, job, max(sal)
from
	emp
group by
	deptno, job;
+--------+-----------+----------+
| deptno | job       | max(sal) |
+--------+-----------+----------+
|     10 | CLERK     |  1300.00 |
|     10 | MANAGER   |  2450.00 |
|     10 | PRESIDENT |  5000.00 |
|     20 | ANALYST   |  3000.00 |
|     20 | CLERK     |  1100.00 |
|     20 | MANAGER   |  2975.00 |
|     30 | CLERK     |   950.00 |
|     30 | MANAGER   |  2850.00 |
|     30 | SALESMAN  |  1600.00 |
+--------+-----------+----------+
```

#### 8.5 找出每个部门最高薪资，要求显示最高薪资大于3000的
	使用having可以对分完组之后的数据进一步过滤。
	having不能单独使用，having不能代替where，
	having必须和group by联合使用。
```sql
select 
	deptno,max(sal) 
from 
	emp 
group by 
	deptno
having
	max(sal) > 3000;

+--------+----------+
| deptno | max(sal) |
+--------+----------+
|     10 |  5000.00 |
+--------+----------+
```
```sql
select 
	deptno,max(sal)
from
	emp
where
	sal > 3000
group by
	deptno;
```
	优化策略：
		where和having，优先选择where，
		where实在完成不了了，再选择having。
#### 8.6 找出每个部门平均薪资，要求显示平均薪资高于2500的。
第一步：找出每个部门平均薪资
第二步：要求显示平均薪资高于2500的
```sql
select 
	deptno,avg(sal) 
from 
	emp 
group by 
	deptno
having
	avg(sal) > 2500;

+--------+-------------+
| deptno | avg(sal)    |
+--------+-------------+
|     10 | 2916.666667 |
+--------+-------------+
```
#### 8.7 总结
	select 
		...
	from
		...
	where
		...
	group by
		...
	having
		...
	order by
		...
	
	以上关键字只能按照这个顺序来，不能颠倒。

	执行顺序？
		1. from
		2. where
		3. group by
		4. having
		5. select
		6. order by
	
	从某张表中查询数据，
	先经过where条件筛选出有价值的数据。
	对这些有价值的数据进行分组。
	分组之后可以使用having继续筛选。
	select查询出来。
	最后排序输出！

 - 找出每个岗位的平均薪资，要求显示平均薪资大于1500的，除MANAGER岗位之外，要求按照平均薪资降序排。
```sql
select 
	job, avg(sal) as avgsal
from
	emp
where
	job <> 'MANAGER'
group by
	job
having
	avg(sal) > 1500
order by
	avgsal desc;

+-----------+-------------+
| job       | avgsal      |
+-----------+-------------+
| PRESIDENT | 5000.000000 |
| ANALYST   | 3000.000000 |
+-----------+-------------+
```

