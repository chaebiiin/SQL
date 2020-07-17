SELECT department_name, city
FROM departments
NATURAL JOIN (SELECT l.location_id, l.city, l.country_id
                        FROM locations l
                        JOIN countries c
                        ON (l.country_id = c. country_id)
                        JOIN regions 
                        USING (region_id)
                        WHERE region_name = 'Europe');
                        
INSERT INTO (SELECT l.location_id, l.city, l.country_id
                        FROM locations l
                        JOIN countries c
                        ON (l.country_id = c. country_id)
                        JOIN regions 
                        USING (region_id)
                        WHERE region_name = 'Europe')
VALUES (3300, 'Cardiff', 'UK');

SELECT l.location_id, l.city, l.country_id
                        FROM locations l
                        JOIN countries c
                        ON (l.country_id = c. country_id)
                        JOIN regions 
                        USING (region_id)
                        WHERE region_name = 'Europe';
                        
SELECT location_id, city, country_id
FROM locations;
--deptm3 테이블을 만들고, 테이블의 기본값 지정해주는 방법
CREATE TABLE deptm3
AS
SELECT department_id, department_name, manager_id
FROM departments
WHERE 1=2; 
--테이블을 만들고 그 안에 내용을 복사하려고 할 때 WHERE에 엉뚱한 값을 넣으면 안에 내용은 복사가 안됨.
SELECT * FROM deptm3;
--매니저 아이디의 디폴트값을 111로 주어줌
ALTER TABLE deptm3
MODIFY manager_id DEFAULT 1111;
--테이블 안의 내용 채우기
INSERT INTO deptm3
VALUES(100, '총무부', DEFAULT);
INSERT INTO deptm3
VALUES(200, '영업부', NULL);
INSERT INTO deptm3(department_id, department_name)
VALUES(300, '홍보부');
--NULL 값으로 되어있는 것을 기본값(DEFUALT)로 바꿔줌
UPDATE deptm3
SET manager_id= DEFAULT
WHERE manager_id IS NULL;

--스크립트 파일에 있는 minstab를 실행해줌
@c:\oraclexe\labs\cre_minstab.sql

--2개의 테이블에 같은내용이 한번에 업로드 됨 (조건이 없는 INSERT)
INSERT  ALL
INTO sal_history VALUES(EMPID,HIREDATE,SAL)
INTO mgr_history VALUES(EMPID,MGR,SAL)
SELECT employee_id EMPID, hire_date HIREDATE, salary SAL, manager_id MGR 
FROM  employees
WHERE employee_id > 200;

SELECT employee_id EMPID, hire_date HIREDATE, salary SAL, manager_id MGR 
FROM  employees
WHERE employee_id > 200;

SELECT* FROM sal_history;
SELECT* FROM mgr_history;

ROLLBACK;


--WHEN에 있는 조건에 맞게 내용을 넣음.
INSERT ALL
WHEN SAL > 10000 THEN
INTO sal_history VALUES(EMPID,HIREDATE,SAL)
WHEN MGR > 200   THEN 
INTO mgr_history VALUES(EMPID,MGR,SAL)  
    SELECT employee_id EMPID,hire_date HIREDATE,  
           salary SAL, manager_id MGR 
    FROM   employees
    WHERE  employee_id > 200;

SELECT employee_id EMPID,hire_date HIREDATE,  
           salary SAL, manager_id MGR 
 FROM   employees
WHERE  employee_id > 200;

SELECT* FROM sal_history;
SELECT * FROM mgr_history;

--조건 first insert 구문 제일 첫번째 조건을 만족하는 행은 첫번째 테이블에만 들어감???? 나머지는 조건이 맞는  여러군데에 들어간다?
INSERT FIRST   
-- 첫 번째 조건?
WHEN SAL  > 25000  THEN    
INTO special_sal VALUES(DEPTID, SAL) 

WHEN HIREDATE like ('%00%') THEN    
INTO hiredate_history_00 VALUES(DEPTID,HIREDATE)  

WHEN HIREDATE like ('%99%') THEN
INTO hiredate_history_99 VALUES(DEPTID, HIREDATE)

  ELSE  INTO hiredate_history VALUES(DEPTID, HIREDATE)
  --위 조건에 아무데도 안 맞으면 else 지정된 곳에 입력됨??????????
  SELECT department_id DEPTID, SUM(salary) SAL, MAX(hire_date) HIREDATE  
  FROM   employees
  GROUP BY department_id;
  
--각 부서별 총 급여와 부서원들 중 가장 마지막 입사일..
SELECT department_id DEPTID, SUM(salary) SAL, MAX(hire_date) HIREDATE  
FROM   employees
GROUP BY department_id;



SELECT * FROM special_sal;
SELECT * FROM hiredate_history_99;
SELECT* FROM hiredate_history_00;
SELECT * FROM hiredate_history;

SELECT* FROM sales_source_data;
--영업실적 테이블 안의 내용 입력
INSERT INTO sales_source_data
VALUES(144,6,1120,null,2400,1750,2120);
INSERT INTO sales_source_data
VALUES(178,7,1550,2280,1210,2900,2000);
INSERT INTO sales_source_data
VALUES(144,6,2230,1700,1330,2200,1000);
COMMIT;

DESC sales_info;
--영업실적 테이블의 내용의 테이블을 새로 추가
ALTER TABLE sales_info
ADD sales_day CHAR(3);

INSERT ALL
INTO sales_info VALUES (employee_id,week_id,sales_MON, 'MON')  
INTO sales_info VALUES (employee_id,week_id,sales_TUE, 'TUE')
INTO sales_info VALUES (employee_id,week_id,sales_WED, 'WED')
INTO sales_info VALUES (employee_id,week_id,sales_THUR, 'THU')
INTO sales_info VALUES (employee_id,week_id, sales_FRI, 'FRI')
SELECT EMPLOYEE_ID, week_id, sales_MON, sales_TUE,
       sales_WED, sales_THUR,sales_FRI 
FROM sales_source_data;


SELECT * FROM sales_info;
DELETE FROM sales_info
WHERE sales IS NULL;
COMMIT;
SELECT employee_id, sales_day, AVG(sales)
FROM sales_info
GROUP BY employee_id, sales_day
ORDER BY 1, 3;

--스크립트 emp13을 실행해줌
@c:\oraclexe\labs\cre_emp13.sql
SELECT* FROM emp13;

--MERGE_emp13 스크립터 실행 
--2개의 테이블을 하나로 병합하면서 중복된 테이블은 (☆업데이트☆)하면서 병합함
MERGE INTO emp13 c 
-- MERGE 대상     
     USING employees e
     ON (c.employee_id = e.employee_id)
--데이터 비교(?)    
   WHEN MATCHED THEN
--동일한게 발견 되면 아래의 내용이 실행
     UPDATE SET
       c.last_name      = e.last_name,
       c.job_id         = e.job_id,
       c.salary         = e.salary,
       c.department_id  = e.department_id
  WHEN NOT MATCHED THEN
     INSERT VALUES(e.employee_id, e.last_name,e.job_id,
          e.salary, e.department_id);
          
ROLLBACK;          
COMMIT;

@c:\oraclexe\labs\cre_emp13.sql
SELECT* FROM emp13;

--MERGE_emp13 스크립터 실행 
--2개의 테이블을 하나로 병합하면서 중복된 테이블은 (☆업데이트☆)하면서 병합함
MERGE INTO emp13 c 
-- MERGE 대상     
     USING employees e
     ON (c.employee_id = e.employee_id)
--데이터 비교(?)    
   WHEN MATCHED THEN
--동일한게 발견 되면 아래의 내용이 실행
     UPDATE SET
       c.last_name      = e.last_name,
       c.job_id         = e.job_id,
       c.salary         = e.salary,
       c.department_id  = e.department_id
  WHEN NOT MATCHED THEN
     INSERT VALUES(e.employee_id, e.last_name,e.job_id,
          e.salary, e.department_id);
          
ROLLBACK;          
COMMIT;

-- ~flashback  기술들~
-- 잘못 입력한 것들을 "확인" 밖에 못함, 수정은 내가 해야 함
--flashback  query <-시간을 지정해서 찾음 (UNDOdata에 있는 것들을 이용)
--flashback version query <-쿼리한 모든시간??을 보여줌????(UNDOdata에 있는 것들을 이용)
--flashback  Transactions query <- 쿼리한 문장을 토대로 찾아서 보여줌???(UNDOdata에 있는 것들을 이용) 

--flashback undrop -> Recyclebin(휴지통)이용
--flashback table -> undodata 이용 rollback 해줌
--flashback data Archive ->Archive 파일을 새로 만들어 장기보관? (테이블에 머무는 기간을 정 할 수 있음, 값이 정해지지 않은 값은 언두에서 일정시간 동안 있다가 사라짐)
--↑ 테이블 단위임 
--flashback database ->data log 파일을 이용해서????


--run sql 실행!!!
-- 관리자로 접속
--SQL> conn / as sysdba
--Connected.
--↓ hr계정에 flashback 할 수 있는 권한주기?
--SQL> ALTER database add supplemental log data;
--Database altered.

--SQL> ALTER database add supplemental log data(primary key) columns;
--Database altered.

--SQL> GRANT execute on dbms_flashback to hr;
--Grant succeeded.

--SQL> GRANT select any transaction to hr;
--Grant succeeded.

SELECT * FROM employees
WHERE employee_id =178;
--178번 사원의 급여를 9000으로 변경
UPDATE employees
SET salary = 9000
WHERE employee_id =178;
COMMIT;

--FALSHBACK QUERY를 위한 문장 (5분전 데이터를 확인)
SELECT salary FROM employees
AS OF TIMESTAMP (systimestamp -5/(24*60))
WHERE employee_id = 178;
--수정 하기 전의 값으로 다시 재 수정 해줌 ㅎㅎ
UPDATE employees
SET salary = 8400
WHERE employee_id = 178;
COMMIT;
--하나의 데이터가 잠깐 사이에 여러번 수정됨 (178번 사원의 급여를 8400에서 9000으로 바꿨다가 다시 8400으로 바꿨다가 다시 9200으로 바꿔줌ㅋㅋ)
UPDATE employees
SET salary = 9200
WHERE employee_id =178;
COMMIT;

--이때까지 수정 되었던 내용들을 시간별로 다 보여 줌
--flashback version query
SELECT versions_starttime, versions_endtime, versions_xid, salary
FROM employees
VERSIONS BETWEEN TIMESTAMP minvalue AND maxvalue
WHERE employee_id = 178;

--flashback transaction query
SELECT undo_sql FROM flashback_transaction_query
WHERE table_owner = 'HR'
AND table_name = 'EMPLOYEES'
AND xid = '02000300DD010000';

--transaction query를 해서 나온 문장을 확인해서, 복사해서 실행해 봄
update "HR"."EMPLOYEES" set "SALARY" = '9000' where ROWID = 'AAAE5oAAEAAAADPABO';

SELECT * FROM employees
WHERE employee_id = 178;
COMMIT;


SELECT versions_starttime, versions_endtime, versions_xid, salary
FROM employees
VERSIONS BETWEEN TIMESTAMP minvalue AND maxvalue
WHERE employee_id = 178;
