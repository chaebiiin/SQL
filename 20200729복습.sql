--200729 ����~
SELECT * FROM emp;

SELECT ename 
FROM emp
WHERE lower(ename) LIKE '%j%';

--�����̼�(���̺�)�� �÷��� ������ ���� ����. 
ALTER TABLE emp ADD (birthday DATE);

--�����ϴ�!
SELECT ename, ename FROM emp;

--null�� �� �� ���� ��, ����� �� ���� ��, �Ҵ� �� �� ���� ��, ������ �� ���� ��, null�� 0�Ǵ� ����� �ٸ���.
SELECT ROUND(AVG(NVL(comm,0))) FROM emp;

--ū����ǥ(" ")�� ���� ���� �ִ±״�θ� ǥ���ϱ� ���� ����. Į����Ī���� ex) as "test"
--���������� �� �� (" ")�� ����. 
SELECT TO_CHAR(hiredate, 'yyyy"��", mm"��", DD"��"')
FROM emp;

--���Ῥ����(||)
--���� �Լ� CONCAT
SELECT CONCAT(ename, sal) 
FROM emp;

--DISTINCT(�ߺ��� ����), DISTINCT�� �ѹ��� ���� ����
SELECT DISTINCT deptno, job 
FROM emp;

--ALL �� ����Ʈ ��
SELECT all deptno 
FROM emp;

/*WHERE ��( WHERE+ �񱳴�� Į�� + �� ������ + �μ�) 
�ϳ��� row�� Ʃ�� / Ʃ���� ������ ī��θ�Ƽ???   �������Լ��� �� �� �ִ�. (������ �Լ��� �� �Լ��� ��� ��)
�׷� �Լ��� �� �� ����? */

--���� ������ ����.  ������ �� ���ڰ� �۾ƾ� �Ѵ�!? 
SELECT ename, sal
 FROM emp
 WHERE sal BETWEEN 1500 AND 1000;

--���� �񱳵� �����ϴ�!
SELECT ename, sal
 FROM emp
WHERE ename BETWEEN 'A' AND 'F';

SELECT player_name
FROM player
WHERE player_name BETWEEN '��' AND '��';

SELECT ename, sal, comm
FROM emp
WHERE comm IS NOT NULL;


