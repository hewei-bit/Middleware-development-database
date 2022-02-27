use bjpowernode;
select *
from EMP;
-- select *
-- from SALGRADE;
-- select *
-- from DEPT;
/* ************************************************************************* */
/* 1 取得每个部门最高薪水的人员名称 */
/* 第一步：取得每个部门最高薪水(按照部门编号分组，找出每一组最大值) */
-- select DEPTNO,
--     max(SAL) as maxsal
-- from EMP
-- group by DEPTNO;
/* 第二步：将以上的查询结果当做一张临时表t，
 t和EMP表连接，条件：t.DEPTNO = e.DEPTNO and t.maxsal = e.SAL */
select e.ENAME,
    t.*
from EMP e
    join (
        select DEPTNO,
            max(SAL) as maxsal
        from EMP
        group by DEPTNO
    ) t on t.DEPTNO = e.DEPTNO
    AND t.maxsal = e.SAL;
/* ************************************************************************* */
/* 2、哪些人的薪水在部门的平均薪水之上 */
/* 第一步先查出每个部门的平均薪水 */
select DEPTNO,
    avg(SAL) as avgsal
from EMP
group by DEPTNO;
/* 第二步：将以上查询结果当做t表，t和EMP表连接
 条件：部门编号相同，并且EMP的sal大于t表的avgsal */
/* select t.*,
 e.ENAME,
 e.SAL
 from EMP e
 join (
 select DEPTNO,
 avg(SAL) as avgsal
 from EMP
 group by DEPTNO
 ) t on e.DEPTNO = t.DEPTNO
 AND e.SAL > t.avgsal;*/
/* ************************************************************************* */
/* 3、取得部门中（所有人的）平均的薪水等级 */
/*第一步：找出每个人的薪水等级
 emp e和salgrade s表连接。
 连接条件：e.sal between s.losal and s.hisal*/
-- select e.ENAME,
--     e.SAL,
--     e.DEPTNO,
--     s.GRADE
-- from EMP e
--     join SALGRADE s on e.SAL BETWEEN s.LOSAL and s.HISAL;
/**第二步：基于以上的结果继续按照deptno分组，求grade的平均值。*/
select e.DEPTNO,
    avg(s.GRADE)
from EMP e
    join SALGRADE s on e.SAL BETWEEN s.LOSAL and s.HISAL
GROUP BY e.DEPTNO;
/* ************************************************************************* */
/* 4、不准用组函数（Max ），取得最高薪水 */
/*第一步：找出自己比自己大的选项，必然没有5000*/
-- select distinct a.sal
-- from EMP a
--     join EMP b on a.sal < b.sal;
/* 第二步：找到前面哪个结果剩下的部分*/
select sal
from emp
where sal not in(
        select distinct a.sal
        from emp a
            join emp b on a.sal < b.sal
    );
/* ************************************************************************* */
/* 5、取得平均薪水最高的部门的部门编号 */
/*第一步：找出每个部门的平均薪水*/
/*第二步：降序选第一个。*/
select DEPTNO,
    avg(SAL) as AVGSAL
from EMP
group by DEPTNO
order by AVGSAL desc
limit 1;
/* ************************************************************************* */
/* 6、取得平均薪水最高的部门的部门名称 */
select d.DNAME,
    avg(e.SAL) as avgsal
from EMP e
    join DEPT d on d.DEPTNO = e.DEPTNO
group by d.DNAME
order by avgsal DESC
limit 1;
/* ************************************************************************* */
/*7、求平均薪水的等级最低的部门的部门名称*/
/*第一步：找出每个部门的平均薪水*/
-- select deptno,
--     avg(SAL) as avgsal
-- from EMP
-- group by deptno;
/*第二步：找出每个部门的平均薪水的等级*/
select t.*,
    s.grade
from (
        select d.dname,
            avg(sal) as avgsal
        from emp e
            join dept d on e.deptno = d.deptno
        group by d.dname
    ) t
    join salgrade s on t.avgsal between s.losal and s.hisal;
/**/
select t.*,
    s.grade
from (
        select d.dname,
            avg(SAL) as avgsal
        from EMP e
            join DEPT d on e.DEPTNO = d.DEPTNO
        group by d.dname
    ) t
    join SALGRADE s on t.avgsal BETWEEN s.losal and s.hisal
where s.grade = (
        select grade
        from SALGRADE
        where (
                select avg(sal) as avgsal
                from EMP
                group by deptno
                order by avgsal asc
                limit 1
            ) between losal and hisal
    );
/* ************************************************************************* */
/*8、取得比普通员工(员工代码没有在 mgr 字段上出现的) 的最高薪水还要高的领导人姓名*/
/*找到领导的范围*/
select distinct mgr
from EMP
where mgr is not null;
/*找出普通员工的最高薪水！*/
select max(sal)
from EMP
where empno not in(
        select distinct mgr
        from EMP
        where mgr is not null
    );
/*找出比上面更大的*/
/*select ename,
 sal
 from EMP
 where sal > (
 select max(sal)
 from EMP
 where empno not in(
 select distinct mgr
 from EMP
 where mgr is not null
 )
 );
 */
/* ************************************************************************* */
/*9、取得薪水最高的前五名员工*/
select ename,
    sal
from EMP
order by sal desc
limit 5;
/* ************************************************************************* */
/*10、取得薪水最高的第六到第十名员工*/
select ename,
    sal
from EMP
order by sal desc
limit 5, 5;
/* ************************************************************************* */
/*11、取得最后入职的 5 名员工*/
select ename,
    hiredate
from EMP
order by hiredate desc
limit 5;
/* ************************************************************************* */
/*12、取得每个薪水等级有多少员工*/
/*第一步：找出每个员工的薪水等级*/
select e.ename,
    e.sal,
    s.grade
from EMP e
    join SALGRADE s on e.sal between s.losal and s.hisal;
/*第二步：继续按照grade分组统计数量*/
select s.grade,
    count(*)
from EMP e
    join SALGRADE s on e.sal BETWEEN s.losal and s.hisal
group by s.grade;
/* ************************************************************************* */
/*13、面试题：
 有 3 个表 S(学生表)，C（课程表），SC（学生选课表）
 S（SNO，SNAME）代表（学号，姓名）
 C（CNO，CNAME，CTEACHER）代表（课号，课名，教师）
 SC（SNO，CNO，SCGRADE）代表（学号，课号，成绩）
 问题：
 1，找出没选过“黎明”老师的所有学生姓名。
 2，列出 2 门以上（含2 门）不及格学生姓名及平均成绩。
 3，即学过 1 号课程又学过 2 号课所有学生的姓名。*/
/* ************************************************************************* */
/*14、列出所有员工及领导的姓名*/
select a.ename '员工',
    b.ename '领导'
from EMP a
    left join EMP b on a.mgr = b.empno;
-- select e.ename,
--     d.dname
-- from EMP e
--     right outer join DEPT d on e.deptno = d.deptno;
-- select e.ename,
--     d.dname
-- from EMP e
--     left outer join DEPT d on e.deptno = d.deptno;
/* ************************************************************************* */
/*15、列出受雇日期早于其直接上级的所有员工的编号,姓名,部门名称*/
select a.ename '员工',
    a.hiredate,
    b.ename '领导',
    b.hiredate,
    d.dname
from EMP a
    join EMP b on a.mgr = b.empno
    join DEPT d on a.deptno = d.deptno
where a.hiredate < b.hiredate;
/* ************************************************************************* */
/*16、 列出部门名称和这些部门的员工信息, 同时列出那些没有员工的部门*/
select e.*,
    d.dname
from EMP e
    right join DEPT d on e.deptno = d.deptno;
/* ************************************************************************* */
/*17、列出至少有 5 个员工的所有部门*/
/*select DEPTNO
 from EMP
 group by deptno
 having count(*) >= 5;*/
/* ************************************************************************* */
/*18、列出薪金比"SMITH" 多的所有员工信息*/
/*select ename,
 sal
 from EMP
 where sal > (
 select sal
 from EMP
 where ename = 'SMITH'
 );*/
/* ************************************************************************* */
/*19、 列出所有"CLERK"( 办事员) 的姓名及其部门名称, 部门的人数*/
-- select e.ename,
--     e.job,
--     d.dname,
--     d.deptno
-- from EMP e
--     join DEPT d on e.deptno = d.deptno
-- where e.job = 'CLERK';
/*每个部门的人数*/
-- select deptno,
--     count(*) as deptcount
-- from EMP
-- GROUP BY deptno;
-- select t1.*,
--     t2.deptcount
-- from (
--         select e.ename,
--             e.job,
--             d.dname,
--             d.deptno
--         from EMP e
--             join DEPT d on e.deptno = d.deptno
--         where e.job = 'CLERK'
--     ) t1
--     join(
--         select deptno,
--             count(*) as deptcount
--         from EMP
--         GROUP BY deptno
--     ) t2 on t1.deptno = t2.deptno;
/* ************************************************************************* */
/*20、列出最低薪金大于 1500 的各种工作及从事此工作的全部雇员人数*/
/*
 select job,
 count(*)
 from EMP
 group by job
 having min(sal) > 1000;
 */
/* ************************************************************************* */
/*21、列出在部门"SALES"< 销售部> 工作的员工的姓名, 假定不知道销售部的部门编号.*/
-- select ename
-- from EMP
-- where deptno = (
--         select deptno
--         from DEPT
--         where dname = 'SALES'
--     );
/* ************************************************************************* */
/*22、列出薪金高于公司平均薪金的所有员工, 所在部门, 上级领导, 雇员的工资等级.*/
/*
 select e.ename '员工',
 d.dname,
 l.ename,
 s.grade
 from EMP e
 join DEPT d on e.deptno = d.deptno
 left join EMP l on e.mgr = l.empno
 join SALGRADE s on e.sal BETWEEN s.losal and s.hisal
 where e.sal > (
 select avg(sal)
 from EMP
 );
 */
/* ************************************************************************* */
/*23、 列出与"SCOTT" 从事相同工作的所有员工及部门名称*/
-- select job
-- from EMP
-- where ename = 'SCOTT';
/*
 select e.ename,
 e.job,
 d.dname
 from EMP e
 join DEPT d on e.deptno = d.deptno
 where e.job = (
 select job
 from EMP
 where ename = 'SCOTT'
 )
 and e.ename <> 'SCOTT';
 */
/* ************************************************************************* */
/*24、列出薪金等于部门 30 中员工的薪金的其他员工的姓名和薪金.*/
/*
 select distinct sal
 from EMP
 where deptno = 30;
 select ename,
 sal
 from EMP
 where sal in (
 select distinct sal
 from EMP
 where deptno = 30
 )
 and deptno <> 30;
 */
/* ************************************************************************* */
/*25、列出薪金高于在部门 30 工作的所有员工的薪金的员工姓名和薪金. 部门名称*/
-- select max(sal)
-- from EMP
-- where deptno = 30;
/*
 select e.ename,
 e.sal,
 d.dname
 from EMP e
 join dept d on e.deptno
 and d.deptno
 where e.sal > (
 select max(sal)
 from EMP
 where deptno = 30
 );
 */
/* ************************************************************************* */
/*26、列出在每个部门工作的员工数量, 平均工资和平均服务期限*/
-- select d.deptno,
--     count(e.ename) ecount,
--     ifnull(avg(e.sal), 0) as avgsal,
--     ifnull(avg(timestampdiff(YEAR, hiredate, now())), 0) as avgservicetime
-- from EMP e
--     right join DEPT d on e.deptno = d.deptno
-- group by d.deptno;
/* ************************************************************************* */
/*27、 列出所有员工的姓名、部门名称和工资。*/
-- select e.ename,
--     d.dname,
--     e.sal
-- from EMP e
--     join DEPT d on e.deptno = d.deptno;
/* ************************************************************************* */
/*28、列出所有部门的详细信息和人数*/
-- select d.deptno,
--     d.dname,
--     d.loc,
--     count(e.ename)
-- from EMP e
--     right join DEPT d on e.deptno = d.deptno
-- group by d.deptno,
--     d.dname,
--     d.loc;
/* ************************************************************************* */
/*29、列出各种工作的最低工资及从事此工作的雇员姓名*/
-- select job,
--     min(sal) as minsal
-- from EMP
-- group by job;
-- select e.ename,
--     t.*
-- from EMP e
--     join (
--         select job,
--             min(sal) as minsal
--         from EMP
--         group by job
--     ) t on e.job = t.job
--     and e.sal = t.minsal;
/* ************************************************************************* */
/*30、列出各个部门的 MANAGER( 领导) 的最低薪金*/
-- select deptno,
--     min(sal)
-- from EMP
-- where job = 'MANAGER'
-- group by deptno;
/* ************************************************************************* */
/*31、列出所有员工的 年工资, 按 年薪从低到高排序*/
select ename,
    (sal + ifnull(comm, 0)) * 12 as yearsal
from EMP
order by yearsal asc;
/* ************************************************************************* */
/*32、求出员工领导的薪水超过3000的员工名称与领导*/
/*
 select a.ename '员工',
 b.ename '领导'
 from EMP a
 join EMP b on a.mgr = b.empno
 where b.sal > 3000;
 */
/* ************************************************************************* */
/*33、求出部门名称中, 带'S'字符的部门员工的工资合计、部门人数*/
select d.deptno,
    d.dname,
    d.loc,
    count(e.ename),
    ifnull(sum(e.sal), 0) as sumsal
from emp e
    right join dept d on e.deptno = d.deptno
where d.dname like '%S%'
group by d.deptno,
    d.dname,
    d.loc;
/* ************************************************************************* */
/*34、给任职日期超过 30 年的员工加薪 10%.*/
update EMP
set sal = sal * 1.1
where timestampdiff(YEAR, hiredate, now()) > 30;
select *
from EMP;