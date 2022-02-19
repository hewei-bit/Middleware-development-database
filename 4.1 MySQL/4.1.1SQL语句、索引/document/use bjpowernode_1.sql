/*********************************************************************/
/* 0.创建数据库与加载数据库 */
/* create database bjpowernode;
 source C: \ Users \ HEWEI \ Desktop \ document \ t_student.sql; */
/*********************************************************************/
/* 1.使用数据库  */
-- show databases;
use bjpowernode;
/*use t_student;*/
/*********************************************************************/
/* 2.查看当前数据库的表  */
-- show tables;
/*********************************************************************/
/* 3.查看表(这种形式不推荐)*/
select *
from EMP;
select *
from salgrade;
select *
from dept;
/*********************************************************************/
/*4.查看表结构 desc salgrade;*/
/*********************************************************************/
/*5.查看版本号*/
/*select version();*/
/*********************************************************************/
/* 6.查看当前使用数据库 */
-- select database();
/*********************************************************************/
/* 7.查询字段 */
-- select LOSAL,
--     GRADE
-- from salgrade;
/*********************************************************************/
/* 8.给字段起别名 */
-- select DEPTNO,
--     DNAME deptname
-- from dept;
/*********************************************************************/
/* 9.条件查询 */
/* 9.1 不等于 != */
-- select EMPNO,
--     ENAME
-- from EMP
-- where sal = 800
-- select EMPNO,
--     ENAME
-- from EMP
-- where sal != 800;
-- select EMPNO,
--     ENAME,
--     sal
-- from EMP
-- where sal <= 3000;
/***********************************************/
/* 9.1 使用between...and.. */
-- select EMPNO,
--     ENAME,
--     SAL
-- from EMP
-- where sal BETWEEN 800 AND 3000;
/***********************************************/
/* 9.2 查询补助不为NULL 查询NULL需要使用is, */
-- 字符串还是用 = not 可以取非 ， 主要用在 is 或 in 中 is null is not null in not in
-- select EMPNO,
--     ENAME,
--     SAL,
--     COMM
-- from EMP
-- where COMM is not NULL;
/***********************************************/
/* 9.3 使用in*/
-- and,
-- or
-- select EMPNO,
--     ENAME,
--     SAL,
--     COMM
-- from EMP
-- where sal in(800, 3000, 5000);
/***********************************************/
/* 9.4 like 称为模糊查询 ， 支持 % 或下划线匹配 % 匹配任意多个字符 下划线 ： 任意一个字符 。 （ % 是一个特殊的符号 ， _ 也是一个特殊符号 ）*/
/* select ename,
 sal,
 COMM,
 EMPNO
 from emp
 where ename like '%o%'; */
/* 9.4.1 找出名字以T结尾的 ？ */
-- select ename
-- from emp
-- where ename like '%T';
/* 9.4.2 找出名字以K开始的 ？ */
-- select ename
-- from emp
-- where ename like 'K%';
/* 9.4.3 找出第二个字每是A的 ？ */
-- select ename
-- from emp
-- where ename like '_A%';
/* 9.4.4 找出第三个字母是R的 ？ */
-- select ename
-- from emp
-- where ename like '__R%';
/***********************************************/
/* 9.5 排序 ， 默认是升序 ！ ！ */
-- select ename,
--     sal
-- from emp
-- order by sal;
/***********************************************/
/* 9.6 指定降序 ： */
-- select ename,
--     sal
-- from emp
-- order by sal desc;
/***********************************************/
/* 9.7 指定升序 ： */
-- select ename,
--     sal
-- from emp
-- order by sal asc;
/***********************************************/
/* 9.8 查询员工名字和薪资 ， 要求按照薪资升序 ， 如果薪资一样的话 ， 再按照名字升序排列 。 */
-- select ename,
--     sal
-- from emp
-- order by sal asc,
--     ename asc;
/* 9.9 找出工资在1250到3000之间的员工信息 ， 要求按照薪资降序排列 。 */
-- select ename,
--     sal
-- from emp
-- where sal between 1250 and 3000
-- order by sal desc;
/* 以上语句的执行顺序必须掌握 ： 第一步 ：
 from 第二步 ：
 where 第三步 ：
 select 第四步 ：
 order by （ 排序总是在最后执行 ！ ） */
/***********************************************/
/* 10 数据处理函数  */
/* 10.1 lower 转换小写 */
-- select lower(ename) as ename
-- from emp;
/* 10.2 upper */
-- select upper(name) as name
-- from t_student;
-- 
/* 10.3 substr 取子串 （ substr(被截取的字符串, 起始下标, 截取的长度) ） */
-- select substr(ename, 1, 1) as ename
-- from emp;
-- 
/* 10.4 concat函数进行字符串的拼接 */
-- select concat(EMPNO, ename)
-- from emp;
--
/* 10.5 length 取长度 */
-- select length(ename) enamelength
-- from emp;
-- 
/* 10.6 trim 去空格 */
-- select *
-- from emp
-- where ename = trim('   KING');
-- 
/*  10.7 str_to_date 将字符串转换成日期 */
/*  10.8 date_format 格式化日期 */
/*  10.9 format 设置千分位 */
/* 10.10 case..when..then..when..then..else..end */
/* 当员工的工作岗位是MANAGER的时候，工资上调10%，当工作岗位是SALESMAN的时候，工资上调50%,其它正常。
 注意 ： 不修改数据库 ， 只是将查询结果显示为工资上调  */
-- select ename,
--     job,
--     sal as oldsal,
--     (
--         case
--             job
--             when 'MANAGER' then sal * 1.1
--             when 'SALESMAN' then sal * 1.5
--             else sal
--         END
--     ) as newsal
-- from emp;
/* 10.11 round 四舍五入 */
-- select round(123456.123, 0) as result
-- from emp;
/*  10.11.1 保留1个小数 */
-- select round(1236.567, 1) as result
-- from emp;
/*  10.11.2 保留2个小数 */
-- select round(1236.567, 2) as result
-- from emp;
/* 10.11.3 保留到十位。 */
/* select round(1236.567, -1) as result
 from emp; */
/* 10.12 select后面可以跟某个表的字段名（可以等同看做变量名），也可以跟字面量/字面值（数据）。 */
-- select 'abc' as bieming
-- from emp;
/* 
 10.13 rand() 生成随机数
 100 以内的随机数 
 */
-- select round(rand() * 100, 0)
-- from emp;
/* 
 10.14 ifnull 可以将 null 转换成一个具体值 
 ifnull 是空处理函数，专门处理空的 。  
 注意 ： NULL 只要参与运算 ， 
 最终结果一定是NULL 。 
 为了避免这个现象 ， 
 需要使用ifnull函数 。
 ifnull 函数用法 ： ifnull(数据, 被当做哪个值) 
 如果 “ 数据 ” 为NULL的时候 ， 
 把这个数据结构当做哪个值 。 */
/*
 select ename,
 (sal + comm) * 12 as yearsal
 from emp;
 */
/*
 select ename,
 (sal + ifnull(comm, 0)) * 12 as yearsal
 from emp;
 */
/**********************************************************/
/* 11.分组函数（多行处理函数） */
/* 多行处理函数的特点：输入多行，最终输出一行。 */
/* 
 5个：
 count	计数
 sum	求和
 avg	平均值
 max	最大值
 min	最小值 
 */
/* 注意：
 分组函数在使用的时候必须先进行分组，然后才能用。
 如果你没有对数据进行分组，整张表默认为一组。 
 */
/* 
 select max(sal)
 from emp;
 select min(sal)
 from emp;
 select sum(sal)
 from emp; 
 select avg(sal)
 from emp;
 select count(sal)
 from emp;
 */
/* 
 分组函数在使用的时候需要注意哪些 ？  
 第一点 ： 分组函数自动忽略NULL ， 你不需要提前对NULL进行处理 。
 第二点 ： 分组函数中count(*) 和count(具体字段) 有什么区别 ？ 
 第三点：分组函数不能够直接使用在where子句中。
 第四点 ： 所有的分组函数可以组合起来一起用 。
 */
/*******************************************************************/
/* 12.分组查询（非常重要：五颗星*****） */
/*
 12.1找出每个工作岗位的工资和？
 实现思路：按照工作岗位分组，然后对工资求和。
 */
/*
 select 
 job,sum(sal)
 from
 emp
 group by
 job;
 */
/*
 select deptno,
 max(sal)
 from emp
 group by deptno
 having max(sal) > 3000;
 */
/*
 select deptno,
 max(sal)
 from emp
 where sal > 3000
 group by deptno;
 */
/**************************************************************************
 13.大总结（单表的查询学完了）
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
 */
/*
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
 */
/*
 找出每个岗位的平均薪资，要求显示平均薪资大于1500的，除MANAGER岗位之外，
 要求按照平均薪资降序排。*/
/*
 select job,
 avg(sal) as avgsal
 from emp
 where job <> 'MANAGER'
 group by job
 having avg(sal) > 1500
 order by avgsal desc;
 */
/***************************************************************************/