select ename, INITCAP(ename) "INITCAP"
from emp
where deptno = 10;

select ename, lower(ename) "LOWER", upper(ename) "UPPER"
from emp
where deptno = 10;

select ename, LENGTH(ename) "LENGTH", LENGTHB(ename) "LENGTH"
from emp
where deptno = 20;

select '서진수' "NAME", length('서진수') "LENGTH",
                        lengthb('서진수') "LENGTHB"
from dual;

set verify off
select ename, LENGTH(ename)
from emp
where LENGTH(ename) > LENGTH('&ename');

select concat(ename, job)
from emp
where deptno = 10;

col "3,2" for a6
col "-3,2" for a6
col "-3,4" for a6

select substr('abcde', 3,2) "3,2",
        substr('abcde', -3,2) "-3,2",
        substr('abcde', -3,4) "-3,4"
from dual;

select name, substr(jumin,3,4) "Birthday",
            substr(jumin,3,4)-1 "Birthday -1"
from student
where deptno1 = 101;

select '서진수' "NAME" , substr('서진수' ,1,2) "SUBSTR" ,
                        substrb('서진수', 1,2) "SUBSTRB"
from dual;

select 'A-B-C-D', INSTR('A-B-C-D','-',1,3) "INSTR"
from dual;

select 'A-B-C-D' , INSTR('A-B-C-D','-',3,1) "INSTR"
from dual;

select 'A-B-C-D' , INSTR('A-B-C-D' ,'-', -1,3) "INSTR"
from dual;

select 'A-B-C-D', INSTR('A-B-C-D' , '-', -1,3) "INSTR"
from dual;

select 'A-B-C-D', INSTR('A-B-C-D', '-', -6,2) "INSTR"
from dual;

select name, tel, instr(tel, ')')
from student
where deptno1 = 201;

select name, tel, instr(tel, '3')
from student
where deptno1 = 101;

select name, tel, substr(tel, 1,instr(tel,')')-1) as "AREA CODE"
from student
where deptno1 = 201;

select name, tel, substr(tel, 1, instr(tel,')')-1) as "AREA CODE"
from student
where deptno1=201;

select concat(tel,tel)
from student
where deptno1=201;

select substr(tel, 1, instr(tel,'-',-1,1))
from student
where deptno1=201;

