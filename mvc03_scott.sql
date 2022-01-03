-- edu_scott �� �п� ���̶� ����

select user
from dual;
--==>SCOTT

desc tbl_memberlist;

drop TABLE tbl_memberlist;
--==>> Table TBL_MEMBERLIST��(��) �����Ǿ����ϴ�.


--�� �ǽ� ���̺� ����
CREATE TABLE TBL_MEMBERLIST
( MID   NUMBER
, NAME  VARCHAR2(30)
, TELEPHONE  VARCHAR2(50)
, CONSTRAINT MEMBERLIST_MID_PK PRIMARY KEY(MID)
);
--==>> Table TBL_MEMBERLIST��(��) �����Ǿ����ϴ�.

--�� ������ ����(MEMBERLISTSEQ)
CREATE SEQUENCE MEMBERLISTSEQ
NOCACHE;
--==>> Sequence MEMBERLISTSEQ��(��) �����Ǿ����ϴ�.


--�� ���� ������ �Է�
INSERT INTO TBL_MEMBERLIST(MID, NAME, TELEPHONE) VALUES (MEMBERLISTSEQ.NEXTVAL, '������', '010-2345-5678')
;
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_MEMBERLIST(MID, NAME, TELEPHONE) VALUES (MEMBERLISTSEQ.NEXTVAL, '��ȿ��', '010-1234-1234')
;
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.



COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� ��� ��ȸ ������ ����
SELECT MID, NAME, TELEPHONE
FROM TBL_MEMBERLIST
ORDER BY MID;
--> �� �� ����
SELECT MID, NAME, TELEPHONE FROM TBL_MEMBERLIST ORDER BY MID
;
--==>>
/*
1	������	010-2345-5678
2	��ȿ��	010-1234-1234
*/


--�� �ο� �� ��ȸ ������ ����
SELECT COUNT(*) AS COUNT
FROM TBL_MEMBERLIST;
--> �� �� ����
SELECT COUNT(*) AS COUNT FROM TBL_MEMBERLIST
;
--==>> 2



