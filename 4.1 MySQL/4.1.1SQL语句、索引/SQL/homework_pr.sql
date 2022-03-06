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
-- 1.查询平均成绩大于60分的同学的学号和平均成绩；
/*
 select student_id,
 avg(num) as avgnum
 from score
 group by student_id
 having avgnum > 60;
 */
/*******************************************************************/
-- 2.查询 'c++高级架构' 课程比 '音视频' 课程成绩高的所有学生的学号；
-- 找到课程对应的cid
-- select cid
-- from course
-- where cname = 'C++高级架构';
-- select cid
-- from course
-- where cname = '音视频';
-- 找到学生成绩
-- select student_id,
--     num
-- from score
-- where course_id = (
--         select cid
--         from course
--         where cname = 'C++高级架构'
--     );
-- select student_id,
--     num
-- from score
-- where course_id = (
--         select cid
--         from course
--         where cname = '音视频'
--     );
-- 两张表是同一张表所以使用
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
 where cname = 'C++高级架构'
 )
 ) as A
 INNER join (
 select student_id,
 num
 from score
 where course_id = (
 select cid
 from course
 where cname = '音视频'
 )
 ) as B on A.student_id = B.student_id
 )
 where A.num > B.num;
 */
/*******************************************************************/
-- 3.查询所有同学的学号、姓名、选课数、总成绩；
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
-- 4.查询没学过 '谢小二' 老师课的同学的学号、姓名；
-- 查询'谢小二' 老师的课的cid
-- select cid
-- from course
--     left join teacher on course.teacher_id = teacher.tid
-- where teacher.tname = '谢小二老师';
-- 查询哪些学生选了谢小二老师的课
-- select DISTINCT student_id
-- from score
-- where course_id in (
--         select cid
--         from course
--             left join teacher on course.teacher_id = teacher.tid
--         where teacher.tname = '谢小二老师'
--     );
-- 最后一步
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
--                 where teacher.tname = '谢小二老师'
--             )
--     );
/*******************************************************************/
-- 5.查询学过课程编号为 '1' 并且也学过课程编号为 '2' 的同学的学号、姓名；
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
-- 6.查询学过 '谢小二' 老师所教的所有课的同学的学号、姓名；
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
--                 where teacher.tname = '谢小二老师'
--             )
--     );
/*******************************************************************/
-- 7.查询有课程成绩小于 60 分的同学的学号、姓名；
-- select sid,
--     sname
-- from student as A
--     right join (
--         SELECT DISTINCT student_id
--         from score
--         where num < 60
--     ) as B on A.sid = B.student_id;
/*******************************************************************/
-- 8.查询没有学全所有课的同学的学号、姓名；
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
-- 9.查询至少有一门课与学号为 '1' 的同学所学相同的同学的学号和姓名；
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
-- 10.查询至少学过学号为 '1' 同学所有课的其他同学学号和姓名；
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