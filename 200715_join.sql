select empno, ename,  job, deptno, dname
from emp NATURAL JOIN dept;

select * from dept;

--inner join(using)
select empno, ename,  job, deptno, dname
from emp  JOIN dept
using (deptno);

--join~ on  inner join
select empno, ename,  job, dept.deptno, dname
from emp JOIN dept
on (emp.deptno = dept.deptno);

select empno, ename,  job, dept.deptno, dname
from emp, dept
WHERE emp.deptno = dept.deptno; 


select empno, ename,  job, deptno, dname
from emp  JOIN dept
using (deptno)
where sal > 1300;
--비표준조인
select empno, ename,  job, dept.deptno, dname
from emp, dept
WHERE emp.deptno = dept.deptno 
AND sal > 1300;

-- OUTER JOIN 
select empno, ename,  job, dept.deptno, dname
from emp  right outer JOIN dept
on (emp.deptno = dept.deptno);

--비표준 조인에서 OUTER JOIN
select empno, ename,  job, dept.deptno, dname
from emp, dept
WHERE emp.deptno(+) = dept.deptno;


--HR
select employee_id, last_name, job_id, employees.department_id, department_name
from employees, departments
where employees.department_id = departments.department_id;

--LEFT OUTER JOIN
select employee_id, last_name, job_id, employees.department_id, department_name
from employees left outer join departments
on (employees.department_id = departments.department_id);

--RIGHT OUTER JOIN
select employee_id, last_name, job_id, employees.department_id, department_name
from employees right outer join departments
on (employees.department_id = departments.department_id);

--FULL OUTER JOIN 표준
select employee_id, last_name, job_id, employees.department_id, department_name
from employees full outer join departments
on (employees.department_id = departments.department_id);

select employee_id, last_name, job_id, employees.department_id, department_name
from employees, departments
where employees.department_id = departments.department_id(+);

-- FULL OUTER JOIN 비표준
select employee_id, last_name, job_id, employees.department_id, department_name
from employees, departments
where employees.department_id(+) = departments.department_id
union
select employee_id, last_name, job_id, employees.department_id, department_name
from employees, departments
where employees.department_id = departments.department_id(+);

-- 3WAY JOIN (표준)
select e.last_name, d.department_name, l.city
from employees e join departments d
on (e.department_id = d.department_id)
join locations l
on (d.location_id = l.location_id);

--3WAY JOIN (비표준)
select e.last_name, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id;
