use bjpowernode;
select *
from EMP;
-- select *
-- from SALGRADE;
-- select *
-- from DEPT;
/* ************************************************************************* */
/* 1 ȡ��ÿ���������нˮ����Ա���� */
/* ��һ����ȡ��ÿ���������нˮ(���ղ��ű�ŷ��飬�ҳ�ÿһ�����ֵ) */
-- select DEPTNO,
--     max(SAL) as maxsal
-- from EMP
-- group by DEPTNO;
/* �ڶ����������ϵĲ�ѯ�������һ����ʱ��t��
 t��EMP�����ӣ�������t.DEPTNO = e.DEPTNO and t.maxsal = e.SAL */
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
/* 2����Щ�˵�нˮ�ڲ��ŵ�ƽ��нˮ֮�� */
/* ��һ���Ȳ��ÿ�����ŵ�ƽ��нˮ */
select DEPTNO,
    avg(SAL) as avgsal
from EMP
group by DEPTNO;
/* �ڶ����������ϲ�ѯ�������t��t��EMP������
 ���������ű����ͬ������EMP��sal����t���avgsal */
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
/* 3��ȡ�ò����У������˵ģ�ƽ����нˮ�ȼ� */
/*��һ�����ҳ�ÿ���˵�нˮ�ȼ�
 emp e��salgrade s�����ӡ�
 ����������e.sal between s.losal and s.hisal*/
-- select e.ENAME,
--     e.SAL,
--     e.DEPTNO,
--     s.GRADE
-- from EMP e
--     join SALGRADE s on e.SAL BETWEEN s.LOSAL and s.HISAL;
/**�ڶ������������ϵĽ����������deptno���飬��grade��ƽ��ֵ��*/
select e.DEPTNO,
    avg(s.GRADE)
from EMP e
    join SALGRADE s on e.SAL BETWEEN s.LOSAL and s.HISAL
GROUP BY e.DEPTNO;
/* ************************************************************************* */
/* 4����׼���麯����Max ����ȡ�����нˮ */
/*��һ�����ҳ��Լ����Լ����ѡ���Ȼû��5000*/
-- select distinct a.sal
-- from EMP a
--     join EMP b on a.sal < b.sal;
/* �ڶ������ҵ�ǰ���ĸ����ʣ�µĲ���*/
select sal
from emp
where sal not in(
        select distinct a.sal
        from emp a
            join emp b on a.sal < b.sal
    );
/* ************************************************************************* */
/* 5��ȡ��ƽ��нˮ��ߵĲ��ŵĲ��ű�� */
/*��һ�����ҳ�ÿ�����ŵ�ƽ��нˮ*/
/*�ڶ���������ѡ��һ����*/
select DEPTNO,
    avg(SAL) as AVGSAL
from EMP
group by DEPTNO
order by AVGSAL desc
limit 1;
/* ************************************************************************* */
/* 6��ȡ��ƽ��нˮ��ߵĲ��ŵĲ������� */
select d.DNAME,
    avg(e.SAL) as avgsal
from EMP e
    join DEPT d on d.DEPTNO = e.DEPTNO
group by d.DNAME
order by avgsal DESC
limit 1;
/* ************************************************************************* */
/*7����ƽ��нˮ�ĵȼ���͵Ĳ��ŵĲ�������*/
/*��һ�����ҳ�ÿ�����ŵ�ƽ��нˮ*/
-- select deptno,
--     avg(SAL) as avgsal
-- from EMP
-- group by deptno;
/*�ڶ������ҳ�ÿ�����ŵ�ƽ��нˮ�ĵȼ�*/
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
/*8��ȡ�ñ���ͨԱ��(Ա������û���� mgr �ֶ��ϳ��ֵ�) �����нˮ��Ҫ�ߵ��쵼������*/
/*�ҵ��쵼�ķ�Χ*/
select distinct mgr
from EMP
where mgr is not null;
/*�ҳ���ͨԱ�������нˮ��*/
select max(sal)
from EMP
where empno not in(
        select distinct mgr
        from EMP
        where mgr is not null
    );
/*�ҳ�����������*/
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
/*9��ȡ��нˮ��ߵ�ǰ����Ա��*/
select ename,
    sal
from EMP
order by sal desc
limit 5;
/* ************************************************************************* */
/*10��ȡ��нˮ��ߵĵ�������ʮ��Ա��*/
select ename,
    sal
from EMP
order by sal desc
limit 5, 5;
/* ************************************************************************* */
/*11��ȡ�������ְ�� 5 ��Ա��*/
select ename,
    hiredate
from EMP
order by hiredate desc
limit 5;
/* ************************************************************************* */
/*12��ȡ��ÿ��нˮ�ȼ��ж���Ա��*/
/*��һ�����ҳ�ÿ��Ա����нˮ�ȼ�*/
select e.ename,
    e.sal,
    s.grade
from EMP e
    join SALGRADE s on e.sal between s.losal and s.hisal;
/*�ڶ�������������grade����ͳ������*/
select s.grade,
    count(*)
from EMP e
    join SALGRADE s on e.sal BETWEEN s.losal and s.hisal
group by s.grade;
/* ************************************************************************* */
/*13�������⣺
 �� 3 ���� S(ѧ����)��C���γ̱���SC��ѧ��ѡ�α�
 S��SNO��SNAME������ѧ�ţ�������
 C��CNO��CNAME��CTEACHER�������κţ���������ʦ��
 SC��SNO��CNO��SCGRADE������ѧ�ţ��κţ��ɼ���
 ���⣺
 1���ҳ�ûѡ������������ʦ������ѧ��������
 2���г� 2 �����ϣ���2 �ţ�������ѧ��������ƽ���ɼ���
 3����ѧ�� 1 �ſγ���ѧ�� 2 �ſ�����ѧ����������*/
/* ************************************************************************* */
/*14���г�����Ա�����쵼������*/
select a.ename 'Ա��',
    b.ename '�쵼'
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
/*15���г��ܹ�����������ֱ���ϼ�������Ա���ı��,����,��������*/
select a.ename 'Ա��',
    a.hiredate,
    b.ename '�쵼',
    b.hiredate,
    d.dname
from EMP a
    join EMP b on a.mgr = b.empno
    join DEPT d on a.deptno = d.deptno
where a.hiredate < b.hiredate;
/* ************************************************************************* */
/*16�� �г��������ƺ���Щ���ŵ�Ա����Ϣ, ͬʱ�г���Щû��Ա���Ĳ���*/
select e.*,
    d.dname
from EMP e
    right join DEPT d on e.deptno = d.deptno;
/* ************************************************************************* */
/*17���г������� 5 ��Ա�������в���*/
/*select DEPTNO
 from EMP
 group by deptno
 having count(*) >= 5;*/
/* ************************************************************************* */
/*18���г�н���"SMITH" �������Ա����Ϣ*/
/*select ename,
 sal
 from EMP
 where sal > (
 select sal
 from EMP
 where ename = 'SMITH'
 );*/
/* ************************************************************************* */
/*19�� �г�����"CLERK"( ����Ա) ���������䲿������, ���ŵ�����*/
-- select e.ename,
--     e.job,
--     d.dname,
--     d.deptno
-- from EMP e
--     join DEPT d on e.deptno = d.deptno
-- where e.job = 'CLERK';
/*ÿ�����ŵ�����*/
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
/*20���г����н����� 1500 �ĸ��ֹ��������´˹�����ȫ����Ա����*/
/*
 select job,
 count(*)
 from EMP
 group by job
 having min(sal) > 1000;
 */
/* ************************************************************************* */
/*21���г��ڲ���"SALES"< ���۲�> ������Ա��������, �ٶ���֪�����۲��Ĳ��ű��.*/
-- select ename
-- from EMP
-- where deptno = (
--         select deptno
--         from DEPT
--         where dname = 'SALES'
--     );
/* ************************************************************************* */
/*22���г�н����ڹ�˾ƽ��н�������Ա��, ���ڲ���, �ϼ��쵼, ��Ա�Ĺ��ʵȼ�.*/
/*
 select e.ename 'Ա��',
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
/*23�� �г���"SCOTT" ������ͬ����������Ա������������*/
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
/*24���г�н����ڲ��� 30 ��Ա����н�������Ա����������н��.*/
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
/*25���г�н������ڲ��� 30 ����������Ա����н���Ա��������н��. ��������*/
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
/*26���г���ÿ�����Ź�����Ա������, ƽ�����ʺ�ƽ����������*/
-- select d.deptno,
--     count(e.ename) ecount,
--     ifnull(avg(e.sal), 0) as avgsal,
--     ifnull(avg(timestampdiff(YEAR, hiredate, now())), 0) as avgservicetime
-- from EMP e
--     right join DEPT d on e.deptno = d.deptno
-- group by d.deptno;
/* ************************************************************************* */
/*27�� �г�����Ա�����������������ƺ͹��ʡ�*/
-- select e.ename,
--     d.dname,
--     e.sal
-- from EMP e
--     join DEPT d on e.deptno = d.deptno;
/* ************************************************************************* */
/*28���г����в��ŵ���ϸ��Ϣ������*/
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
/*29���г����ֹ�������͹��ʼ����´˹����Ĺ�Ա����*/
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
/*30���г��������ŵ� MANAGER( �쵼) �����н��*/
-- select deptno,
--     min(sal)
-- from EMP
-- where job = 'MANAGER'
-- group by deptno;
/* ************************************************************************* */
/*31���г�����Ա���� �깤��, �� ��н�ӵ͵�������*/
select ename,
    (sal + ifnull(comm, 0)) * 12 as yearsal
from EMP
order by yearsal asc;
/* ************************************************************************* */
/*32�����Ա���쵼��нˮ����3000��Ա���������쵼*/
/*
 select a.ename 'Ա��',
 b.ename '�쵼'
 from EMP a
 join EMP b on a.mgr = b.empno
 where b.sal > 3000;
 */
/* ************************************************************************* */
/*33���������������, ��'S'�ַ��Ĳ���Ա���Ĺ��ʺϼơ���������*/
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
/*34������ְ���ڳ��� 30 ���Ա����н 10%.*/
update EMP
set sal = sal * 1.1
where timestampdiff(YEAR, hiredate, now()) > 30;
select *
from EMP;