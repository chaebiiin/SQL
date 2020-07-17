SELECT employee_id FROM employees
UNION
SELECT employee_id FROM job_history;

SELECT employee_id, job_id FROM EMPLOYEES
UNION
SELECT employee_id, job_id FROM job_history;
// ������ �ϸ� ù ��° Į���� �������� ������ ��, �� ��° Į������ ���� �ذ� ������ ORDER BY 2(�ι�° Į���̸� �ֱ�); �� �־��ش�.

SELECT employee_id empno, job_id  FROM employees
UNION
SELECT employee_id, job_id job_title FROM job_history;
//��Ī ������ ù ��° Į���� �������� ù��° Į���� ��Ī�� ��µ�
// UNION ALL�� �������� ����.

SELECT employee_id, department_id FROM employees
UNION ALL
SELECT employee_id, department_id FROM job_history
ORDER BY 1,2;

SELECT employee_id, department_id, job_id FROM employees
UNION ALL
SELECT employee_id, department_id, job_id FROM job_history
ORDER BY 1,2;

--���տ���� ����Ŀ���� Ȱ���ؼ� �Ի� �� �μ���, ���� �̵� �̷��� ���� ������ ���, �̸�, �޿��� ����Ͻÿ�.

SELECT employee_id, last_name, salary
FROM employees
WHERE employee_id IN (SELECT employee_id FROM employees
                              MINUS
                            SELECT employee_id FROM JOB_history);

--���� �̵��� ���� ��� ���ϱ�
SELECT employee_id FROM employees
MINUS
SELECT employee_id FROM JOB_hidtory;

-- ���տ����� ���̵� ����
--UNION ALL�� �����ϰ� ��� ù��° ���� �������� ����� ����, ����� �÷������ ù��° ������ �� �̸�, ��Ī�� ����Ѵ�.
--�� SELECT ���� ���� ����, �����Ǵ� ���� ������ ������ �����ؾ� ������ ����
--MINUS�� �����ϰ� ��� ��ȯ��Ģ, ���չ�Ģ ���� ����

--SELECT employee_id, hire_date FROM employees
--UNION
--SELECT department_id, department_name FROM departments;
-- ������ Ÿ���� ���� ���� �� ���ߴ� ��
SELECT employee_id, hire_date, TO_CHAR(null) AS department_name FROM employees
UNION
SELECT department_id, TO_DATE(null), department_name FROM departments;

--��ü����� �� �޿�, �μ��� �� �޿�, �μ���, ���޺� �� �޿�
SELECT department_id, job_id, SUM(salary) FROM employees
GROUP BY department_id, job_id
UNION
SELECT department_id, TO_CHAR(null), SUM(salary) FROM employees  --�μ��� �ѱ޿�
GROUP BY department_id 
UNION
SELECT TO_NUMBER(null), TO_CHAR(null), SUM(salary) FROM employees;





