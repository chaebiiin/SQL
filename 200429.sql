--emp_dept_loc_join_vu���� ����� ������ �޿��� ���̵��� �並 �����ϼ���.
SELECT view_name, text
FROM user_views;

SELECT e.employee_id, e.last_name, e.job_id, e.salary, d.department_name, l.city
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
JOIN locations l
ON(d. location_id = l.location_id);
--- �����ϱ�
CREATE OR REPLACE VIEW emp_dept_loc_join_vu
AS
SELECT e.employee_id, e.last_name, e.job_id, e.salary, d.department_name, l.city
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
JOIN locations l
ON(d. location_id = l.location_id);
