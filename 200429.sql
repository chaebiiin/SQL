--emp_dept_loc_join_vu에서 사원의 업무와 급여가 보이도록 뷰를 수정하세요.
SELECT view_name, text
FROM user_views;

SELECT e.employee_id, e.last_name, e.job_id, e.salary, d.department_name, l.city
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
JOIN locations l
ON(d. location_id = l.location_id);
--- 수정하기
CREATE OR REPLACE VIEW emp_dept_loc_join_vu
AS
SELECT e.employee_id, e.last_name, e.job_id, e.salary, d.department_name, l.city
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
JOIN locations l
ON(d. location_id = l.location_id);
