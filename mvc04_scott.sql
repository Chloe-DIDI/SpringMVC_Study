select user
from dual;

/*
-- 실수 했을 때 테이블, 시퀸스 다 날리는 구문
-- 한개 씩 차례대로 

DROP TABLE EMPLOYEE;
DROP SEQUENCE EMPLOYEESEQ;

DROP TABLE REGION;
DROP SEQUENCE REGIONSEQ;

DROP TABLE DEPARTMENT;
DROP SEQUENCE DEPARTMENTSEQ;

DROP TABLE POSITION;
DROP SEQUENCE POSITIONSEQ;
*/

--○ 실습 테이블 생성(지역 : REGION)  
CREATE TABLE REGION 
( REGIONID      NUMBER          -- 지역 아이디   -- PK
, REGIONNAME    VARCHAR2(30)    -- 지역 명
, CONSTRAINT REGION_ID_PK PRIMARY KEY(REGIONID)
);
--==>> Table REGION이(가) 생성되었습니다.

--○ 시퀸스 생성 ( 지역 : REGIONSEQ)
CREATE SEQUENCE REGIONSEQ
NOCACHE;
--==>> Sequence REGIONSEQ이(가) 생성되었습니다.

--○ 데이터 입력(지역 데이터 입력)
INSERT INTO REGION(REGIONID, REGIONNAME) VALUES(REGIONSEQ.NEXTVAL, '서울');
INSERT INTO REGION(REGIONID, REGIONNAME) VALUES(REGIONSEQ.NEXTVAL, '경기');
INSERT INTO REGION(REGIONID, REGIONNAME) VALUES(REGIONSEQ.NEXTVAL, '인천');
--==>> 1 행 이(가) 삽입되었습니다. * 3


--○ 지역 리스트 확인
SELECT REGIONID, REGIONNAME
FROM REGION;
--> 한 줄 구성
SELECT REGIONID, REGIONNAME FROM REGION
;
--==>> 
/*
1   서울
2   경기
3   인천
*/

--○ 커밋
COMMIT;
--==>> 커밋 완료.

-----------------------------------------------
--○ 실습 테이블 생성(직위 : POSITION)  
CREATE TABLE POSITION 
( POSITIONID      NUMBER           -- 직위 아이디   -- PK
, POSITIONNAME    VARCHAR2(30)     -- 직위 명
, MINBASICPAY      NUMBER          -- 최소 기본급
, CONSTRAINT POSITION_ID_PK PRIMARY KEY(POSITIONID)
);
--==>> Table POSITION이(가) 생성되었습니다.

--○ 시퀸스 생성 ( 직위 : POSITIONSEQ)
CREATE SEQUENCE POSITIONSEQ
NOCACHE;
--==>> Sequence POSITIONSEQ이(가) 생성되었습니다.


--○ 데이터 입력(직위 데이터 입력)
INSERT INTO POSITION(POSITIONID, POSITIONNAME, MINBASICPAY)
VALUES(POSITIONSEQ.NEXTVAL, '사원', 1000000);         -- 백만
INSERT INTO POSITION(POSITIONID, POSITIONNAME, MINBASICPAY)
VALUES(POSITIONSEQ.NEXTVAL, '대리', 2000000);         -- 이백만
INSERT INTO POSITION(POSITIONID, POSITIONNAME, MINBASICPAY)
VALUES(POSITIONSEQ.NEXTVAL, '부장', 3000000);         -- 삼백만
INSERT INTO POSITION(POSITIONID, POSITIONNAME, MINBASICPAY)
VALUES(POSITIONSEQ.NEXTVAL, '상무', 4000000);         -- 사백만
--==>> 1 행 이(가) 삽입되었습니다. * 4


--○ 직위리스트 확인
SELECT POSITIONID, POSITIONNAME, MINBASICPAY
FROM POSITION;
--> 한 줄 구성
SELECT POSITIONID, POSITIONNAME, MINBASICPAY FROM POSITION
;
--==>>
/*
1   사원   1000000
2   대리   2000000
3   부장   3000000
4   상무       4000000
*/

--○ 커밋
COMMIT;
--==>> 커밋 완료.


--○ 실습 테이블 생성(부서 : DEPARTMENT)
CREATE TABLE DEPARTMENT
( DEPARTMENTID      NUMBER
, DEPARTMENTNAME    VARCHAR2(30)
, CONSTRAINT DEPARTMENT_ID_PK PRIMARY KEY(DEPARTMENTID)
);
--==>> Table DEPARTMENT이(가) 생성되었습니다.

--○ 시퀀스 생성
CREATE SEQUENCE DEPARTMENTSEQ
NOCACHE;
--==>> Sequence DEPARTMENTSEQ이(가) 생성되었습니다.


--○ 데이터 입력( 데이터 입력)


INSERT INTO DEPARTMENT(DEPARTMENTID, DEPARTMENTNAME)
VALUES(DEPARTMENTSEQ.NEXTVAL, '개발부');
INSERT INTO DEPARTMENT(DEPARTMENTID, DEPARTMENTNAME)
VALUES(DEPARTMENTSEQ.NEXTVAL, '기획부');
INSERT INTO DEPARTMENT(DEPARTMENTID, DEPARTMENTNAME)
VALUES(DEPARTMENTSEQ.NEXTVAL, '영업부');
--==>> 1 행 이(가) 삽입되었습니다. * 3 


--○  리스트 확인
SELECT DEPARTMENTID, DEPARTMENTNAME
FROM DEPARTMENT;
--> 한 줄 구성
SELECT DEPARTMENTID, DEPARTMENTNAME FROM DEPARTMENT
;
--==>> 
/*
1	개발부
2	기획부
3	영업부
*/
--○ 커밋
COMMIT;
--==>> 커밋 완료.

------------------------------------------------------------
--○ 실습 테이블 생성(직원 : EMPLOYEE)
-- 사원번호, 사원명, 주민번호, 생년월일, 양음력, 전화번호, 부서, 직위, 지역, 기본급, 수당
CREATE TABLE EMPLOYEE
( EMPLOYEEID        NUMBER                  -- 사원번호     -- PK 
, NAME              VARCHAR2(30)            -- 사원 명
, SSN               VARCHAR2(20)            -- 주민번호     -- ★암호화 기능 적용(★TYPE CHECK!)
, BIRTHDAY          DATE                    -- 생년월일
, LUNAR             NUMBER(1) DEFAULT 0     -- 양음력       -- 양력0, 음력1
, TELEPHONE         VARCHAR2(40)            -- 전화번호
, DEPARTMENTID      NUMBER                  -- 부서 아이디
, POSITIONID        NUMBER                  -- 직위 아이디
, REGIONID          NUMBER                  -- 지역 아이디
, BASICPAY          NUMBER                  -- 기본급
, EXTRAPAY          NUMBER                  -- 수당
, CONSTRAINT EMPLOYEE_ID_PK PRIMARY KEY(EMPLOYEEID)
, CONSTRAINT EMPLOYEE_DEPARTMENTID_FK FOREIGN KEY(DEPARTMENTID)
             REFERENCES DEPARTMENT(DEPARTMENTID)
, CONSTRAINT EMPLOYEE_POSITIONID_FK FOREIGN KEY(POSITIONID)
             REFERENCES POSITION(POSITIONID)
, CONSTRAINT EMPLOYEE_REGIONID_FK FOREIGN KEY(REGIONID)
             REFERENCES REGION(REGIONID)
, CONSTRAINT EMPLOYEE_LUNAR_CK CHECK(LUNAR=0 OR LUNAR=1)
);
--==>> Table EMPLOYEE이(가) 생성되었습니다.

--○ 시퀀스 생성
CREATE SEQUENCE EMPLOYEESEQ
NOCACHE;
--==>> Sequence EMPLOYEESEQ이(가) 생성되었습니다.


--○ 데이터 입력( 데이터 입력)
INSERT INTO EMPLOYEE( EMPLOYEEID, NAME, SSN, BIRTHDAY, LUNAR, TELEPHONE, DEPARTMENTID, POSITIONID, REGIONID, BASICPAY, EXTRAPAY)   
VALUES(EMPLOYEESEQ.NEXTVAL, '김진희', CRYPTPACK.ENCRYPT('9903202234567','9903202234567')
        , TO_DATE('1999-03-20','YYYY-MM-DD'), 0, '010-7389-9032', 1, 1, 1
        , 1500000, 1500000); -- 백오십만, 백오십만
--==>> 1 행 이(가) 삽입되었습니다.

--※ 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.

--○ 확인
SELECT * 
FROM EMPLOYEE;
--==>> 1	김진희	iu?M?%?	1999-03-20	0	010-7389-9032	1	1	1	1500000	1500000

--○ 커밋
COMMIT;
--==>> 커밋 완료.

DESC EMPLOYEE;



--○ 직원 정보 조회 쿼리문 구성
SELECT E.EMPLOYEEID
     , E.NAME
     , E.SSN
     , TO_CHAR(E.BIRTHDAY, 'YYYY-MM-DD') AS BIRTHDAY
     , E.LUNAR
     , DECODE(E.LUNAR, 0, '양력', 1, '음력')  AS LUNAR
     , E.TELEPHONE
     , E.DEPARTMENTID
     , (SELECT DEPARTMENTNAME 
        FROM DEPARTMENT 
        WHERE DEPARTMENTID = E.DEPARTMENTID) AS DEPARTMENTNAME
     , POSITIONID
     , (SELECT POSITIONNAME 
        FROM POSITION 
        WHERE POSITIONID = E.POSITIONID) AS POSITIONNAME
     , E.REGIONID
     , (SELECT REGIONNAME 
        FROM REGION 
        WHERE REGIONID = E.REGIONID) AS REGINNAME
     , E.BASICPAY
     , E.EXTRAPAY
     , NVL(E.BASICPAY,0) + NVL(E.EXTRAPAY,0) AS PAY
FROM EMPLOYEE E
ORDER BY E.EMPLOYEEID;
--==>> 1	김진희	iu?M?%?	1999-03-20	0	양력	010-7389-9032	1	개발부	1	사원	1	서울	1500000	1500000	3000000


--○ 조회 뷰 생성(EMPLOYEEVIEW)
CREATE OR REPLACE VIEW EMPLOYEEVIEW
AS
SELECT E.EMPLOYEEID
     , E.NAME
     , E.SSN
     , TO_CHAR(E.BIRTHDAY, 'YYYY-MM-DD') AS BIRTHDAY
     , E.LUNAR
     , DECODE(E.LUNAR, 0, '양력', 1, '음력')  AS LUNARNAME
     , E.TELEPHONE
     , E.DEPARTMENTID
     , (SELECT DEPARTMENTNAME 
        FROM DEPARTMENT 
        WHERE DEPARTMENTID = E.DEPARTMENTID) AS DEPARTMENTNAME
     , POSITIONID
     , (SELECT POSITIONNAME 
        FROM POSITION 
        WHERE POSITIONID = E.POSITIONID) AS POSITIONNAME
     , E.REGIONID
     , (SELECT REGIONNAME 
        FROM REGION 
        WHERE REGIONID = E.REGIONID) AS REGINNAME
     , E.BASICPAY
     , E.EXTRAPAY
     , NVL(E.BASICPAY,0) + NVL(E.EXTRAPAY,0) AS PAY
FROM EMPLOYEE E
ORDER BY E.EMPLOYEEID;
--==>> View EMPLOYEEVIEW이(가) 생성되었습니다.


--○ 지역 데이터 조회 쿼리문 구성(지역 데이터 삭제 가능여부 확인)
SELECT R.REGIONID, R.REGIONNAME
      , (SELECT COUNT(*)
         FROM EMPLOYEE
         WHERE REGIONID = R.REGIONID) AS DELCHECK
FROM REGION R;
--==>>
/*
   REGIONID REGIONNAME                    DECHECK
----------- ------------------------- -----------
        1	서울	                            1
        2	경기	                            0
        3	인천	                            0
--> 『서울』의 지역 데이터는 삭제가 불가능한 상황이며,
--  『경기』, 『인천』의 지역 데이터는 삭제가 가능한 상황임을
--  판별할 수 있는 쿼리문
*/

--○ 뷰 생성(REGIONVIEW)
CREATE OR REPLACE VIEW REGIONVIEW 
AS
SELECT R.REGIONID, R.REGIONNAME
      , (SELECT COUNT(*)
         FROM EMPLOYEE
         WHERE REGIONID = R.REGIONID) AS DELCHECK
FROM REGION R;
--==>> View REGIONVIEW이(가) 생성되었습니다.

--○ 직위 데이터 조회 쿼리문 구성(직위 데이터 삭제 가능여부 확인)
SELECT P.POSITIONID, P.POSITIONNAME, P.MINBASICPAY
      , (SELECT COUNT(*)
         FROM EMPLOYEE
         WHERE POSITIONID = P.POSITIONID) AS DELCHECK
FROM POSITION P;
--==>>
/*
POSITIONID POSITIONNAME                   MINBASICPAY   DELCHECK
---------- ------------------------------ ----------- ----------
         1 사원                               1000000          2
         2 대리                               2000000          0
         3 부장                               3000000          0
         4 상무                               4000000          0
--> 사원은 1명이 있고 대리 부장 상무는 삭제 가능하구나~!
*/



--○ 뷰 생성(POSITIONVIEW)
CREATE OR REPLACE VIEW POSITIONVIEW 
AS
SELECT P.POSITIONID, P.POSITIONNAME, P.MINBASICPAY
      , (SELECT COUNT(*)
         FROM EMPLOYEE
         WHERE POSITIONID = P.POSITIONID) AS DELCHECK
FROM POSITION P;
--==>> View POSITIONVIEW이(가) 생성되었습니다.

--○ 부서 데이터 조회 쿼리문 구성(부서 데이터 삭제 가능여부 확인)
SELECT D.DEPARTMENTID, D.DEPARTMENTNAME
      , (SELECT COUNT(*)
         FROM EMPLOYEE
         WHERE DEPARTMENTID = D.DEPARTMENTID) AS DELCHECK
FROM DEPARTMENT D;
--==>>
/*


DEPARTMENTID DEPARTMENTNAME                   DELCHECK
------------ ------------------------------ ----------
           1 개발부                                  1
           2 기획부                                  0
           3 영업부                                  0
*/


--○ 뷰 생성(DEPARTMENTVIEW)
CREATE OR REPLACE VIEW DEPARTMENTVIEW 
AS
SELECT D.DEPARTMENTID, D.DEPARTMENTNAME
      , (SELECT COUNT(*)
         FROM EMPLOYEE
         WHERE DEPARTMENTID = D.DEPARTMENTID) AS DELCHECK
FROM DEPARTMENT D;
--==>> View DEPARTMENTVIEW이(가) 생성되었습니다.


--○ 직원별 최소 기본급 검색 쿼리문 구성
SELECT MINBASICPAY
FROM POSITION
WHERE POSITIONID=1; -- 사원
--> 한 줄 구성
SELECT MINBASICPAY FROM POSITION WHERE POSITIONID=1
;
--==>> 1000000

--○ 부서 뷰 조회 쿼리문
SELECT DEPARTMENTID, DEPARTMENTNAME, DELCHECK FROM DEPARTMENTVIEW ORDER BY DEPARTMENTID;

SELECT *
FROM EMPLOYEE
WHERE EMPLOYEEID=1;


-----------------------------------------------------------------------------------------



--○ 로그인, 로그아웃 과정 추가

-- ID 와 PW 컬럼 데이터를 담고 있는 테이블이 별도로 존재하지 않는 상황이다.
-- 이와 관련하여 EMPLOYEEID(사원 아이디) 와 SSN(주민번호) 뒷자리 
-- 7자리의 숫자를 이용할 수 있도록 구성한다.

--※ 기존 테이블 구조 변경
--① 
-- EMPLOYEE(직원 테이블)의 SSN(주민번호) 컬럼을 분리한다.
-- SSN -----------> SSN1, SSN2
-- SSN1 → 주민번호 앞 6자리
-- SSN2 → 주민번호 뒷 7자리 → 암호화 적용

--② 
-- EMPLOYEE(직원 테이블)에 GRADE(등급) 컬럼을 추가한다.
-- GRADE → 관리자0, 일반사원1


--○ 컬럼 분할 SSN → SSN1, SSN2 

-- 컬럼 추가
ALTER TABLE EMPLOYEE
ADD(SSN1 CHAR(6), SSN2 VARCHAR2(50));
--==>> Table EMPLOYEE이(가) 변경되었습니다.

SELECT *
FROM EMPLOYEE;


UPDATE EMPLOYEE
SET SSN1 = SUBSTR( CRYPTPACK.DECRYPT(SSN, '9903202234567'), 1, 6 )
  , SSN2 = CRYPTPACK.ENCRYPT( SUBSTR( CRYPTPACK.DECRYPT( SSN, '9903202234567'), 7, 7)
                            , SUBSTR( CRYPTPACK.DECRYPT( SSN, '9903202234567'), 7, 7) );
--==>> 1 행 이(가) 업데이트되었습니다.

SELECT *
FROM EMPLOYEE;
--==>> 1	김진희	iu?M?%?	1999-03-20	0	010-7389-9032	1	1	1	1500000	1500000	990320	Y{?7?


-- 기존 주민번호 컬럼(SSN) 제거
ALTER TABLE EMPLOYEE
DROP COLUMN SSN;
--==>> Table EMPLOYEE이(가) 변경되었습니다.

SELECT*
FROM EMPLOYEE;
--==>>
/*
MPLOYEEID NAME                           BIRTHDAY        LUNAR TELEPHONE                                DEPARTMENTID POSITIONID   REGIONID   BASICPAY   EXTRAPAY SSN1   SSN2                                              
---------- ------------------------------ ---------- ---------- ---------------------------------------- ------------ ---------- ---------- ---------- ---------- ------ -----------
         1 김진희                         1999-03-20          0 010-7389-9032                                       1          1          1    1500000    1500000 990320 Y{?7?                                           
*/


-- 컬럼 추가 → GRADE - 기본값을 1(일반 사원)로 구성
--                      0은 관리자로 구성
ALTER TABLE EMPLOYEE
ADD GRADE NUMBER(1) DEFAULT 1;
--==>> Table EMPLOYEE이(가) 변경되었습니다.
-- NUMBER(1) 은 숫자 한 자리로 하겠다~

-- '9903202234567'

SELECT *
FROM EMPLOYEE;
--==>> 1	김진희	1999-03-20	0	010-7389-9032	1	1	1	1500000	1500000	990320	Y{?7?	1
--                                                                                              GRADE 컬럼 추가 완!

-- 김진희 사원을 관리자로 임명
UPDATE EMPLOYEE
SET GRADE=0
WHERE EMPLOYEEID=1;
--==>> 1 행 이(가) 업데이트되었습니다.

SELECT *
FROM EMPLOYEE;
--==>> 김진희 관리자 임명된거 확인~!
--==>  GRADE 컬럼 0 으로 변경된거 !! 가 관리자로 임명됬다는 것!


COMMIT;
--==>> 커밋 완료.




--※ 테이블의 구조를 변경했기 때문에
--   이와 관련한 뷰(VIEW)의 내용을 새로 작성(수정)

--○ 직원 조회 뷰 생성
CREATE OR REPLACE VIEW EMPLOYEEVIEW
AS
SELECT E.EMPLOYEEID AS EMPLOYEEID
     , E.NAME AS NAME
     , E.SSN1 AS SSN
     , TO_CHAR(E.BIRTHDAY, 'YYYY-MM-DD') AS BIRTHDAY
     , E.LUNAR, DECODE(E.LUNAR, 0, '양력', 1, '음력') AS LUNARNAME
     , E.TELEPHONE AS TELEPHONE
     , E.DEPARTMENTID AS DEPARTMENTID
     , (SELECT DEPARTMENTNAME 
        FROM DEPARTMENT 
        WHERE DEPARTMENTID = E.DEPARTMENTID) AS DEPARTMENTNAME
     , E.POSITIONID AS POSITIONID
     , (SELECT POSITIONNAME
        FROM POSITION
        WHERE POSITIONID=E.POSITIONID) AS POSITIONNAME
     , E.REGIONID AS REGIONID
     , (SELECT REGIONNAME 
          FROM REGION
          WHERE REGIONID = E.REGIONID) AS REGIONNAME 
     , E.BASICPAY AS BASICPAY
     , E.EXTRAPAY AS EXTRAPAY
     , NVL(E.BASICPAY, 0) + NVL(E.EXTRAPAY, 0) AS PAY
     , E.GRADE AS GRADE
    FROM EMPLOYEE E
    ORDER BY E.EMPLOYEEID;
--==>> View EMPLOYEEVIEW이(가) 생성되었습니다.

DESC EMPLOYEEVIEW;
--==>>
/*
이름             널?       유형           
-------------- -------- ------------ 
EMPLOYEEID     NOT NULL NUMBER       
NAME                    VARCHAR2(30) 
SSN                     CHAR(6)      
BIRTHDAY                VARCHAR2(10) 
LUNAR                   NUMBER(1)    
LUNARNAME               VARCHAR2(6)  
TELEPHONE               VARCHAR2(40) 
DEPARTMENTID            NUMBER       
DEPARTMENTNAME          VARCHAR2(30) 
POSITIONID              NUMBER       
POSITIONNAME            VARCHAR2(30) 
REGIONID                NUMBER       
REGIONNAME              VARCHAR2(30) 
BASICPAY                NUMBER       
EXTRAPAY                NUMBER       
PAY                     NUMBER       
GRADE                   NUMBER(1)    
*/

--○ 직원 데이터 입력 쿼리문 구성(수정된 내용)
INSERT INTO EMPLOYEE( EMPLOYEEID, NAME, SSN1, SSN2, BIRTHDAY, LUNAR
                    , TELEPHONE, DEPARTMENTID, POSITIONID, REGIONID
                    , BASICPAY, EXTRAPAY)
VALUES( EMPLOYEESEQ.NEXTVAL, '윤유동', '930830', CRYPTPACK.ENCRYPT('2234567', '2234567') 
      , TO_DATE('1993-08-30', 'YYYY-MM-DD'), 0, '010-2944-6341', 1, 1, 1, 1500000, 1500000 ); -- 백오십만, 백오십만
--==>> 1 행 이(가) 삽입되었습니다.

SELECT *
FROM EMPLOYEE;
--==>>
/*
1	김진희	1999-03-20	0	010-7389-9032	1	1	1	1500000	1500000	990320	Y{?7?	0
2	윤유동	1993-08-30	0	010-2944-6341	1	1	1	1500000	1500000	930830	Y{?7?	1
*/

SELECT *
FROM EMPLOYEEVIEW;
--==>>
/*
1	김진희	990320	1999-03-20	0	양력	010-7389-9032	1	개발부	1	사원	1	서울	1500000	1500000	3000000	0
2	윤유동	930830	1993-08-30	0	양력	010-2944-6341	1	개발부	1	사원	1	서울	1500000	1500000	3000000	1
*/


--○ 일반 사원 로그인 쿼리문 구성(ID → EMPLOYEEID, PW → SSN2)

SELECT NAME
FROM EMPLOYEE
WHERE EMPOYEEID='ID문자열'
  AND SSN2=(SELECT SSN2 
            FROM EMPLOYEE
            WHERE EMPLOYEEID='ID문자열');

SELECT NAME
FROM EMPLOYEE
WHERE EMPLOYEEID=2
  AND SSN2=(SELECT SSN2 
            FROM EMPLOYEE
            WHERE EMPLOYEEID=2);
--==>> 윤유동

SELECT NAME
FROM EMPLOYEE
WHERE EMPLOYEEID=2
  AND (SELECT SSN2 
       FROM EMPLOYEE
       WHERE EMPLOYEEID=2) = CRYPTPACK.ENCRYPT('2234567', '2234561');
--==>> 조회 결과 없음 → 로그인 실패                             -- 이게 다름!!

SELECT NAME
FROM EMPLOYEE
WHERE EMPLOYEEID=2
  AND (SELECT SSN2 
       FROM EMPLOYEE
       WHERE EMPLOYEEID=2) = CRYPTPACK.ENCRYPT('2234567', '2234567');
--==>> 윤유동 → 로그인 성공
--> 일반 사원 로그인 쿼리문 한 줄 구성
SELECT NAME FROM EMPLOYEE WHERE EMPLOYEEID='ID문자열' AND (SELECT SSN2 FROM EMPLOYEE WHERE EMPLOYEEID=2) = CRYPTPACK.ENCRYPT('PW문자열', 'PW문자열')
;


--○ 관리자 로그인 쿼리문 구성(ID → EMPLOYEEID, PW → SSN2)
SELECT NAME
FROM EMPLOYEE
WHERE EMPLOYEEID = 2
  AND SSN2 = CRYPTPACK.ENCRYPT('2234567', '2234567')
  AND GRADE = 0; -- ▶ 이게 한개 더 추가 구성!  ★★★★★
--==>> 조회 결과 없음 → 로그인 실패

SELECT NAME
FROM EMPLOYEE
WHERE EMPLOYEEID = 1
  AND SSN2 = CRYPTPACK.ENCRYPT('2234567', '2234567')
  AND GRADE = 0;
--==>> 김진희 → 로그인 성공
--> 관리자 로그인 쿼리문 한 줄 구성
SELECT NAME FROM EMPLOYEE WHERE EMPLOYEEID=1 AND SSN2=CRYPTPACK.ENCRYPT('2234567', '2234567') AND GRADE=0
;
--> 치환
SELECT NAME FROM EMPLOYEE WHERE EMPLOYEEID='ID문자열' AND SSN2=CRYPTPACK.ENCRYPT('PW문자열', 'PW문자열') AND GRADE=0
;
--○ 직원 데이터 삭제 쿼리문 구성
DELETE
FROM EMPLOYEE
WHERE EMPLOYEEID=2;
--> 한 줄 구성
DELETE FROM EMPLOYEE WHERE EMPLOYEEID=2
;
-- 롤백
ROLLBACK;
--==>> 롤백 완료.


--○ 직원 데이터 수정 쿼리문 구성
UPDATE EMPLOYEE
SET NAME='김진희'
  , BIRTHDAY=TO_DATE('2001-01-01', 'YYYY-MM-DD')
  , LUNAR=0
  , TELEPHONE='010-1111-2222'
  , DEPARTMENTID=2
  , POSITIONID=2
  , REGIONID=2
  , BASICPAY=2000000   -- 이백만
  , EXTRAPAY=2000000   -- 이백만
  , SSN1='010101'
  , SSN2=CRYPTPACK.ENCRYPT('4234567', '4234567')
  , GRADE=1
WHERE EMPLOYEEID=1;
--==>> 1 행 이(가) 업데이트되었습니다.

-- 롤백
ROLLBACK;
--==>> 롤백 완료.

--○ 부서 리스트 조회 쿼리문 구성(DEPARTMENTVIEW)
SELECT DEPARTMENTID, DEPARTMENTNAME, DELCHECK
FROM DEPARTMENTVIEW
ORDER BY DEPARTMENTID;
--> 한줄 구성
SELECT DEPARTMENTID, DEPARTMENTNAME, DELCHECK FROM DEPARTMENTVIEW ORDER BY DEPARTMENTID
;
--==>>
/*
1	개발부	1
2	기획부	0
3	영업부	0
*/

--○ 부서 데이터 입력 쿼리문 구성(DEPARTMENT)
INSERT INTO DEPARTMENT(DEPARTMENTID, DEPARTMENTNAME) VALUES(DEPARTMENTSEQ.NEXTVAL, '총무부')
;
--==>> 1 행 이(가) 삽입되었습니다.

--○ 부서 데이터 삭제 쿼리문 구성
DELETE 
FROM DEPARTMENT 
WHERE DEPARTMENTID=2
;
-->> 한 줄 구성
DELETE FROM DEPARTMENT WHERE DEPARTMENTID=2
;

-- 롤백
ROLLBACK;
--==>> 롤백 완료.

--○ 부서 데이터 수정 쿼리문 구성(DEPARTMENT)
UPDATE DEPARTMENT
SET DEPARTMENTNAME='자원부'
WHERE DEPARTMENTID='1';
-->> 한 줄 구성
UPDATE DEPARTMENT SET DEPARTMENTNAME='자원부' WHERE DEPARTMENTID='1'
;

-- 롤백
ROLLBACK;
--==>> 롤백 완료.

--○ 지역 리스트 전체 조회 쿼리문 구성
SELECT REGIONID, REGIONNAME, DELCHECK 
FROM REGIONVIEW 
ORDER BY REGIONID;
-->> 한 줄 구성
SELECT REGIONID, REGIONNAME, DELCHECK FROM REGIONVIEW ORDER BY REGIONID
;

--○ 지역 데이터 등록 쿼리문 구성(REGION)
INSERT INTO REGION(REGIONID, REGIONNAME) VALUES(REGIONSEQ.NEXTVAL, '충북')
;
--==>> 1 행 이(가) 삽입되었습니다.

COMMIT;
--==>> 커밋 완료.

--○ 지역 데이터 삭제 쿼리문 구성
DELETE 
FROM REGION 
WHERE REGIONID=2;
-->> 한 줄 구성
DELETE FROM REGION WHERE REGIONID=2
;
--==>>1 행 이(가) 삭제되었습니다.

-- 롤백
ROLLBACK;
--==>> 롤백 완료.


--○ 지역 데이터 수정 쿼리문 구성
UPDATE REGION 
SET REGIONNAME='제주' 
WHERE REGIONID=4;
-->> 한 줄 구성
UPDATE REGION SET REGIONNAME='제주' WHERE REGIONID=4
;
--==>> 1 행 이(가) 업데이트되었습니다.

COMMIT;
--==>> 커밋 완료.

--○ 직위 리스트 조회 쿼리문 구성(POSITIONVIEW)

SELECT POSITIONID, POSITIONNAME, MINBASICPAY, MINBASICPAY, DELCHECK
FROM POSITIONVIEW
ORDER BY POSITIONID;
--> 한줄 구성
SELECT POSITIONID, POSITIONNAME, MINBASICPAY, MINBASICPAY, DELCHECK FROM POSITIONVIEW ORDER BY POSITIONID
;
--==>>
/*
1	사원	1000000	1000000	1
2	대리	2000000	2000000	0
3	부장	3000000	3000000	0
4	상무	4000000	4000000	0
*/

--○ 직위 데이터 입력 쿼리문 구성(POSITION)
INSERT INTO POSITION(POSITIONID, POSITIONNAME, MINBASICPAY) VALUES(POSITIONSEQ.NEXTVAL, '전무', 5000000)
;
--==>> 1 행 이(가) 삽입되었습니다.

COMMIT;
-- 커밋 완료.

--○ 직위 데이터 제거 쿼리문 구성(POSITION)
DELETE
FROM POSITION
WHERE POSITIONID=5;
--> 한줄 구성
DELETE FROM POSITION WHERE POSITIONID=5
;
--==>> 1 행 이(가) 삭제되었습니다.

ROLLBACK;
-->> 롤백 완료.

--○ 직위 데이터 수정 쿼리문 구성(POSITION)
UPDATE POSITION
SET POSITIONNAME='주임', MINBASICPAY=3000000 
WHERE POSITIONID=2
;
--> 한줄 구성
UPDATE POSITION SET POSITIONNAME='주임', MINBASICPAY=3000000 WHERE POSITIONID=2
;
--==>> 1 행 이(가) 업데이트되었습니다.

ROLLBACK;
--==>> 롤백 완료.

SELECT *
FROM POSITION;

SELECT EMPLOYEEID, NAME, SSN, BIRTHDAY, LUNAR, LUNARNAME, TELEPHONE
     , DEPARTMENTID, DEPARTMENTNAME, POSITIONID,POSITIONNAME, REGIONID
     , REGIONNAME, BASICPAY, EXTRAPAY, PAY, GRADE 
FROM EMPLOYEEVIEW;


--------------------------------------------------------------------------------

DESC EMPLOYEEVIEW;
--==>>
/*
이름             널?       유형           
-------------- -------- ------------ 
EMPLOYEEID     NOT NULL NUMBER       
NAME                    VARCHAR2(30) 
SSN                     CHAR(6)      
BIRTHDAY                VARCHAR2(10) 
LUNAR                   NUMBER(1)    
LUNARNAME               VARCHAR2(6)  
TELEPHONE               VARCHAR2(40) 
DEPARTMENTID            NUMBER       
DEPARTMENTNAME          VARCHAR2(30) 
POSITIONID              NUMBER       
POSITIONNAME            VARCHAR2(30) 
REGIONID                NUMBER       
REGINNAME               VARCHAR2(30) 
BASICPAY                NUMBER       
EXTRAPAY                NUMBER       
PAY                     NUMBER       
GRADE                   NUMBER(1)    
*/


SELECT EMPLOYEEID, NAME, SSN, BIRTHDAY
     , LUNAR, LUNARNAME, TELEPHONE
     , DEPARTMENTID, DEPARTMENTNAME
     , POSITIONID, POSITIONNAME
     , REGIONID, REGIONNAME
     , BASICPAY, EXTRAPAY, PAY, GRADE
FROM EMPLOYEEVIEW
ORDER BY EMPLOYEEID;
--==>>
/*
1	김진희	990320	1999-03-20	0	양력	010-7389-9032	1	개발부	1	사원	1	서울	1500000	1500000	3000000	0
*/

-- ○ 직원 검색 쿼리문 구성(아이디로 직원 검색)
SELECT EMPLOYEEID, NAME, SSN1
     , TO_CHAR(BIRTHDAY, 'YYYY-MM-DD') AS BIRTHDAY
     , LUNAR, TELEPHONE, DEPARTMENTID, POSITIONID, REGIONID
     , BASICPAY, EXTRAPAY
FROM EMPLOYEE
WHERE EMPLOYEEID=1;
--> 한 줄 구성
SELECT EMPLOYEEID, NAME, SSN1, TO_CHAR(BIRTHDAY, 'YYYY-MM-DD') AS BIRTHDAY, LUNAR, TELEPHONE, DEPARTMENTID, POSITIONID, REGIONID, BASICPAY, EXTRAPAY FROM EMPLOYEE WHERE EMPLOYEEID=1
;
--==>> 1	김진희	990320	1999-03-20	0	010-7389-9032	1	1	1	1500000	1500000

