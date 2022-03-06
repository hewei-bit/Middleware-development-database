use practice;
-- select *
-- from class;
-- select *
-- from score;
-- select *
-- from course;
-- select *
-- from student;
-- select *
-- from teacher;
/*******************************************************************/
-- 1.��ѯƽ���ɼ�����60�ֵ�ͬѧ��ѧ�ź�ƽ���ɼ���
/*
 select student_id,
 avg(num) as avgnum
 from score
 group by student_id
 having avgnum > 60;
 */
/*******************************************************************/
-- 2.��ѯ 'c++�߼��ܹ�' �γ̱� '����Ƶ' �γ̳ɼ��ߵ�����ѧ����ѧ�ţ�
-- �ҵ��γ̶�Ӧ��cid
-- select cid
-- from course
-- where cname = 'C++�߼��ܹ�';
-- select cid
-- from course
-- where cname = '����Ƶ';
-- �ҵ�ѧ���ɼ�
-- select student_id,
--     num
-- from score
-- where course_id = (
--         select cid
--         from course
--         where cname = 'C++�߼��ܹ�'
--     );
-- select student_id,
--     num
-- from score
-- where course_id = (
--         select cid
--         from course
--         where cname = '����Ƶ'
--     );
-- ���ű���ͬһ�ű�����ʹ��
/*
 select A.student_id
 from (
 (
 select student_id,
 num
 from score
 where course_id = (
 select cid
 from course
 where cname = 'C++�߼��ܹ�'
 )
 ) as A
 INNER join (
 select student_id,
 num
 from score
 where course_id = (
 select cid
 from course
 where cname = '����Ƶ'
 )
 ) as B on A.student_id = B.student_id
 )
 where A.num > B.num;
 */
/*******************************************************************/
-- 3.��ѯ����ͬѧ��ѧ�š�������ѡ�������ܳɼ���
-- select sid,
--     sname,
--     A.cnt,
--     A.sum_sco
-- from student
--     left join (
--         select student_id,
--             count(course_id) as cnt,
--             sum(num) as sum_sco
--         from score
--         group by student_id
--     ) as A on A.student_id = sid;
/*******************************************************************/
-- 4.��ѯûѧ�� 'лС��' ��ʦ�ε�ͬѧ��ѧ�š�������
-- ��ѯ'лС��' ��ʦ�Ŀε�cid
-- select cid
-- from course
--     left join teacher on course.teacher_id = teacher.tid
-- where teacher.tname = 'лС����ʦ';
-- ��ѯ��Щѧ��ѡ��лС����ʦ�Ŀ�
-- select DISTINCT student_id
-- from score
-- where course_id in (
--         select cid
--         from course
--             left join teacher on course.teacher_id = teacher.tid
--         where teacher.tname = 'лС����ʦ'
--     );
-- ���һ��
-- select sid,
--     sname
-- from student
-- where sid not in (
--         select DISTINCT student_id
--         from score
--         where course_id in (
--                 select cid
--                 from course
--                     left join teacher on course.teacher_id = teacher.tid
--                 where teacher.tname = 'лС����ʦ'
--             )
--     );
/*******************************************************************/
-- 5.��ѯѧ���γ̱��Ϊ '1' ����Ҳѧ���γ̱��Ϊ '2' ��ͬѧ��ѧ�š�������
-- select sid,
--     sname
-- from student as B
--     right join (
--         SELECT student_id
--         FROM score
--         WHERE course_id = 1
--             OR course_id = 2
--         GROUP BY student_id
--         HAVING count(course_id) = 2
--     ) as A on A.student_id = B.sid;
/*******************************************************************/
-- 6.��ѯѧ�� 'лС��' ��ʦ���̵����пε�ͬѧ��ѧ�š�������
-- select sid,
--     sname
-- from student
-- where sid in (
--         select DISTINCT student_id
--         from score
--         where course_id in (
--                 select cid
--                 from course
--                     left join teacher on course.teacher_id = teacher.tid
--                 where teacher.tname = 'лС����ʦ'
--             )
--     );
/*******************************************************************/
-- 7.��ѯ�пγ̳ɼ�С�� 60 �ֵ�ͬѧ��ѧ�š�������
-- select sid,
--     sname
-- from student as A
--     right join (
--         SELECT DISTINCT student_id
--         from score
--         where num < 60
--     ) as B on A.sid = B.student_id;
/*******************************************************************/
-- 8.��ѯû��ѧȫ���пε�ͬѧ��ѧ�š�������
-- select sid,
--     sname
-- from student as A
--     right join (
--         SELECT DISTINCT student_id
--         from score
--         group by student_id
--         having count(course_id) < (
--                 select count(1)
--                 from course
--             )
--     ) as B on A.sid = B.student_id;
/*******************************************************************/
-- 9.��ѯ������һ�ſ���ѧ��Ϊ '1' ��ͬѧ��ѧ��ͬ��ͬѧ��ѧ�ź�������
-- select sid,
--     sname
-- from student as A
--     right join (
--         SELECT DISTINCT student_id
--         from score
--         where student_id != 1
--             AND course_id in (
--                 select course_id
--                 from score
--                 where student_id = 1
--             )
--     ) as B on A.sid = B.student_id;
/*******************************************************************/
-- 10.��ѯ����ѧ��ѧ��Ϊ '1' ͬѧ���пε�����ͬѧѧ�ź�������
select sid,
    sname
from student as A
    right join (
        SELECT DISTINCT student_id,
            COUNT(1) as cnt
        from score
        where student_id != 1
            AND course_id in (
                select course_id
                from score
                where student_id = 1
            )
        group by student_id
        HAVING cnt >= (
                select COUNT(1)
                from score
                where student_id = 1
            )
    ) as B on A.sid = B.student_id;