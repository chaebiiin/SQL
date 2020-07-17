select * from emp;
--WHERE mgr = 7839;

select empno, ename, mgr
from emp
start with empno= 7839
connect by PRIOR empno=7939;

select empno, ename, mgr
from emp
start with empno= 7876
connect by empno= PRIOR mgr;

select empno, ename, mgr, level
from emp
start with empno= 7839
connect by PRIOR empno=  mgr;

select lpad(ename, 4*level+2, '-')
from emp
start with empno = 7839
connect by prior empno = mgr;

select rpad(ename, 10, '-') || lpad(sal, 6, ' >')
from emp;

select empno, ename, mgr, level, sys_connect_by_path(ename,' /') as path
from emp
start with empno= 7839
connect by PRIOR empno=  mgr;
