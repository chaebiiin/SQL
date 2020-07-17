-- 테이블의 구조만 만들어 짐 (커밋 되면 안의 내용이 없어짐.)
--접속 해지 하고, 재 접속하면 복사 되어진 내용이 날라감. 
CREATE GLOBAL TEMPORARY TABLE emp_temp1
ON COMMIT DELETE ROWS
AS
SELECT employee_id, salary, department_id
FROM employees;

--테이블의 데이터 까지 복사 되어 만들어짐 (세션이 종료되기 전까지만 자료의 내용이 남아 있음)
CREATE GLOBAL TEMPORARY TABLE emp_temp2
ON COMMIT PRESERVE ROWS
AS
SELECT employee_id, salary, department_id
FROM employees;

--테이블 안의 내용 입력하기 
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

--테이블 안에 내용들 지우기?
TRUNCATE TABLE emp_temp2; 
--테이블 삭제
DROP TABLE emp_temp2;
DROP TABLE emp_temp1;

--권한알아보는 것
SELECT * FROM session_privs;


--run sql
--SQL> conn system/oracle (oracle로 접속)
--SQL> create directory dir_1 as 'c:\oraclexe\test';(dir_1 파일을 만들 경로 지정(window test = dir_1)
--SQL> grant read, write on directory dir_1 to hr; (hr접속자에게 읽고 수정 할 권한 주기)

--외부테이블 만들기 oracle lodear로 읽어옴 수정,관리가 쉬우나 아무나 볼 수 있고, 수정을 할 수 가 있어서 보안성이 떨어짐.
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

--외부 테이블 만들기2 datapump로 읽어옴 (전용 파일에서만 읽힘 ) 보안성이 좋음. 아무나 못 봄
create table empxt2
      Organization external
     (type oracle_datapump
      Default directory dir_1
      Location('emp2.dat'))
      As
      Select * from employees
      WHERE hire_date < '99/01/01';
      
SELECT * FROM empxt2;


-- 제약조건 확인하기 USER_CONSTRAINTS;