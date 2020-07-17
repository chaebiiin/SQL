-- ���̺��� ������ ����� �� (Ŀ�� �Ǹ� ���� ������ ������.)
--���� ���� �ϰ�, �� �����ϸ� ���� �Ǿ��� ������ ����. 
CREATE GLOBAL TEMPORARY TABLE emp_temp1
ON COMMIT DELETE ROWS
AS
SELECT employee_id, salary, department_id
FROM employees;

--���̺��� ������ ���� ���� �Ǿ� ������� (������ ����Ǳ� �������� �ڷ��� ������ ���� ����)
CREATE GLOBAL TEMPORARY TABLE emp_temp2
ON COMMIT PRESERVE ROWS
AS
SELECT employee_id, salary, department_id
FROM employees;

--���̺� ���� ���� �Է��ϱ� 
INSERT INTO emp_temp1
SELECT employee_id,salary, department_id
FROM employees
WHERE department_id = 90;

INSERT INTO emp_temp2
SELECT employee_id, salary, department_id
FROM employees
WHERE salary > 9000;

SELECT * FROM emp_temp1;
SELECT* FROM emp_temp2;

COMMIT;
UPDATE emp_temp2
SET salary = salary*1.1;

--���̺� �ȿ� ����� �����?
TRUNCATE TABLE emp_temp2; 
--���̺� ����
DROP TABLE emp_temp2;
DROP TABLE emp_temp1;

--���Ѿ˾ƺ��� ��
SELECT * FROM session_privs;


--run sql
--SQL> conn system/oracle (oracle�� ����)
--SQL> create directory dir_1 as 'c:\oraclexe\test';(dir_1 ������ ���� ��� ����(window test = dir_1)
--SQL> grant read, write on directory dir_1 to hr; (hr�����ڿ��� �а� ���� �� ���� �ֱ�)

--�ܺ����̺� ����� oracle lodear�� �о�� ����,������ ���쳪 �ƹ��� �� �� �ְ�, ������ �� �� �� �־ ���ȼ��� ������.
CREATE TABLE empxt (empno       NUMBER(4),
                        ename       VARCHAR2(10),
                         job         VARCHAR2(9),
                         mgr         NUMBER(4),
                         hiredate    DATE,
                         sal         NUMBER(7,2),
                         comm        NUMBER(7,2),
                         deptno      NUMBER(2)
                        )
          ORGANIZATION EXTERNAL
           (
            TYPE ORACLE_LOADER
            DEFAULT DIRECTORY dir_1
            ACCESS PARAMETERS
            (
              records delimited by newline
              badfile dir_1:'empxt.bad'
              logfile dir_1:'empxt.log'
              fields terminated by ','
              missing field values are null
              ( empno, ename, job, mgr,
               hiredate char date_format date mask "dd-mon-yy",
                sal, comm, deptno
              )
            )
            LOCATION ('emp.dat')
          ) ;
DESC empxt;
SELECT * FROM empxt;

--�ܺ� ���̺� �����2 datapump�� �о�� (���� ���Ͽ����� ���� ) ���ȼ��� ����. �ƹ��� �� ��
create table empxt2
      Organization external
     (type oracle_datapump
      Default directory dir_1
      Location('emp2.dat'))
      As
      Select * from employees
      WHERE hire_date < '99/01/01';
      
SELECT * FROM empxt2;


-- �������� Ȯ���ϱ� USER_CONSTRAINTS;