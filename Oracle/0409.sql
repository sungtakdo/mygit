--5��

CREATE TABLE NEW_TABLE
(NO NUMBER(3),
NAME VARCHAR2(10),
BIRTH DATE);

DESC NEW_TABLE;

CREATE TABLE TT02
( NO NUMBER(3,1) DEFAULT 0,
NAME VARCHAR2(10) DEFAULT 'NO NAME',
HIREDATE DATE DEFAULT SYSDATE);

INSERT INTO TT02 (NO) VALUES(1);
DESC TT02;
SELECT * FROM TT02;

CREATE TABLE �ѱ����̺�
(�÷�1 NUMBER,
 �÷�2 VARCHAR2(10),
 �÷�3 DATE);
SELECT * FROM �ѱ����̺�;
DESC �ѱ����̺�;

CREATE GLOBAL TEMPORARY TABLE TEMP01
(NO NUMBER,
 NAME VARCHAR2(10))
 ON COMMIT DELETE ROWS;

SELECT * FROM TEMP01;
INSERT INTO TEMP01 VALUES(1,'AAAAA');

COMMIT;

SELECT TEMPORARY, DURATION
FROM USER_TABLES
WHERE TABLE_NAME = 'TEMP01';

CREATE TABLE DEPT3
AS
SELECT * FROM DEPT2;

SELECT * FROM DEPT3;

CREATE TABLE DEPT4
AS
SELECT DCODE, DNAME
FROM DEPT2;

SELECT * FROM DEPT4;

CREATE TABLE DEPT5
AS SELECT * FROM DEPT2
WHERE 1 = 2;
SELECT * FROM DEPT5;

CREATE TABLE DEPT6
AS
SELECT DCODE, DNAME
FROM DEPT2
WHERE DCODE IN(1000,1001,1002);
SELECT * FROM DEPT6;

ALTER TABLE DEPT6
ADD(LOCATION VARCHAR2(10));
SELECT * FROM DEPT6;
ALTER TABLE DEPT6
ADD(LOCATION2 VARCHAR2(10) DEFAULT 'SEOUL');

ALTER TABLE DEPT6 RENAME COLUMN LOCATION2 TO LOC;
RENAME DEPT6 TO DEPT7;
SELECT * FROM DEPT7;

DESC DEPT7;
ALTER TABLE DEPT7
MODIFY(LOC VARCHAR2(20));
DESC DEPT7;

ALTER TABLE DEPT7 DROP COLUMN LOC;
ALTER TABLE DEPT7 DROP COLUMN LOCATION CASCADE CONSTRAINTS;

TRUNCATE TABLE DEPT7;
DROP TABLE DEPT7;
SELECT * FROM DEPT7;

CREATE TABLE T_READONLY
(NO NUMBER,
 NAME VARCHAR2(10));
INSERT INTO T_READONLY
VALUES(1,'AAA');
COMMIT;
SELECT * FROM T_READONLY;
ALTER TABLE T_READONLY READ ONLY;
INSERT INTO T_READONLY
VALUES(2,'BBB');

ALTER TABLE T_READONLY READ WRITE;
DROP TABLE T_READONLY;

CREATE TABLE VT1
( COL1 NUMBER,
  COL2 NUMBER,
  COL3 NUMBER GENERATED ALWAYS AS (COL1+COL2));
INSERT INTO VT1 VALUES(1,2,3);
INSERT INTO VT1 (COL1,COL2) VALUES(5,7);
SELECT * FROM VT1;
UPDATE VT1
SET COL1=5;
SELECT * FROM VT1;

ALTER TABLE VT1
ADD (COL4 GENERATED ALWAYS AS ((COL1*12)+COL2));
SELECT * FROM VT1;

SET LINE 200
COL COLUMN_NAME FOR A10
COL DATA_TYPE FOR A10
COL DATA_DEFAULT FOR A25
SELECT COLUMN_NAME,
        DATA_TYPE,
        DATA_DEFAULT
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'VT1'
ORDER BY COLUMN_ID;

CREATE TABLE SALES10
( NO NUMBER,
 PCODE CHAR(4),
 PDATE CHAR(8),
 PQTY NUMBER,
 PBUNGI NUMBER(1)
 GENERATED ALWAYS AS (CASE WHEN SUBSTR(PDATE,5,2) IN ('01','02','03') THEN 1
                            WHEN SUBSTR(PDATE,5,2) IN ('04','05','06') THEN 2
                            WHEN SUBSTR(PDATE,5,2) IN ('07','08','09') THEN 3
                      ELSE 4
                      END) 
VIRTUAL);
SELECT * FROM SALES10;

--�������� 1
CREATE TABLE NEW_EMP
( NO NUMBER(5),
  NAME VARCHAR2(20),
  HIREDATE DATE,
  BONUS NUMBER(6,2));
SELECT * FROM NEW_EMP;
DESC NEW_EMP;

--�������� 2
CREATE TABLE NEW_EMP2
AS
SELECT NO, NAME, HIREDATE
FROM NEW_EMP;
SELECT * FROM NEW_EMP2;
DESC NEW_EMP2;

--�������� 3
CREATE TABLE NEW_EMP3
AS SELECT * FROM NEW_EMP2
WHERE 1 = 2;
SELECT * FROM NEW_EMP3;
DESC NEW_EMP3;

--�������� 4
ALTER TABLE NEW_EMP2
ADD(BIRTHDAY DATE DEFAULT TO_CHAR(SYSDATE,'YYYY/MM/DD'));
SELECT * FROM NEW_EMP2;
DESC NEW_EMP2;

--�������� 5
ALTER TABLE NEW_EMP2 RENAME COLUMN BIRTHDAY TO BIRTH;
SELECT * FROM NEW_EMP2;
DESC NEW_EMP2;

--�������� 6
ALTER TABLE NEW_EMP2
MODIFY(NO NUMBER(7));
SELECT * FROM NEW_EMP2;
DESC NEW_EMP2;

--�������� 7
ALTER TABLE NEW_EMP2 DROP COLUMN BIRTH;
SELECT * FROM NEW_EMP2;
DESC NEW_EMP2;

--�������� 8
TRUNCATE TABLE NEW_EMP2;
SELECT * FROM NEW_EMP2;
DESC NEW_EMP2;

--�������� 9
DROP TABLE NEW_EMP2;
SELECT * FROM NEW_EMP2;
DESC NEW_EMP2;


--6��
SELECT * FROM DEPT2;
INSERT INTO DEPT2(DCODE,DNAME,PDEPT,AREA)
VALUES (9000,'TEMP_1',1006,'TEMP AREA');
SELECT * FROM DEPT2;

INSERT INTO DEPT2(DCODE,DNAME,PDEPT)
VALUES(9002,'TEMP_3',1006);
SELECT * FROM DEPT2;

SELECT * FROM PROFESSOR;
INSERT INTO PROFESSOR(PROFNO,NAME,ID,POSITION,PAY,HIREDATE)
VALUES(5001,'JAMES BOND','LOVE_ME','A FULL PROFESSOR',510,'14/10/23');
SELECT * FROM PROFESSOR;

CREATE TABLE T_MINUS
( NO1 NUMBER,
  NO2 NUMBER(3),
  NO3 NUMBER(3,2));
INSERT INTO T_MINUS VALUES(1,1,1);
INSERT INTO T_MINUS VALUES(1.1,1.1,1.1);
INSERT INTO T_MINUS VALUES(-1.1,-1.1,-1.1);
SELECT * FROM T_MINUS;

CREATE TABLE PROFESSOR3
AS
SELECT * FROM PROFESSOR
WHERE 1=2;
SELECT * FROM PROFESSOR3;
INSERT INTO PROFESSOR3
SELECT * FROM PROFESSOR;

CREATE TABLE PROF_3
( PROFNO NUMBER,
  NAME VARCHAR2(25));
CREATE TABLE PROF_4
( PROFNO NUMBER,
  NAME VARCHAR2(25));
SELECT * FROM PROF_3;  
SELECT * FROM PROF_4;
INSERT ALL
WHEN PROFNO BETWEEN 1000 AND 1999 THEN INTO PROF_3 VALUES(PROFNO, NAME)
WHEN PROFNO BETWEEN 2000 AND 2999 THEN INTO PROF_4 VALUES(PROFNO, NAME)
SELECT PROFNO, NAME
FROM PROFESSOR;
SELECT * FROM PROF_3;  
SELECT * FROM PROF_4;

TRUNCATE TABLE PROF_3;
TRUNCATE TABLE PROF_4;
INSERT ALL
INTO PROF_3 VALUES(PROFNO,NAME)
INTO PROF_4 VALUES(PROFNO,NAME)
SELECT PROFNO, NAME
FROM PROFESSOR
WHERE PROFNO BETWEEN 3000 AND 3999;
SELECT * FROM PROF_3;  
SELECT * FROM PROF_4;

UPDATE PROFESSOR
SET BONUS = 200
WHERE POSITION = 'assistant professor';
SELECT * FROM PROFESSOR;

UPDATE PROFESSOR
SET PAY = PAY *1.15
WHERE POSITION = (SELECT POSITION FROM PROFESSOR WHERE NAME = 'Sharon Stone')
AND PAY < 250;
SELECT * FROM PROFESSOR;

DELETE FROM DEPT2
WHERE DCODE >= 9000 AND DCODE <= 9999;

CREATE TABLE CHARGE_01
( U_DATE VARCHAR2(6),
  CUST_NO NUMBER,
  U_TIME NUMBER,
  CHARGE NUMBER);
CREATE TABLE CHARGE_02
( U_DATE VARCHAR2(6),
  CUST_NO NUMBER,
  U_TIME NUMBER,
  CHARGE NUMBER);
CREATE TABLE CH_TOTAL
( U_DATE VARCHAR2(6),
  CUST_NO NUMBER,
  U_TIME NUMBER,
  CHARGE NUMBER);
INSERT INTO CHARGE_02 VALUES('141001',1000,2,1000);
INSERT INTO CHARGE_02 VALUES('141001',1001,2,1000);
INSERT INTO CHARGE_02 VALUES('141001',1002,1,500);
INSERT INTO CHARGE_01 VALUES('141001',1000,3,1500);
INSERT INTO CHARGE_01 VALUES('141001',1001,4,2000);
INSERT INTO CHARGE_01 VALUES('141001',1003,1,500);

MERGE INTO CH_TOTAL TOTAL
USING CHARGE_01 CH01
ON(TOTAL.U_DATE = CH01.U_DATE)
WHEN MATCHED THEN
UPDATE SET TOTAL.CUST_NO = CH01.CUST_NO
WHEN NOT MATCHED THEN
INSERT VALUES(CH01.U_DATE, CH01.CUST_NO, CH01.U_TIME, CH01.CHARGE);
SELECT * FROM CH_TOTAL;

--�������� 1
SELECT * FROM DEPT2;
INSERT INTO DEPT2(DCODE,DNAME,PDEPT,AREA)
VALUES (9010,'TEMP_10',1006,'TEMP AREA');
SELECT * FROM DEPT2;

--�������� 2
INSERT INTO DEPT2(DCODE,DNAME,PDEPT)
VALUES(9020,'TEMP_20',1006);
SELECT * FROM DEPT2;

--�������� 3
SELECT * FROM PROFESSOR;
DESC PROFESSOR;
CREATE TABLE PROFESSOR4
AS
SELECT PROFNO, NAME, PAY FROM PROFESSOR
WHERE PROFNO <= 3000;
SELECT * FROM PROFESSOR4;

--�������� 4
UPDATE PROFESSOR
SET BONUS = 100
WHERE NAME = 'Sharon Stone';
SELECT * FROM PROFESSOR;


--7��
CREATE TABLE NEW_EMP1
( NO NUMBER(4) PRIMARY KEY,
  NAME VARCHAR2(20) NOT NULL,
  JUMIN VARCHAR2(13) NOT NULL UNIQUE,
  LOC_CODE NUMBER(1) CHECK (LOC_CODE < 5),
  DEPTNO VARCHAR2(6) REFERENCES DEPT2(DCODE)
  );

CREATE TABLE NEW_EMP2
( NO NUMBER(4) PRIMARY KEY,
  NAME VARCHAR2(20) NOT NULL,
  JUMIN VARCHAR2(13) NOT NULL UNIQUE,
  LOC_CODE NUMBER(1) CHECK (LOC_CODE < 5),
  DEPTNO VARCHAR2(6) REFERENCES DEPT2(DCODE)
  );

ALTER TABLE NEW_EMP2
ADD CONSTRAINT EMP2_NAME_UK UNIQUE(NAME);
ALTER TABLE NEW_EMP2
MODIFY(LOC_CODE CONSTRAINT EMP2_LOCCODE_NN NOT NULL);
SELECT * FROM NEW_EMP2;

ALTER TABLE NEW_EMP2
ADD CONSTRAINT EMP_NO_FK FOREIGN KEY(NO)
REFERENCES EMP2(EMPNO);
SELECT * FROM NEW_EMP2;

INSERT INTO T_NOVALIDATE VALUES(1,'DDD');

ALTER TABLE T_NOVALIDATE
DISABLE NOVALIDATE CONSTRAINT SYS_C0014418;
SELECT * FROM T_NOVALIDATE;
INSERT INTO T_NOVALIDATE VALUES(1,'DDD');

SELECT * FROM tcons;














