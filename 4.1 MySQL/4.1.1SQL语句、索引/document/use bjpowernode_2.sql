use bjpowernode;
/*********************************************************/
/********1.去重************/
select DISTINCT job
from emp;
select count(DISTINCT job)
from emp;
/*********************************************************/
/********2.连接查询************/
/********2.1 内连接之等值连接************/
select e.ename,
    d.dname
from emp e
    join dept d on e.deptno = d.deptno;
/********2.2 内连接之非等值连接************/
select e.ename,
    e.sal,
    s.grade
from emp e
    join salgrade s on e.sal between s.losal and s.hisal;
/********2.3 内连接之自连接************/
select a.ename as '员工名',
    b.ename as '领导名'
from emp a
    join emp b on a.mgr = b.empno;
/*********************************************************/
/********外连接（右外连接）：************/
select e.ename,
    d.dname
from emp e
    right join dept d on e.deptno = d.deptno;
/*********************************************************/
/********外连接（左外连接）：************/
select e.ename,
    d.dname
from dept d
    left join emp e on e.deptno = d.deptno;
/*********************************************************/
/********三张表，四张表怎么连接************/
select e.ename,
    e.sal,
    d.dname,
    s.grade
from emp e
    join dept d on e.deptno = d.deptno
    join salgrade s on e.sal between s.losal and s.hisal;
/*********************************************************/
/********3.子查询************/
select t.*,
    s.grade
from (
        select job,
            avg(sal) as avgsal
        from emp
        group by job
    ) t
    join salgrade s on t.avgsal between s.losal and s.hisal;
/*********************************************************/