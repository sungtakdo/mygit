CREATE UNIQUE INDEX IDX_DEPT2_DNAME
ON DEPT2(DNAME);
INSERT INTO DEPT2 VALUES(9100, 'TEMP01', 1006, 'SEOUL BRANCH');

SELECT * FROM DEPT2;

CREATE INDEX IDX_DEPT2_AREA
ON DEPT2(AREA);
INSERT INTO DEPT2 VALUES(9102, 'TEMP02', 1006 , 'SEOUL BRANCH');

CREATE INDEX IDX_PROF_PAY_FBI
ON PROFESSOR(PAY+1000);

create index idx_prof_pay
on professor(pay desc);

SELECT ENAME, SAL
FROM EMP
WHERE ENAME = 'SMITH'
AND SEX = 'M';

SELECT * FROM EMP;


SELECT TABLE_NAME, COLUMN_NAME, INDEX_NAME
FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'DEPT2';

ALTER INDEX IDX_DEPT2_DNAME MONITORING USAGE;
ALTER INDEX IDX_DEPT2_DNAME MONITORING USAGE;

SELECT INDEX_NAME, USED
FROM V$OBJECT_USAGE
WHERE INDEX_NAME = 'IDX_DEPT2_DNAME';


-- INDEX REBUILD
-- STEP1 테스트용 테이블 I_TEST 생성하고 인덱스 생성
CREATE TABLE INX_TEST
(NO NUMBER);

BEGIN 
    FOR I IN 1..10000 LOOP
        INSERT INTO INX_TEST VALUES(I);
END LOOP;
COMMIT;
END;

SELECT * FROM I_TEST;

CREATE INDEX IDX_ITEST_NO ON INX_TEST(NO);

-- STEP2 인덱스 상태 조회
ANALYZE  INDEX IDX_ITEST_NO VALIDATE STRUCTURE;

SELECT (DEL_LF_ROWS_LEN / LF_ROWS_LEN) * 100 BALANCE
FROM INDEX_STATS
WHERE NAME = 'IDX_ITEST_NO';

-- STEP3 4000건 삭제 후 인덱스 상태 조회
DELETE FROM I_TEST
WHERE NO BETWEEN 1 AND 4000;

SELECT COUNT(*) FROM I_TEST;
ANALYZE  INDEX IDX_ITEST_NO VALIDATE STRUCTURE;
SELECT (DEL_LF_ROWS_LEN / LF_ROWS_LEN) * 100 BALANCE
FROM INDEX_STATS
WHERE NAME = 'IDX_ITEST_NO';

-- STEP4 REBUILD 작업으로 수정
ALTER INDEX IDX_ITEST_NO REBUILD;
ANALYZE  INDEX IDX_ITEST_NO VALIDATE STRUCTURE;
SELECT (DEL_LF_ROWS_LEN / LF_ROWS_LEN) * 100 BALANCE
FROM INDEX_STATS
WHERE NAME = 'IDX_ITEST_NO';

CREATE INDEX IDX_EMP_SAL ON EMP(SAL);

SELECT TABLE_NAME, INDEX_NAME, VISIBILITY
FROM USER_INDEXES
WHERE TABLE_NAME = 'EMP';

ALTER INDEX IDX_EMP_SAL INVISIBLE;
SELECT TABLE_NAME, INDEX_NAME, VISIBILITY
FROM USER_INDEXES
WHERE TABLE_NAME = 'EMP';

--다양한 인덱스 활용 예제
-- STEP 1 : 사원 예제 테이블 생성 후 값 입력
CREATE TABLE NEW_EMP7(
    NO      NUMBER,
    NAME    VARCHAR2(10),
    SAL     NUMBER);
INSERT INTO NEW_EMP7 VALUES(1000,'SMITH',300);
INSERT INTO NEW_EMP7 VALUES(1001,'ALLEN',250);
INSERT INTO NEW_EMP7 VALUES(1002,'KING',430);
INSERT INTO NEW_EMP7 VALUES(1003,'BLAKE',220);
INSERT INTO NEW_EMP7 VALUES(1004,'JAMES',620);
INSERT INTO NEW_EMP7 VALUES(1005,'MILLER',810);

COMMIT;

SELECT * FROM NEW_EMP7;


--STEP 2 : NAME 컬럼에 인덱스 생성
CREATE INDEX IDX_NEWMP7_NAME
ON NEW_EMP7(NAME);

-- STEP 3 : 인덱스를 사용하지 않는 일반적인 SQL 작성
SELECT NAME FROM NEW_EMP7;

-- STEP 4 : 인덱스를 사용하도록 SQL 작성
SELECT NAME FROM NEW_EMP7
WHERE NAME > '0';

-- STEP 5 : 인덱스를 활용한 최솟값/최댓값 구하기
SELECT MIN(NAME)
FROM NEW_EMP7;
SELECT NAME FROM NEW_EMP7
WHERE NAME > '0' AND ROWNUM = 1;

SELECT MAX(NAME)
FROM NEW_EMP7;
SELECT NAME FROM NEW_EMP7
WHERE NAME > '0'


-- 실습 : VIEW를 통한 데이터 변경
-- STEP 1 : VIEW를 통하여 DML 작업 수행하기
CREATE TABLE O_TABLE(A NUMBER, B NUMBER);
CREATE VIEW VIEW1
AS
    SELECT A, B
    FROM O_TABLE;
INSERT INTO VIEW1 VALUES(1,2);

SELECT * FROM VIEW1;
SELECT * FROM O_TABLE;

--STEP 2 : WITH READ ONLY
CREATE VIEW VIEW2
AS SELECT A, B
    FROM O_TABLE
WITH READ ONLY;

SELECT * FROM VIEW2;
INSERT INTO VIEW2 VALUES(3,4);
INSERT INTO VIEW1 VALUES(3,4);

SELECT * FROM VIEW1;
SELECT * FROM O_TABLE;
SELECT * FROM VIEW2;

-- STEP 3 : WITH CHECK OPTION
INSERT INTO VIEW1 VALUES(5,6);
CREATE VIEW VIEW3
AS
    SELECT A,B
    FROM O_TABLE
    WHERE A = 3
WITH CHECK OPTION;

UPDATE VIEW3
SET A = 5
WHERE B = 4;

