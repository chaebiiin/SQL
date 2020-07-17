--sql DDL�������� (PDF���� )
--ȸ�������� ���� ȸ�����̺��� ������ ���� �ۼ��Ͻÿ�.
--���̺� �̸� : MEMBER
--�Ӽ� :
--user_id NUMBER(6) PRIMARY KEY
--user_name VARCHAR2(20) not null(member_uname_nn)
--password VARCHAR2(10) not null (member_pw_nn)
--id_num char(13) unique (member_id_uk)
--                      not null (member_id_nn)
--phone VARCHAR2(13)
--address varchar2(100)                        
--reg_date date
--insert VARCHAR2(15)

--2. ���Ƿ� MEMBER���̺� 3���� �����͸� �Է��Ͻÿ�.

--3.������Ʈ �Խ��� ���̺��� ������ ���� �����Ͻÿ�.
--���̺� �̸� : board
-- �Ӽ� :
--MEMBER ���̺� �����
CREATE TABLE MEMBER
(user_id NUMBER(6) PRIMARY KEY,
user_name VARCHAR2(20) CONSTRAINT member_uname_nn not null,
password VARCHAR2(10) CONSTRAINT member_pw_nn not null,
id_num CHAR(13) CONSTRAINT member_id_uk UNIQUE,
phone VARCHAR2(13), address VARCHAR2(100), reg_date date, INTEREST VARCHAR2(15));

--�������� �߰��ϱ�
--ALTER TABLE MEMBER
--MODIFY id_num CONSTRAINT member_id_nn NOT NULL; 

SELECT * FROM MEMBER;
--MEMBER ���̺� ���� ���� �Է��ϱ�.
INSERT INTO MEMBER
VALUES(101, '�ۼ���', 101, '9401011253465', '010-1234-5678', '����� ������ ȭ�', sysdate, 'DB');
INSERT INTO MEMBER
VALUES(102, '�迵��', 102, '9301011234567', '010-9012-3456', 'â�� �縲��', sysdate, 'java');
INSERT INTO MEMBER
VALUES(103, '������', 103, '9201011234567', '010-7890-1234', '�λ� ���ﵿ', sysdate, 'internet');

--BOARD ���̺� ����� ���� ���� �Է��ϱ�
CREATE TABLE BOARD
(NO number(4) PRIMARY KEY,
SUBJECT VARCHAR2(50) CONSTRAINT board_subject_nn not null,
CONTENT VARCHAR2(2000),
RDATE date,
USER_ID number(6) CONSTRAINT board_userid_fk references MEMBER(USER_ID));

-- �Խ����� NO ���� ����� board_no_seq��� �̸��� �������� �����Ͻÿ�. �������� ���۹�ȣ�� ���а��� ���� 1�� ����
--�ϰ� NOCACHE, NOCYCLE �Ӽ��� �ֽÿ�.
CREATE SEQUENCE board_no_seq
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

SELECT * FROM board;
SELECT * FROM member_id_uk;

--BOARD ���̺� ���� ���� �Է��ϱ�
INSERT INTO BOARD
VALUES(board_no_seq.nextval,'����','����',sysdate,'101');
INSERT INTO BOARD
VALUES(board_no_seq.nextval,'����1','����1',sysdate,'102');
INSERT INTO BOARD
VALUES(board_no_seq.nextval,'����2','����2',sysdate,'103');

-- ȸ�� ���̺� email Į���� �߰��Ͻÿ�. ��, email Į���� ������ Ÿ���� VARCHAR2(50)�̴�.
