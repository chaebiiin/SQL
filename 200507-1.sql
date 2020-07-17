--���̺� �����
CREATE TABLE bigemp
AS
SELECT * FROM employees;
--���̺� ���� ���� ä��� (������ ����)
INSERT INTO bigemp
SELECT * FROM bigemp;

COMMIT;
--���̺� ���� �����ȣ �����ϱ� (1001�� ���� �����ؼ� 1������)
CREATE SEQUENCE emp_id_deq
START WITH 1001
INCREMENT BY 1;
-- ���̺� ��Ī �̸� ������
UPDATE bigemp
SET employee_id = emp_id_deq.nextval;
COMMIT;
--�����ȣ�� ��������� ū ��� ����� ��
SELECT MIN(employee_id), MAX(employee_id)
FROM bigemp;

--�ε��� ���� �� �� ���� �ο����ֱ� run comm����
--conn / as sysdba
--GRANT SELECT_CATALOG_ROLE TO hr;
--GRANT SELECT ANY DICTIONARY TO hr;

SELECT index_name FROM user_indexes
WHERE table_name = 'BIGEMP';

--�ε��� ����� �� �ڵ����� Ȯ��
SELECT* FROM bigemp
WHERE employee_id = 234567;
--�ε��� �����
CREATE INDEX bigemp_id_ix
ON bigemp(employee_id);
--�ε��� ����� ���� �ڵ����� Ȯ��
SELECT* FROM bigemp
WHERE employee_id = 234567;
--�ε��� ����� �� �ڵ������غ���
SELECT* FROM bigemp
WHERE salary = 3000;
--�ε��� �����
CREATE INDEX bigemp_sal_ix
ON bigemp(salary);
--�ε��� ����� �� �� �ڵ������غ���
SELECT* FROM bigemp
WHERE salary = 3000;
--�ε����� ����� ���� �ƴ� �ٸ� ���� ��ȸ�ϸ� Ǯ ��ĵ��...
SELECT* FROM bigemp
WHERE salary*12 > 110000;
--�տ��� ���� �ε��� ����
DROP INDEX bigemp_sal_ix;
--����*12 ���� �ε����� ������ ��
CREATE INDEX bigemp_annsal_ix
ON bigemp(salary*12);
--�ε��� ����� �� �� ����*12 �� ����غ���..
SELECT* FROM bigemp
WHERE salary*12 > 110000;
DROP INDEX bigemp_annsal_ix;



