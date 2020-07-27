drop table member;

create table member(
        id varchar2(10) primary key,
        password varchar2(20),
        name varchar2(30),
        tel varchar2(14));
        

insert into member values ('kim', '0215','김원식','010-0524-0215');

insert into member values ('cha', '0630','차학연','010-0524-0630');
select * from member;
commit;
desc member;

drop table board;

create table board(
        no number primary key,
        id varchar2(10) not null,
        title varchar2(100) not null,
        contents varchar2(1000) not null,
        CONSTRAINT member_fk FOREIGN key (id)
        REFERENCES member(id) on DELETE CASCADE  );
         
select * from board;
desc board;
 insert all
into BOARD(no, id, title, contents) 
values (1, 'kim','데이터베이스','데이터베이스의 관계정의 하기')
into BOARD(no, id, title, contents) 
values (2, 'lee','데이터베이스','데이터베이스의 관계정의 하기')
into BOARD(no, id, title, contents) 
values (3, 'cha','데이터베이스','데이터베이스의 관계정의 하기')
into BOARD(no, id, title, contents) 
values (4, 'Leo','Java','Java 개발하기')

select * from dual;

insert into board VALUES(5, 'kong','Java','Java 개발하기');
insert into board VALUES(6, 'hyuk','Java','Java 개발하기');

select * from member,board;