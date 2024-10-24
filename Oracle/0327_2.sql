select concat(ename, job)
from emp
where deptno=10;

select name, tel, replace(replace(tel,')',''),'-','')  "AREA CODE"
from student
where deptno1=201;

col name for a20
col id for a10
col lpad(id,10,'*') for a20

select name, id, lpad(id,10,'*')
from student 
where deptno1 =201;

select ename
from emp
where deptno=10;

select lpad(ename,9,'12345')
from emp
where deptno=10;

select rpad(ename, 10, '-') "RPAD"
from emp
where deptno =10;

select rpad(ename, 9, substr('123456789',length(ename)+1))"RPAD" 
from emp
where deptno=10;








