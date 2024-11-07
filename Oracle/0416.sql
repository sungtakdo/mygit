CREATE MATERIALIZED VIEW M_PROF
BUILD IMMEDIATE
REFRESH
ON DEMAND
COMPLETE
ENABLE QUERY REWRITE
AS
 SELECT PROFNO, NAME, PAY
 FROM PROFESSOR;
 
SELECT * FROM M_PROF;

CREATE INDEX IDX_M_PROF_PAY
ON M_PROF(PAY);

--�������� ���� ���̺��� ��üȭ�� ���� ������ ����ȭ �������
DELETE FROM PROFESSOR
WHERE PROFNO = 5001;
COMMIT;
SELECT * FROM PROFESSOR;
SELECT * FROM M_PROF;

--DBMS_MVIEW ��Ű���� ����ȭ ���� ���
BEGIN
    DBMS_MVIEW.REFRESH('M_PROF');
END;
SELECT * FROM PROFESSOR;
SELECT * FROM M_PROF;

EXEC DBMS_MVIEW.REFRESH_ALL_MVIEWS;

--MVIEW ��ȸ�ϱ�/�����ϱ�
SELECT MVIEW_NAME, QUERY
FROM USER_MVIEWS
WHERE MVIEW_NAME='M_PROF';

DROP MATERIALIZED VIEW M_PROF;

--��������--
--1
SELECT * FROM PROFESSOR;
SELECT * FROM DEPARTMENT;
CREATE OR REPLACE VIEW V_PROF_DEPT2
AS 
 SELECT P.PROFNO, P.NAME, D.DNAME
 FROM PROFESSOR P, DEPARTMENT D
 WHERE P.DEPTNO = D.DEPTNO;
SELECT * FROM V_PROF_DEPT2;

--2
SELECT * FROM STUDENT;
SELECT * FROM DEPARTMENT;
SELECT D.DNAME, S.MAX_HEIGHT, S.MAX_WEIGHT
FROM (SELECT deptno1, MAX(HEIGHT)MAX_HEIGHT, MAX(WEIGHT) MAX_WEIGHT 
      FROM STUDENT
      GROUP BY DEPTNO1)S, DEPARTMENT D
WHERE S.DEPTNO1 = D.DEPTNO;

--3
SELECT D.DNAME, A.MAX_HEIGHT, S.NAME, S.HEIGHT
FROM (SELECT deptno1, MAX(HEIGHT)MAX_HEIGHT 
      FROM STUDENT
      GROUP BY DEPTNO1)A, STUDENT S, DEPARTMENT D
WHERE S.DEPTNO1 = A.DEPTNO1
AND S.HEIGHT = A.MAX_HEIGHT
AND S.DEPTNO1 = D.DEPTNO;

--4
SELECT S.GRADE, S.NAME, S.HEIGHT, A.AVG_HEIGHT
FROM (SELECT GRADE, AVG(HEIGHT) AVG_HEIGHT
        FROM STUDENT
        GROUP BY GRADE)A, STUDENT S
WHERE A.GRADE = S.GRADE
AND A.AVG_HEIGHT < S.HEIGHT
ORDER BY 1;


--5
SELECT ROWNUM "RANGKING", NAME, PAY
FROM(SELECT NAME, PAY
        FROM PROFESSOR
        ORDER BY 2 DESC)
WHERE ROWNUM BETWEEN 1 AND 5;

--6
SELECT NUM, PROFNO, NAME, PAY, SUM(PAY), ROUND(AVG(PAY),1)
FROM ( SELECT PROFNO, NAME, PAY, ROWNUM NUM
        FROM PROFESSOR)
GROUP BY CEIL(NUM/3), ROLLUP((PROFNO, NAME, PAY, NUM))
ORDER BY CEIL(NUM/3);










