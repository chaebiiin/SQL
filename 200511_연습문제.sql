--sql DDL연습문제 (PDF파일 )
--회원관리를 위한 회원테이블을 다음과 같이 작성하시오.
--테이블 이름 : MEMBER
--속성 :
--user_id NUMBER(6) PRIMARY KEY
--user_name VARCHAR2(20) not null(member_uname_nn)
--password VARCHAR2(10) not null (member_pw_nn)
--id_num char(13) unique (member_id_uk)
--                      not null (member_id_nn)
--phone VARCHAR2(13)
--address varchar2(100)                        
--reg_date date
--insert VARCHAR2(15)

--2. 임의로 MEMBER테이블에 3건의 데이터를 입력하시오.

--3.웹사이트 게시판 테이블을 다음과 같이 생성하시오.
--테이블 이름 : board
-- 속성 :
--MEMBER 테이블 만들기
CREATE TABLE MEMBER
(user_id NUMBER(6) PRIMARY KEY,
user_name VARCHAR2(20) CONSTRAINT member_uname_nn not null,
password VARCHAR2(10) CONSTRAINT member_pw_nn not null,
id_num CHAR(13) CONSTRAINT member_id_uk UNIQUE,
phone VARCHAR2(13), address VARCHAR2(100), reg_date date, INTEREST VARCHAR2(15));

--제약조건 추가하기
--ALTER TABLE MEMBER
--MODIFY id_num CONSTRAINT member_id_nn NOT NULL; 

SELECT * FROM MEMBER;
--MEMBER 테이블 안의 내용 입력하기.
INSERT INTO MEMBER
VALUES(101, '송성광', 101, '9401011253465', '010-1234-5678', '서울시 강동구 화곡동', sysdate, 'DB');
INSERT INTO MEMBER
VALUES(102, '김영균', 102, '9301011234567', '010-9012-3456', '창원 사림동', sysdate, 'java');
INSERT INTO MEMBER
VALUES(103, '전인하', 103, '9201011234567', '010-7890-1234', '부산 동삼동', sysdate, 'internet');

--BOARD 테이블 만들고 안의 내용 입력하기
CREATE TABLE BOARD
(NO number(4) PRIMARY KEY,
SUBJECT VARCHAR2(50) CONSTRAINT board_subject_nn not null,
CONTENT VARCHAR2(2000),
RDATE date,
USER_ID number(6) CONSTRAINT board_userid_fk references MEMBER(USER_ID));

-- 게시판의 NO 열에 사용할 board_no_seq라는 이름의 시퀀스를 생성하시오. 시퀀스의 시작번호와 증분값은 각각 1로 설정
--하고 NOCACHE, NOCYCLE 속성을 주시오.
CREATE SEQUENCE board_no_seq
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

SELECT * FROM board;
SELECT * FROM member_id_uk;

--BOARD 테이블 안의 내용 입력하기
INSERT INTO BOARD
VALUES(board_no_seq.nextval,'제목','내용',sysdate,'101');
INSERT INTO BOARD
VALUES(board_no_seq.nextval,'제목1','내용1',sysdate,'102');
INSERT INTO BOARD
VALUES(board_no_seq.nextval,'제목2','내용2',sysdate,'103');

-- 회원 테이블에 email 칼럼을 추가하시오. 단, email 칼럼의 데이터 타입은 VARCHAR2(50)이다.
