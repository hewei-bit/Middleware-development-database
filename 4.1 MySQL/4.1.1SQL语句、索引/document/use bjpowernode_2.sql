use bjpowernode;
/*********************************************************/
/********1.ȥ��************/
select DISTINCT job
from emp;
select count(DISTINCT job)
from emp;
/*********************************************************/
/********2.���Ӳ�ѯ************/
/********2.1 ������֮��ֵ����************/
select e.ename,
    d.dname
from emp e
    join dept d on e.deptno = d.deptno;
/********2.2 ������֮�ǵ�ֵ����************/
select e.ename,
    e.sal,
    s.grade
from emp e
    join salgrade s on e.sal between s.losal and s.hisal;
/********2.3 ������֮������************/
select a.ename as 'Ա����',
    b.ename as '�쵼��'
from emp a
    join emp b on a.mgr = b.empno;
/*********************************************************/
/********�����ӣ��������ӣ���************/
select e.ename,
    d.dname
from emp e
    right join dept d on e.deptno = d.deptno;
/*********************************************************/
/********�����ӣ��������ӣ���************/
select e.ename,
    d.dname
from dept d
    left join emp e on e.deptno = d.deptno;
/*********************************************************/
/********���ű����ű���ô����************/
select e.ename,
    e.sal,
    d.dname,
    s.grade
from emp e
    join dept d on e.deptno = d.deptno
    join salgrade s on e.sal between s.losal and s.hisal;
/*********************************************************/
/********3.�Ӳ�ѯ************/
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