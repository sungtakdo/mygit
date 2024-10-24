select ename, rtrim(ename, 'R') "RTRIM"
from emp
where deptno = 10;

select ename from emp
where deptno = 10;

select ltrim(ename, 'C')
from emp
where deptno = 10;

select ename, replace(ename, substr(ename,1,2),'**') "REPLACE"
from emp
where deptno = 10;

--quiz1
select ename, REPLACE(ename, SUBSTR(ename, 2,2),'--') "REPLACE"
from emp
where deptno = 20;

select name, jumin
from student
where deptno1 = 101;

--quiz2
select name, jumin, replace(jumin, substr(jumin,7,13),'-/-/-/-')   "REPLACE"
from student
where deptno1 = 101;

--quiz3
select name, tel, replace(tel, substr(tel, 5,3),'***') "REPLACE"
from student
where deptno1 = 102;

--quiz4
select name, tel, replace(tel, substr(tel, 9,4),'****') "REPLACE"
from student
where deptno1 = 101;

select ename, replace(ename, substr(ename,2,2),'--') as "REPLACE"
from emp
where deptno = 20;

select *
from student;

select name, jumin, replace(jumin, substr(jumin,7,7),'-/-/-/-') as "REPLACE"
from student
where deptno1 = 101;

select name, tel,
    replace(tel, substr(tel, instr(tel, '-', 1)+1,4),'****') as "REPLACE"
from student
where deptno1 = 101;

select round(987.654,2) "ROUND1",
        round(987.654,0) "ROUND2",
        round(987.654,-1) "ROUND3" 
from dual;

select trunc(987.654,2) "trunc1",
        trunc(987.654,0) "trunc2",
        trunc(987.654,-1) "trunc3"
from dual;

select mod(121, 10) "MOD",
        ceil(123.45) "CEIL",
        floor(123.45) "FLOOR"
from dual;

set pagesize 50
select rownum "ROWNO" , ceil(rownum/3) "TEAMNO", ename
from emp;

select power(9,100) from dual;

select sysdate from dual;

select months_between('14/09/30' , '14/08/31')
from dual;

select months_between('14/08/31' , '14/09/30')
from dual;

select months_between('12/02/29','12/02/01')
from dual;

select months_between('14/04/30','14/04/01')
from dual;

select sysdate, months_between('15/05/31','15/04/30')
from dual;



alter session set nls_date_format='yy/mm/dd';
select sysdate, months_between('15/05/31','15/04/30')
from dual;

select ename, hiredate,
    round(months_between(to_date('04/05/31'),hiredate),1) "DATE1",
    round(((to_date('04/05/31')-hiredate)/31),1) "DATE2"
from emp
where deptno = 10;

select studno, name, birthday
from student;

select studno, name, birthday
from student
where to_char(birthday,'mm') = '01';

select empno, ename, hiredate
from emp
where to_char(hiredate,'mm') in('01','02','03');

select empno, ename, sal, comm,
        to_char((sal*12)+comm, '999,999') "SALARY"
from emp
where ename = 'ALLEN';

select name, pay, bonus,
        to_char((pay*12)+bonus, '999,999') "TOTAL"
from professor
where deptno = 201;

alter session set nls_date_format = 'yyyy-mm-dd';

select empno, ename, hiredate,
        to_char((sal*12)+comm, '$999,999') as "SAL",
        to_char(((sal*12)+comm)*1.15,'$999,999') as "15% UP"
from emp
where comm is not null;

--nvl«‘ºˆƒ˚¡Ó
select profno, name, pay, nvl(bonus,0) as "BONUS",
    to_char((pay*12)+nvl(bonus,0),'999,999') as "TOTAL"
from professor
where deptno = 201;

select empno, ename, comm, NVL2(comm, 'Exist', 'NULL') as "NVL2"
from emp
where deptno = 30;

select deptno , name ,decode(deptno, 101, 'Computer Engineering') "DNAME"
from professor;

select deptno, name, decode(deptno, 101, 'Computer Engineering', 'ETC') "DNAME"
from professor;

select deptno, name, decode(deptno, 101, 'Computer Engineering', 102, 'Multimedia Engineering', 103, 'Software Engineering', 'ETC') "DNAME"
from professor;

select deptno, name, decode(deptno, 101, decode(name, 'Audie Murphy', 'BEST!'))"ETC"
from professor;

select deptno, name, decode(Deptno, 101, decode(name, 'Audie Murphy', 'BEST!', 'GOOD!')) "ETC"
from professor;

select deptno, name, decode(deptno, 101, decode(name,'Audie Murphy', 'BEST!', 'GOOD!'),'N/A') "ETC"
from professor;

select name, jumin, decode(substr(jumin,7,1),'1' ,'MAN','WOMAN') "GENDER"
from student
where deptno1 = 101;

select name, tel, decode(substr(tel,1, instr(tel, ')')-1), '02','SEOUL','031','GYEONGGI','051','BUSAN','051','ULSAN','055','GYEONGNAM' ) "LOC"
from student
where deptno1 = 101;

select empno, ename, sal, 
        case when sal between '1' and '1000' then 'LEVEL 1'
             when sal between '1001' and '2000' then 'LEVEL 2'
             when sal between '2001' and '3000' then 'LEVEL 3'
             when sal between '3001' and '4000' then 'LEVEL 4'
                                                else 'LEVEL 5'
        end "LEVEL"
from emp
order by sal desc;



















