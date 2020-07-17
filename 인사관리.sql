select employee_id, last_name, salary, commission_pct,
          salary+ salary*commission_pct AS ����
From EMPLOYEES;
-- AS�� ��Ī ���� ��ɾ�! �����ص���!, ��Ī�� �ѱ۵������ϴ�

select employee_id empno, last_name, salary AS Original_Salary, commission_pct "Comm Pct",
          salary+ salary*commission_pct AS ����
From EMPLOYEES;
-- ""�� ��Ī�� ��ҹ������� Ư������, ���Ⱑ ���� ��! �����(_)�� Ư�����ڰ� �ƴ϶�, ����� ���� ��

SELECT employee_id, hire_date, hire_date+365
FROM employees;
-- ��¥��  + -�� ������
SELECT last_name �̸�, salary "��_��", 12*salary
FROM employees;

SELECT last_name �̸�, salary "��_��", 12*salary
FROM employees;

SELECT employee_id, first_name || last_name  AS "fullname"
FROM EMPLOYEES;
-- || �÷��� �÷��� �����ؼ� ������� ����� 

SELECT employee_id, first_name ||' '|| last_name ||q'['s job is]' ||' '|| job_id as fullname
FROM EMPLOYEES;

SELECT employee_id, first_name ||'��'|| last_name Fullname
FROM employees;
-- ' ' ������ �տ� ���� �Է��ϰ� ���� �� ����

select DISTINCT department_id
From employees;

-- DISTINCT�� �ߺ����� �����ϰ� ������, SELECT �ڿ� �ѹ��� �Է°�����, DISTINCT �ڿ� �÷��� (,)�� ������ �̾����°� ����
select DISTINCT department_id, Job_id
From employees;

DESCRIBE employees;
-- ���̺� ������ �˼� �ְ� ���ִ� ��ɾ�, DESC�� �����ؼ� �Է� ������,

--2��!!! ����
SELECT employee_id �����ȣ, last_name, salary ����, department_id �μ���ȣ
FROM EMPLOYEES
WHERE department_id = 80;
-- ���ǿ� �´� ��°� ã�� ��ɾ�  WHERE/ = <-�񱳿�����, ��°��� ����(��¥)�� ������ �� ''���� ���ڴ� ��ҹ��ڱ��� �°� �������
SELECT employee_id �����ȣ, last_name, salary ����, department_id �μ���ȣ
FROM EMPLOYEES
WHERE last_name = 'King';
SELECT employee_id �����ȣ, last_name, salary ����, department_id �μ���ȣ, hire_date �Ի���
FROM EMPLOYEES
WHERE hire_date = '87-06-17';

SELECT employee_id �����ȣ, last_name, salary ����, department_id �μ���ȣ, hire_date �Ի���
FROM EMPLOYEES
WHERE hire_date < '99/01/01';
-- >, <, >=, <>��� �� ��� ��ȣ
SELECT employee_id �����ȣ, last_name �̸�, salary ����, department_id �μ���ȣ, hire_date �Ի���
FROM EMPLOYEES
WHERE last_name <> 'King';

SELECT employee_id �����ȣ, last_name �̸�, salary ����, department_id �μ���ȣ, hire_date �Ի���
FROM EMPLOYEES
WHERE department_id IN (50,80,90);
-- 'IN' =�� Ȯ��, ���߰˻����!

SELECT employee_id �����ȣ, last_name �̸�, salary ����, department_id �μ���ȣ, hire_date �Ի���
FROM EMPLOYEES
WHERE salary BETWEEN 5000 AND 10000;
-- ~��~ ������ �� �˻�
SELECT employee_id �����ȣ, last_name �̸�, salary ����, department_id �μ���ȣ, hire_date �Ի���
FROM EMPLOYEES
WHERE hire_date BETWEEN '99/01/01' AND '99/12/31';

SELECT employee_id �����ȣ, last_name �̸�, salary ����, department_id �μ���ȣ, hire_date �Ի���
FROM EMPLOYEES
WHERE last_name LIKE '%i%';
-- "LIKE ���ϸ�Ī/ ���þ� �˻����/   %<-��ȣ�� ������ ������/  _(�����)�� ����� ����� �� (����ٰ� ���� �ϳ��� �����)

SELECT employee_id �����ȣ, last_name �̸�, salary ����, department_id �μ���ȣ, hire_date �Ի���, job_id
FROM EMPLOYEES
WHERE job_id LIKE 'AC\_%' ESCAPE '\';
-- �������� �� ��, �Է� �� �ڿ�\ (�齽����) �Է� �� ESCAPE '\' ���� �ֱ�  

SELECT employee_id �����ȣ, last_name �̸�, salary ����, department_id �μ���ȣ, hire_date �Ի���
FROM EMPLOYEES
WHERE hire_date LIKE '87%';

SELECT employee_id �����ȣ, last_name �̸�, salary ����, department_id �μ���ȣ, hire_date �Ի���, job_id
FROM EMPLOYEES
WHERE commission_pct IS null;
-- null���� ����ؼ� ���� ���� ���� �տ� IS�� ���̸� ��! �ٸ� �����ڴ� �� ���� ����.

--������ �������� ���� AND, OR�� �����ؼ� ��!
SELECT employee_id �����ȣ, last_name �̸�, salary ����, department_id �μ���ȣ, hire_date �Ի���
FROM EMPLOYEES
WHERE salary BETWEEN 5000 AND 10000
AND (department_id = 50
OR department_id = 60);

SELECT employee_id �����ȣ, last_name �̸�, salary ����, department_id �μ���ȣ, hire_date �Ի���
FROM EMPLOYEES
WHERE department_id NOT IN  (50,80,90);

SELECT employee_id �����ȣ, last_name �̸�, salary ����, department_id �μ���ȣ, hire_date �Ի���
FROM EMPLOYEES
WHERE salary NOT BETWEEN 5000 AND 10000;

SELECT employee_id �����ȣ, last_name �̸�, salary ����, department_id �μ���ȣ, hire_date �Ի���
FROM EMPLOYEES
WHERE last_name NOT LIKE '______';

SELECT employee_id �����ȣ, last_name �̸�, salary ����, department_id �μ���ȣ, hire_date �Ի���, job_id
FROM EMPLOYEES
WHERE commission_pct IS NOT null
AND department_id  IS NOT null;

SELECT employee_id �����ȣ, last_name �̸�, salary ����, department_id �μ���ȣ, hire_date �Ի���, job_id
FROM EMPLOYEES
WHERE job_id LIKE 'AD\_%' ESCAPE '\'
AND department_id NOT IN 10;

SELECT employee_id �����ȣ, last_name �̸�, salary ����, department_id �μ���ȣ, hire_date �Ի���
FROM EMPLOYEES
WHERE salary NOT BETWEEN 5000 AND 10000
AND (department_id NOT IN 50
OR department_id NOT IN 110);


select*
FROM employees
ORDER BY hire_date DESC;
--  DESC�� ������������ ����, �⺻�� ������������ ���� ��

SELECT employee_id �����ȣ, last_name �̸�, salary *12 AS ann_sal, department_id �μ���ȣ
FROM employees
WHERE department_id IS NOT NULL
ORDER BY department_id DESC, ann_sal DESC;
-- �÷��� ������ �ѹ��� ���� ���̷� ���� �� �� �� ����!,ǥ����(salary *12�� ����)�� �� �� �ִ�.

SELECT employee_id �����ȣ, last_name �̸�, salary *12 AS ann_sal, department_id �μ���ȣ
FROM employees
WHERE department_id IS NOT NULL
AND salary*12 > 8000
ORDER BY department_id DESC, ann_sal DESC;

SELECT employee_id �����ȣ, last_name �̸�, salary ����, department_id �μ���ȣ
FROM employees
WHERE department_id =&deptno;

SELECT employee_id �����ȣ, last_name �̸�, salary ����, department_id �μ���ȣ, &col_name
FROM employees
ORDER BY &col_name;




