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
--deptm3 ���̺��� �����, ���̺��� �⺻�� �������ִ� ���
CREATE TABLE deptm3
AS
SELECT department_id, department_name, manager_id
FROM departments
WHERE 1=2; 
--���̺��� ����� �� �ȿ� ������ �����Ϸ��� �� �� WHERE�� ������ ���� ������ �ȿ� ������ ���簡 �ȵ�.
SELECT * FROM deptm3;
--�Ŵ��� ���̵��� ����Ʈ���� 111�� �־���
ALTER TABLE deptm3
MODIFY manager_id DEFAULT 1111;
--���̺� ���� ���� ä���
INSERT INTO deptm3
VALUES(100, '�ѹ���', DEFAULT);
INSERT INTO deptm3
VALUES(200, '������', NULL);
INSERT INTO deptm3(department_id, department_name)
VALUES(300, 'ȫ����');
--NULL ������ �Ǿ��ִ� ���� �⺻��(DEFUALT)�� �ٲ���
UPDATE deptm3
SET manager_id= DEFAULT
WHERE manager_id IS NULL;

--��ũ��Ʈ ���Ͽ� �ִ� minstab�� ��������
@c:\oraclexe\labs\cre_minstab.sql

--2���� ���̺� ���������� �ѹ��� ���ε� �� (������ ���� INSERT)
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


--WHEN�� �ִ� ���ǿ� �°� ������ ����.
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

--���� first insert ���� ���� ù��° ������ �����ϴ� ���� ù��° ���̺��� ��???? �������� ������ �´�  ���������� ����?
INSERT FIRST   
-- ù ��° ����?
WHEN SAL  > 25000  THEN    
INTO special_sal VALUES(DEPTID, SAL) 

WHEN HIREDATE like ('%00%') THEN    
INTO hiredate_history_00 VALUES(DEPTID,HIREDATE)  

WHEN HIREDATE like ('%99%') THEN
INTO hiredate_history_99 VALUES(DEPTID, HIREDATE)

  ELSE  INTO hiredate_history VALUES(DEPTID, HIREDATE)
  --�� ���ǿ� �ƹ����� �� ������ else ������ ���� �Էµ�??????????
  SELECT department_id DEPTID, SUM(salary) SAL, MAX(hire_date) HIREDATE  
  FROM   employees
  GROUP BY department_id;
  
--�� �μ��� �� �޿��� �μ����� �� ���� ������ �Ի���..
SELECT department_id DEPTID, SUM(salary) SAL, MAX(hire_date) HIREDATE  
FROM   employees
GROUP BY department_id;



SELECT * FROM special_sal;
SELECT * FROM hiredate_history_99;
SELECT* FROM hiredate_history_00;
SELECT * FROM hiredate_history;

SELECT* FROM sales_source_data;
--�������� ���̺� ���� ���� �Է�
INSERT INTO sales_source_data
VALUES(144,6,1120,null,2400,1750,2120);
INSERT INTO sales_source_data
VALUES(178,7,1550,2280,1210,2900,2000);
INSERT INTO sales_source_data
VALUES(144,6,2230,1700,1330,2200,1000);
COMMIT;

DESC sales_info;
--�������� ���̺��� ������ ���̺��� ���� �߰�
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

--��ũ��Ʈ emp13�� ��������
@c:\oraclexe\labs\cre_emp13.sql
SELECT* FROM emp13;

--MERGE_emp13 ��ũ���� ���� 
--2���� ���̺��� �ϳ��� �����ϸ鼭 �ߺ��� ���̺��� (�پ�����Ʈ��)�ϸ鼭 ������
MERGE INTO emp13 c 
-- MERGE ���     
     USING employees e
     ON (c.employee_id = e.employee_id)
--������ ��(?)    
   WHEN MATCHED THEN
--�����Ѱ� �߰� �Ǹ� �Ʒ��� ������ ����
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

--MERGE_emp13 ��ũ���� ���� 
--2���� ���̺��� �ϳ��� �����ϸ鼭 �ߺ��� ���̺��� (�پ�����Ʈ��)�ϸ鼭 ������
MERGE INTO emp13 c 
-- MERGE ���     
     USING employees e
     ON (c.employee_id = e.employee_id)
--������ ��(?)    
   WHEN MATCHED THEN
--�����Ѱ� �߰� �Ǹ� �Ʒ��� ������ ����
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

-- ~flashback  �����~
-- �߸� �Է��� �͵��� "Ȯ��" �ۿ� ����, ������ ���� �ؾ� ��
--flashback  query <-�ð��� �����ؼ� ã�� (UNDOdata�� �ִ� �͵��� �̿�)
--flashback version query <-������ ���ð�??�� ������????(UNDOdata�� �ִ� �͵��� �̿�)
--flashback  Transactions query <- ������ ������ ���� ã�Ƽ� ������???(UNDOdata�� �ִ� �͵��� �̿�) 

--flashback undrop -> Recyclebin(������)�̿�
--flashback table -> undodata �̿� rollback ����
--flashback data Archive ->Archive ������ ���� ����� ��⺸��? (���̺� �ӹ��� �Ⱓ�� �� �� �� ����, ���� �������� ���� ���� ��ο��� �����ð� ���� �ִٰ� �����)
--�� ���̺� ������ 
--flashback database ->data log ������ �̿��ؼ�????


--run sql ����!!!
-- �����ڷ� ����
--SQL> conn / as sysdba
--Connected.
--�� hr������ flashback �� �� �ִ� �����ֱ�?
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
--178�� ����� �޿��� 9000���� ����
UPDATE employees
SET salary = 9000
WHERE employee_id =178;
COMMIT;

--FALSHBACK QUERY�� ���� ���� (5���� �����͸� Ȯ��)
SELECT salary FROM employees
AS OF TIMESTAMP (systimestamp -5/(24*60))
WHERE employee_id = 178;
--���� �ϱ� ���� ������ �ٽ� �� ���� ���� ����
UPDATE employees
SET salary = 8400
WHERE employee_id = 178;
COMMIT;
--�ϳ��� �����Ͱ� ��� ���̿� ������ ������ (178�� ����� �޿��� 8400���� 9000���� �ٲ�ٰ� �ٽ� 8400���� �ٲ�ٰ� �ٽ� 9200���� �ٲ��ܤ���)
UPDATE employees
SET salary = 9200
WHERE employee_id =178;
COMMIT;

--�̶����� ���� �Ǿ��� ������� �ð����� �� ���� ��
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

--transaction query�� �ؼ� ���� ������ Ȯ���ؼ�, �����ؼ� ������ ��
update "HR"."EMPLOYEES" set "SALARY" = '9000' where ROWID = 'AAAE5oAAEAAAADPABO';

SELECT * FROM employees
WHERE employee_id = 178;
COMMIT;


SELECT versions_starttime, versions_endtime, versions_xid, salary
FROM employees
VERSIONS BETWEEN TIMESTAMP minvalue AND maxvalue
WHERE employee_id = 178;
