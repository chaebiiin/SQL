SELECT employee_id �����ȣ, last_name �̸�, salary ����, department_id �μ���ȣ, &&col_name
FROM employees
ORDER BY &col_name;
-- & ������ ����� ��Ģ��, �̰� ġȯ ������� �θ�,  && <- ����Ʈ���� 2���� ���� �������̿� �ִ� &�� �ڵ������� ����(?)

SELECT employee_id �����ȣ, last_name �̸�, salary ����, department_id �μ���ȣ, &&col_name
FROM employees
ORDER BY &col_name;
UNDEFINE col_name
DEFINE col_name
-- UNDEFINE�̶� &�� �׻� ��Ʈ�� �Է��ؾ� ��. EFINE�� ������ ���� Ȯ���� ���� ��ɹ��̴�.

--�Լ����~~
SELECT  UPPER('Oracle DB'), LOWER('Oracle DB'), INITCAP('Oracle DB')
FROM dual;
-- UPPER(��� �빮�ڷ�), LOWER(��� �ҹ��ڷ�), INITCAP(�� ���ڸ� �빮�ڷ�), dual ->��ĭ...? ����� �ӽ÷� ��¹��� �� 
SELECT 2345*2
FROM dual;


SELECT employee_id, CONCAT(CONCAT(first_name,' '), last_name) AS Full_name
FROM employees;
-- �Լ��� ��ø�Ǿ ���� �� �� �ִ�. CONCAT(CONCAT(����, ����),����)

SELECT *
FROM employees
WHERE   SUBSTR(last_name,-1,1) ='s';
 --�˻���� ����/  WHERE (_____) LIKE �� ����� ����� ����

SELECT *
FROM employees
WHERE last_name LIKE '%s';

SELECT employee_id, last_name, LENGTH(last_name)
FROM employees;

SELECT LENGTHB('oracle'), LENGTHB('����Ŭ')
FROM dual;
-- ������ ���� �ľ����ִ� �Լ� / LENGTHB->������ ����Ʈ �ľ��ؼ� ��Ÿ���� 

SELECT employee_id, last_name, INSTR(last_name, 'a',1,2)
FROM employees;

SELECT *
FROM employees
WHERE INSTR(last_name,'a') <> 0;
--�����ʴ�

SELECT *
FROM employees
WHERE last_name LIKE '%a%';
--���ԵǾ� �ִ� ���� �˻� �Լ�

SELECT RPAD(last_name, 15, '*') AS last_name,
             LPAD(salary, 10, '*') AS salary
 FROM employees;            
-- ��ġ..? R�� ������ L�� ����  RPAD(���̺�, ������ ����Ʈ, '��ġ�� ���ڳ� ��ȣ')

SELECT TRIM('w' FROM 'window'), TRIM('e' FROM 'oracle')
FROM dual;
--���� ���� ����/ �����ϰ��� �ϴ� ���ڰ� �ִ� �� ������ ������/ (LEADING�� ����, TRAILING�� ����)

SELECT CONCAT('+82',TRIM(LEADING '0' FROM '01012345670'))
FROM dual;

SELECT employee_id, last_name,
            REPLACE(last_name, SUBSTR(last_name,2,2), '**')
FROM employees; 

SELECT*
FROM employees
WHERE LOWER(last_name) = 'king';

SELECT*
FROM employees
WHERE last_name = INITCAP('king');

-- \\\\\\\\\\\\\\���� �Լ�\\\\\\\\\\\\\\

SELECT ROUND(45.927, 2), ROUND(45.927, 1),
             ROUND(45.927), ROUND(45.927, -1)
FROM dual;
SELECT TRUNC(45.927, 2), TRUNC(49.927, 1),
             TRUNC(45.927), TRUNC(45.927, -1)
FROM dual;

SELECT employee_id, salary, MOD(salary, 70)
FROM employees;

SELECT sysdate+10, sysdate-10 FROM dual;

SELECT employee_id, hire_date, TRUNC(sysdate-hire_date)
FROM employees;

SELECT employee_id, hire_date, 
           MONTHS_BETWEEN(sysdate,hire_date)
FROM employees;

SELECT employee_id, hire_date, 
            ROUND(MONTHS_BETWEEN(sysdate,hire_date))
FROM employees;

SELECT ADD_MONTHS(sysdate, 6)
FROM dual;         

SELECT NEXT_DAY(sysdate, 1) ���³� FROM dual;
-- ��¥, ������ ã���ִ°� �Ͽ�ȭ�������  ������� 1~7������ ��Ÿ �� �� ����.
SELECT LAST_DAY(sysdate) FROM dual;
-- ���� �޿��� ������ ��¥�� ǥ������

SELECT ROUND(sysdate, 'year'), ROUND(sysdate, 'month'),
            ROUND(sysdate, 'dd'), ROUND(sysdate, 'd')
FROM dual;
--ROUND(sysdate, 'year') ����?����?, ROUND(sysdate, 'month') ����?����?,
  ROUND(sysdate, 'dd') �Ϸ��� ���� ����?����?, ROUND(sysdate, 'd') ���� (�Ͽ���)
            
SELECT TRUNC(sysdate, 'year'), TRUNC(sysdate, 'month'),
             TRUNC(sysdate, 'dd'), TRUNC(sysdate, 'd')
FROM dual;

--��� ���̺�κ��� �ٹ��� ���� (MONTHS_BETWEEN)�� ��Ÿ����, �Ի� �� 6���� ���� (ADD_MOUNTS) ��¥��
--�Ի� �� ó�� �����ϴ� �ݿ���(NEXT_DAY), �Ի��� ���� 1��(TRUNC)�� ����(LAST_DAY)�� ǥ���Ͻÿ�.
SELECT employee_id, TRUNC(MONTHS_BETWEEN(sysdate,hire_date)),
             ADD_MONTHS(hire_date, 6), NEXT_DAY(hire_date, 6),
             TRUNC(hire_date, 'month'), LAST_DAY(hire_date)
 FROM employees;            
 
 SELECT sysdate FROM dual;            
-- 20/04/21  -> 2020-04-21  17:45:00 ȭ���� 
SELECT TO_CHAR(sysdate,'yyyy-mm-dd hh24:mi:ss q' ) FROM dual;
--q�� �б⸦ ��Ÿ��
SELECT TO_CHAR(sysdate,'yyyy"��"mm"��"dd"��" hh24"��"mi"��"ss' ) FROM dual;
--��¥�� TO_CHAR�� ���� ���·� ����� �� �� ����.
