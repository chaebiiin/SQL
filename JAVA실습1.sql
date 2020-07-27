create table student(
        id varchar2(10) primary key,
        name varchar2(30),
        tel varchar2(14));
        
desc student;

insert all into student(id, name, tel)
values (2018001, 'È«±æµ¿', '010-1111-0111')
into student(id, name, tel)
values(2018002, '±èÄ¡±¹', '010-1111-1111')
select * from dual;

drop table student_grade;
CREATE table student_grade(id number(8), name VARCHAR(20), korean number(5), english number(5),
math number(5), history number(5));


alter table student_grade add
(CONSTRAINT fk_id FOREIGN key(id)
REFERENCES student(id));

select* from student_grade;
select * from student;
insert all into student_grade(id, name, korean,english,math, history)
values (2018001, 'È«±æµ¿', 80,80,90,90)
into student_grade(id, name, korean,english,math,history)
values(2018002, '±èÄ¡±¹', 83,80,79,80)
select * from dual;

select id, name, korean,english,math,history, korean+ENGLISH+HISTORY+MATH  as ÃÑÁ¡ from student_grade;