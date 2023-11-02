--���� ����
/*
CREATE user C##(�Ϲݻ����)���̵� IDENTIFIED BY ��й�ȣ
*/
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE; -- ���� ����� ��Ģ ����

CREATE user JGH_TEST IDENTIFIED BY "1234"; -- ����(F9)
-- ���� �ο� GRANT ���� TO ���̵�
GRANT CREATE SESSION TO JGH_TEST;
-- ���� ȸ�� REVOKE ���� FROM ���̵�
REVOKE CREATE SESSION FROM JGH_TEST;
-- ���� ���� DROP USER ���̵�
DROP USER JGH_TEST;

-- DBA ��������
CREATE USER JGH_DBA IDENTIFIED BY "1111";
-- DBA ���Ѻο�
GRANT DBA TO JGH_DBA;


-- ���̺� ���� CREATE TABLE �̸�(�÷��� Ÿ��); NVARCHAR2(���ڼ�)-���ڿ�������Ÿ��
CREATE TABLE MEMBERS( -- ȸ������ ���̺�
    MID NVARCHAR2(5), -- ���̵� ����, ���� �ִ� 5���ڱ���
    MPW NVARCHAR2(5), -- ��й�ȣ
    MNAME NVARCHAR2(5)
);
DESC MEMBERS; -- ���̺� ���� Ȯ��

SELECT * FROM MEMBERS; -- ���̺� ��ȸ(*-������ ��ȸ)
INSERT INTO MEMBERS VALUES('ID01', 'PW01', 'ȸ��01');
INSERT INTO MEMBERS VALUES('ID02', 'PW02', 'ȸ��02');
INSERT INTO MEMBERS VALUES('ID03', 'PW03', 'ȸ��03');
SELECT * FROM MEMBERS; 

/* ���̺� ����
CREATE TABLE ���̺��̸�(
    �÷���1 ������Ÿ��,
    �÷���2 ������Ÿ��,
    �÷���3 ������Ÿ��
); -- Table MEMBERS��(��) �����Ǿ����ϴ�.
*/

/* ������Ÿ��
������ - ������: CHAR(N=���ڼ� N�� ������ ����Ʈ)
        ������: VARCHAR(VAR�� ������ ������), NVARCHAR2(5) - (N=���ڼ�)
������ - NUMBER: ����ڸ��� ����(����x), NUMBER(3): 3�ڸ���������, NUMBER(3,2): ���ڸ��� 3�ڸ��� ','������ �Ҽ���2�ڸ���
��¥�� - DATE // ��-��-�� ��:��:��
            YYYY-MM-DD HH24(24:0~24��, ������ 12��):MI:SS
*/

/*
CREATE - INSERT
READ   - SELECT
UPDATE - UPDATE(�÷��� ����Ǿ��ִ� �����͸� ����)
DELETE - DELETE
*/

------Day02  

CREATE TABLE CHARTEST_TBL(
    CHARCOL1 CHAR(5),
    NCHARCOL2 NCHAR(5)
);
/* INSERT 
INSERT INTO ���̺��(�÷���1, �÷���2) 
VALUES(������1, ������2);

���ڴ� ''�ȿ� �ۼ�
*/
INSERT INTO CHARTEST_TBL(CHARCOL1, NCHARCOL2)
VALUES('ABCDE', 'ABCDE');

SELECT * FROM CHARTEST_TBL;

INSERT INTO CHARTEST_TBL(CHARCOL1, NCHARCOL2)
VALUES('�����ٶ�', 'ABCDE'); -- ���� ORA-12899: "JGH_DBA"."CHARTEST_TBL"."CHARCOL1" ���� ���� ���� �ʹ� ŭ(����: 15, �ִ밪: 5)

INSERT INTO CHARTEST_TBL(CHARCOL1, NCHARCOL2)
VALUES('ABCDE', '�����ٶ�');

CREATE TABLE NUMBERTEST_TBL(
    COL1 NUMBER,
    COL2 NUMBER(3),
    COL3 NUMBER(3, 2) -- 1.23
);
INSERT INTO NUMBERTEST_TBL
VALUES(123, 123, 1.23);
INSERT INTO NUMBERTEST_TBL
VALUES(12345678, 123, 1.23);
INSERT INTO NUMBERTEST_TBL
VALUES(12345678, 123345678, 1.23); -- ���� ORA-01438: �� ���� ���� ������ ��ü �ڸ������� ū ���� ���˴ϴ�.
INSERT INTO NUMBERTEST_TBL
VALUES(12334567, 123, 1.2345678); -- �Է¼���(1.23�� ������ �������� ©��)
SELECT * FROM NUMBERTEST_TBL;
INSERT INTO NUMBERTEST_TBL
VALUES(123, 123, 12.3); -- ORA-01438: �� ���� ���� ������ ��ü �ڸ������� ū ���� ���˴ϴ�. - �Ҽ��� 1�ڸ����� ��Ģ�� ��߳�

/* ��¥�� ������ */
CREATE TABLE DATETEST_TBL(
    COL1 DATE
);
-- �ý��� DATE �Է�
INSERT INTO DATETEST_TBL VALUES(SYSDATE);
SELECT * FROM DATETEST_TBL;

INSERT INTO DATETEST_TBL VALUES('2023/05/19');
INSERT INTO DATETEST_TBL VALUES('2023-06-19');
INSERT INTO DATETEST_TBL VALUES('2023-06-19 23:50:48');
INSERT INTO DATETEST_TBL VALUES('20230519');
-- TO_DATE( '��¥�� ������ ����', '��¥Ȯ�ι��' ) : ������ >> ��¥������ ��ȯ
INSERT INTO DATETEST_TBL VALUES( TO_DATE('2023-07-19 23:50:48', 'YYYY-MM-DD HH24:MI:SS') );
SELECT * FROM DATETEST_TBL;
-- TO_CHAR( '���ڷ� ������ ��¥', '������ ����' );

SELECT TO_CHAR (COL1, 'YYYY/MM/DD')
FROM DATETEST_TBL;

/* ���̺��� ALTER(����)
ALTER TABLE ���̺��̸� 
[ADD(�߰�), RENAME(�̸�����), MODIFY(Ÿ�Ժ���), DROP(����)]
*/
/* ���ο� �÷� �߰� 
ALTER TABLE ���̺��̸� 
ADD �÷��� ������Ÿ��;
*/
CREATE TABLE ALTER_TBL(
    COL1 NUMBER
);
-- ALTER_TBL ���̺� �÷��̸��� NAME, ������Ÿ���� NVARCHAR2(5) �÷� �߰�
ALTER TABLE ALTER_TBL ADD NAME NVARCHAR2(5);
/* �÷� �̸� ���� 
ALTER TABLE ���̺��̸�
RENAME COLUMN �����÷��� TO �ٲ��÷���;
*/
-- ALTER_TBL ���̺� COL1 �÷����� AGE�� ����
ALTER TABLE ALTER_TBL RENAME COLUMN COL1 TO AGE;
SELECT * FROM ALTER_TBL;
DESC ALTER_TBL; -- ���̺� ����Ȯ��

/* �÷��� ������ Ÿ�� ����
ALTER TABLE ���̺��̸�
MODIFY �÷��� ������Ÿ��;
*/
-- ALTER_TBL ���̺� �÷��� EMAIL ������Ÿ�� NUMBER �÷��߰�
ALTER TABLE ALTER_TBL ADD EMAIL NUMBER;
-- ALTER_TBL ���̺��� EMAIL �÷��� ������Ÿ���� ������ �ִ� 20���ڱ���
ALTER TABLE ALTER_TBL MODIFY EMAIL NVARCHAR2(20);
DESC ALTER_TBL;

/* �÷� ���� 
ALTER TABLE ���̺��̸�
DROP COLUMN �÷���;
*/
-- ALTER_TBL �׾ƺ� AGE �÷��� ����
ALTER TABLE ALTER_TBL DROP COLUMN AGE;

/* �������� 
 - PRIMARY KEY
 - FOREIGE KEY
 - UNIQUE
 - NOT NULL
 - CHECK 
 - DEFAULT
*/
/* UNIQUE : ���̺��� Ư���� �÷� �ο�, �ߺ��Ǵ� ���� �Էµ��� �ʵ��� ���� */
CREATE TABLE MEMBERS(
     MID NVARCHAR2(20),
     MPW NVARCHAR2(20),
     MNAME NVARCHAR2(5),
     MEMAIL NVARCHAR2(20)
);
-- ȸ������ �Է�
INSERT INTO MEMBERS(MID, MPW, MNAME, MEMAIL)
VALUES('JGH', '1111', '����ȣ', 'JGH1111@ICIA.CO.KR');
INSERT INTO MEMBERS(MID, MPW, MNAME, MEMAIL)
VALUES('JGH', '1111', '��õ�Ϻ�', 'JGH1111@ICIA.CO.KR');
SELECT * FROM MEMBERS;
/* ���̺� �������� �ο� 
ALTER TABLE ���̺��̸�
ADD CONSTRAINT �ĺ��̸� ������������ �ο����÷���;
*/
-- MEMBERS ���̺��� MID �÷��� UNIQUE �������� �ο�
ALTER TABLE MEMBERS ADD CONSTRAINT UK_MEM_MID UNIQUE (MID); -- �ߺ��� �����Ͱ� �����ؼ� ���� �߻�
-- ORA-02299: ���� (JGH_DBA.UK_MEM_MID)�� ��� �����ϰ� �� �� ���� - �ߺ� Ű�� �ֽ��ϴ�(�̹� MID�ߺ��Ȱ��� ���־ ����)
DELETE FROM MEMBERS; -- DELETE - ���̺� �����͸� ����

ALTER TABLE MEMBERS ADD CONSTRAINT UK_MEM_MID UNIQUE (MID);
INSERT INTO MEMBERS(MID, MPW, MNAME, MEMAIL)
VALUES('JGH', '1111', '����ȣ', 'JGH1111@ICIA.CO.KR'); -- �Է¼���
INSERT INTO MEMBERS(MID, MPW, MNAME, MEMAIL)
VALUES('JGH', '1111', '��õ�Ϻ�', 'JGH1111@ICIA.CO.KR'); -- �Է½���
-- ORA-00001: ���Ἲ ���� ����(JGH_DBA.UK_MEM_MID)�� ����˴ϴ�

-- MEMBERS ���̺��� MEMAIL �÷��� UNIQUE �������� �ο�
ALTER TABLE MEMBERS ADD CONSTRAINT UK_MEM_MEMAIL UNIQUE(MEMAIL);
INSERT INTO MEMBERS(MID, MPW, MNAME, MEMAIL)
VALUES('JJJ', '1111', '����ȣ', 'JGH1111@ICIA.CO.KR');
-- ORA-00001: ���Ἲ ���� ����(JGH_DBA.UK_MEM_MEMAIL)�� ����˴ϴ�


-----day03

/* �׾ƺ��� �����ϸ鼭 �������� �ο�1 */
CREATE TABLE MEMBERS2(
     MID NVARCHAR2(20) CONSTRAINT UK_MEM2_MID UNIQUE ,  --���̵�
     MPW NVARCHAR2(20),  --��й�ȣ
     MNAME NVARCHAR2(5), --�̸�
     MEMAIL NVARCHAR2(20)--�̸���
);
/* ���̺��� �����ϸ鼭 �������� �ο�2 */
CREATE TABLE MEMBERS3(
     MID3 NVARCHAR2(20),    --���̵�
     MPW3 NVARCHAR2(20),    --��й�ȣ
     MNAME3 NVARCHAR2(5),   --�̸�
     MEMAIL3 NVARCHAR2(20), --�̸���
     CONSTRAINT UK_MEM3_MID UNIQUE(MID3)
);
/* UNIQUE : ���̺��� Ư���� �÷� �ο�, �ߺ��Ǵ� ���� �Էµ��� �ʵ��� ���� */
INSERT INTO MEMBERS3(MID3, MPW3, MNAME3, MEMAIL3)
VALUES('JGH', '1111', '����ȣ', 'QWE123@ICIA.CO.KR' ); 
INSERT INTO MEMBERS3(MID3, MPW3, MNAME3, MEMAIL3)
VALUES('JGH', '1234', 'ȸ��02', 'ȸ��02@ICIA.CO.KR' ); 

--MID �÷��� NULL�� �Է�
INSERT INTO MEMBERS3(MPW3, MNAME3, MEMAIL3)
VALUES('1234', 'ȸ��03', 'ȸ��03@ICIA.CO.KR' );
INSERT INTO MEMBERS3(MID3, MPW3, MNAME3, MEMAIL3)
VALUES(NULL, '1234', 'ȸ��04', 'ȸ��04@ICIA.CO.KR' ); 
SELECT * FROM MEMBERS3;

/* NOT NULL : ������ �÷��� NULL���� ������� �ʴ´�.(�ɼ�-�Ⱦ��� NULL���� ���) */
CREATE TABLE MEMBERS(
     MID NVARCHAR2(20) CONSTRAINT NN_MEM_MID NOT NULL, --���̵�
     MPW NVARCHAR2(20),     --��й�ȣ
     MNAME NVARCHAR2(5),    --�̸�
     MEMAIL NVARCHAR2(20),  --�̸���
     CONSTRAINT UK_MEM_MID UNIQUE(MID)
);
INSERT INTO MEMBERS(MID, MPW, MNAME, MEMAIL)
VALUES(NULL, '1234', 'ȸ��01', 'ȸ��01@ICIA.CO.KR' ); --ORA-01400: NULL�� ("JGH_DBA"."MEMBERS"."MID") �ȿ� ������ �� �����ϴ�

DROP TABLE MEMBERS;
CREATE TABLE MEMBERS(
     MID NVARCHAR2(20),     --���̵�
     MPW NVARCHAR2(20),     --��й�ȣ
     MNAME NVARCHAR2(5),    --�̸�
     MEMAIL NVARCHAR2(20),  --�̸���
     CONSTRAINT UK_MEM_MID UNIQUE(MID)
);
ALTER TABLE MEMBERS 
MODIFY MID NOT NULL;
DESC MEMBERS;
--UNIQUE �������ǻ���
ALTER TABLE MEMBERS DROP CONSTRAINT UK_MEM_MID;
--NOT NULL=>NULL
ALTER TABLE MEMBERS MODIFY MID NULL;

/* �������� 
 - UNIQUE : ���̺��� Ư���� �÷� �ο�, �ߺ��Ǵ� ���� �Է� ���� �ʵ��� ����
 - NOT NULL : Ʈ�� �÷��� NULL���� �Է� ���� �ʵ��� ����
 - PRIMARY KEY : UNIQUE + NOT NULL (���̺� �ѹ��� �ο��� �� ����)
                 ���̺��� ���ڵ带 ���� ���� �� �ִ� ������ �÷��� �ο�
*/
DROP TABLE MEMBERS;
CREATE TABLE MEMBERS(
     MID NVARCHAR2(20),     --���̵�
     MPW NVARCHAR2(20),     --��й�ȣ
     MNAME NVARCHAR2(5),    --�̸�
     MEMAIL NVARCHAR2(20)  --�̸���
);
-- MID �÷��� PRIMARY KEY �ο�
ALTER TABLE MEMBERS ADD CONSTRAINT PK_MEM_MID PRIMARY KEY(MID);
INSERT INTO MEMBERS(MID, MPW, MNAME, MEMAIL)
VALUES('JGH', '1111', '����ȣ', 'QWE123@ICIA.CO.KR');
INSERT INTO MEMBERS(MID, MPW, MNAME, MEMAIL) -- UNIQUE Ȯ��
VALUES('JGH', '1234', 'ȸ��01', 'ȸ��01@ICIA.CO.KR'); --����: ORA-00001: ���Ἲ ���� ����(JGH_DBA.PK_MEM_MID)�� ����˴ϴ�

INSERT INTO MEMBERS(MID, MPW, MNAME, MEMAIL) -- NOT NULL Ȯ��
VALUES(NULL, '1234', 'ȸ��02', 'ȸ��02@ICIA.CO.KR'); -- ORA-01400: NULL�� ("JGH_DBA"."MEMBERS"."MID") �ȿ� ������ �� �����ϴ�
--�̸��� �÷��� UNIQUE ���� ���� �ο�
ALTER TABLE MEMBERS ADD CONSTRAINT UK_MEM_MEMAIL UNIQUE(MEMAIL);
INSERT INTO MEMBERS(MID, MPW, MNAME, MEMAIL)
VALUES('ID01', '1234', 'ȸ��01', NULL);
INSERT INTO MEMBERS(MID, MPW, MNAME, MEMAIL)
VALUES('ID02', '1234', 'ȸ��02', NULL); -- UNIQUE�� NULL���� ��

-- MNAME�� PRIMARY KEY �ο�
ALTER TABLE MEMBERS ADD CONSTRAINT PK_MEM_MNAME PRIMARY KEY(MNAME); -- ORA-02260: ���̺��� �ϳ��� �⺻ Ű�� ���� �� �ֽ��ϴ�.
ALTER TABLE MEMBERS ADD CONSTRAINT UK_MEM_MNAME UNIQUE(MNAME);
SELECT * FROM MEMBERS;

/* DEFAULT : Ư���� �÷��� ���� �Էµ��� ���� ��� �⺻���� �ԷµǴ� ���� ���� */
DROP TABLE MEMBERS;
CREATE TABLE MEMBERS(
     MID NVARCHAR2(20),     --���̵�
     MPW NVARCHAR2(20),     --��й�ȣ
     MNAME NVARCHAR2(20) DEFAULT '�̸�����',   --�̸�
     MAGE NUMBER            --����
);
INSERT INTO MEMBERS(MID, MPW, MAGE)
VALUES('ID01', '1234', 10);
INSERT INTO MEMBERS(MID, MAGE)
VALUES('ID01', 10);
SELECT * FROM MEMBERS;
INSERT INTO MEMBERS(MID, MPW, MNAME, MAGE)
VALUES('ID02', '1234', DEFAULT, 20);

/* ���� �÷��� �⺻�� 1 ���� */
ALTER TABLE MEMBERS MODIFY MAGE DEFAULT 1;

/* CHECK : Ư���� �÷��� �Է��� �� �ִ� ���� ���� ���� �ο� */
DROP TABLE MEMBERS;
CREATE TABLE MEMBERS(
     MID NVARCHAR2(20),     --���̵�
     MPW NVARCHAR2(20),     --��й�ȣ
     MNAME NVARCHAR2(20),   --�̸�
     MAGE NUMBER,            --����
     CONSTRAINT CK_MEM_MAGE CHECK(MAGE > 10) 
);
INSERT INTO MEMBERS(MAGE)
VALUES(30); -- 1 �� ��(��) ���ԵǾ����ϴ�.
SELECT * FROM MEMBERS;
INSERT INTO MEMBERS(MAGE)
VALUES(5); -- ORA-02290: üũ ��������(JGH_DBA.CK_MEM_MAGE)�� ����Ǿ����ϴ�

/* �������� 
 - PRIMARY KEY
 - UNIQUE
 - NOT NULL
 - FOREIGN(E) KEY
 - CHECK 
 - DEFAULT
*/

-- FOREIGN KEY
DROP TABLE MEMBERS;
CREATE TABLE MEMBERS(
     MID NVARCHAR2(20),    --���̵�
     MPW NVARCHAR2(20)     --��й�ȣ
);
-- MID �÷��� PRIMARY KEY �ο�
ALTER TABLE MEMBERS
ADD CONSTRAINT PK_MEM_MID PRIMARY KEY(MID);

INSERT INTO MEMBERS(MID, MPW)
VALUES('JGH', '1111'); -- ȸ�� ���� �Է�
INSERT INTO MEMBERS(MID, MPW)
VALUES('ABC', '1234'); 
SELECT * FROM MEMBERS;

DROP TABLE LOGINCHECK;
CREATE TABLE LOGINCHECK( -- ȸ���� �α��� �ð�
    MID NVARCHAR2(20),   -- ȸ�� ���̵� - MEMBERS ���̺��� MID�÷��� ��
    LOGINTIME DATE       -- �α��� �ð�
);
-- LOGINCHECK���̺� MID �÷��� FOREIGN KEY ����
ALTER TABLE LOGINCHECK
ADD CONSTRAINT FK_LOG_MID FOREIGN KEY( MID )
REFERENCES MEMBERS(MID);

-- FOREIGN KEY : MEMBERS���̺� �ִ� �����͸� LOGINCHECK���̺� �� �� ����
INSERT INTO LOGINCHECK(MID, LOGINTIME)
VALUES('ICIA', SYSDATE); -- ORA-02291: ���Ἲ ��������(JGH_DBA.FK_LOG_MID)�� ����Ǿ����ϴ�- �θ� Ű�� �����ϴ�

INSERT INTO LOGINCHECK(MID, LOGINTIME)
VALUES('JGH', SYSDATE); -- �Է°���
INSERT INTO LOGINCHECK(MID, LOGINTIME)
VALUES('ABC', SYSDATE); -- �Է°���
SELECT * FROM LOGINCHECK;


-----day04

/* FOREIGN KEY : �ܷ�Ű */
-- �⺻Ű�� ������ �͸� �ܷ�Ű�� ������ �� �ְ�
/* ��ǰ���� ���̺� - GOODS
    ��ǰ�̸� - GNAME ���� 20���ڱ���, PRIMARY KEY�� ����
    ��ǰ���� - GPRICE ����Ÿ��
    ����귣�� - GBRAND ����Ÿ�� 20���ڱ��� - NOT NULL
*/

CREATE TABLE GOODS(
    GNAME NVARCHAR2(20),
    GPRICE NUMBER,
    GBRAND NVARCHAR2(20)
);
-- �������� �ο�
ALTER TABLE GOODS
ADD CONSTRAINT PK_GOODS_GNAME PRIMARY KEY(GNAME)
MODIFY GBRAND NOT NULL;
-- ��ǰ�����Է�
INSERT INTO GOODS(GNAME, GPRICE, GBRAND)
VALUES('7800X3D', '600000', 'AMD' );
INSERT INTO GOODS(GNAME, GPRICE, GBRAND)
VALUES('RTX4090', '2300000', 'NVIDIA' );
INSERT INTO GOODS(GNAME, GPRICE, GBRAND)
VALUES('RTX4070', '750000', 'NVIDIA' );

/* �ֹ����� ���̺� 
    ��ǰ�̸�, ����, ������, �ֹ��Ͻ�, �����, �ֹ�����
    ��ǰ�̸� ����20��
*/
CREATE  TABLE ORDERLIST(
    GNAME NVARCHAR2(20),     -- ��ǰ�̸�
    GPRICE NUMBER,           -- ��ǰ����
    CUSTOMER NVARCHAR2(10),  -- ������
    ODDATE DATE,             -- �ֹ��Ͻ�
    ADDRESS NVARCHAR2(50),    -- �����
    QTY NUMBER               -- �ֹ���
);
-- FOREIGN KEY : �ܷ�Ű ����
ALTER TABLE ORDERLIST
ADD CONSTRAINT FK_ODLIST_GNAME FOREIGN KEY(GNAME)
REFERENCES GOODS(GNAME);
-- �ֹ� ���� �Է�
INSERT INTO ORDERLIST(GNAME, GPRICE, CUSTOMER, ODDATE, ADDRESS, QTY)
VALUES('7800X3D', 600000, '����ȣ', SYSDATE, '��õ', 1);
INSERT INTO ORDERLIST(GNAME, GPRICE, CUSTOMER, ODDATE, ADDRESS, QTY)
VALUES('7800X3D', 600000, 'ȫ�浿', SYSDATE, '��õ', 1);
INSERT INTO ORDERLIST(GNAME, GPRICE, CUSTOMER, ODDATE, ADDRESS, QTY)
VALUES('RTX4070', 750000, 'ICIA', SYSDATE, '��õ�Ϻ���ī����', 1);
INSERT INTO ORDERLIST(GNAME, GPRICE, CUSTOMER, ODDATE, ADDRESS, QTY)
VALUES('RTX4090', 2300000, 'ICAI', SYSDATE, '��õ�Ϻ���ī����', 1);

SELECT * FROM ORDERLIST;

INSERT INTO ORDERLIST(GNAME, GPRICE, CUSTOMER, ODDATE, ADDRESS, QTY)
VALUES('���̴�', 1000, '����ȣ', SYSDATE, '��õ', 1); -- ORA-02291: ���Ἲ ��������(JGH_DBA.FK_ODLIST_GNAME)�� ����Ǿ����ϴ�- �θ� Ű�� �����ϴ�

-- 1. ORDERLIST ���̺��� ��ǰ�̸�
SELECT GNAME FROM ORDERLIST;

/*
CREATE - INSERT : ������ �Է�
READ   - SELECT : ������ ��ȸ
UPDATE - UPEATE : ������ ����
DELETE - DELETE : ������ ����
*/
/* INSERT��
   INSERT INTO ���̺��̸�( �÷���1, �÷���2,....�÷���N )
   VALUES( �÷�1�� ������ ��, �÷�2�� ������ ��,.... );
*/
DROP TABLE ORDERLIST;
DROP TABLE GOODS;
CREATE TABLE GOODS(
    GNAME NVARCHAR2(20),
    GPRICE NUMBER,
    GBRAND NVARCHAR2(20)
);
INSERT INTO GOODS(GNAME, GPRICE, GBRAND)
VALUES('��ǰ��1', 10000, '�귣��1');
INSERT INTO GOODS(GNAME, GPRICE, GBRAND)
VALUES('�귣��2', 10000, '��ǰ��2');
INSERT INTO GOODS( GPRICE, GBRAND, GNAME)
VALUES( 10000, '�귣��3', '��ǰ��3');
INSERT INTO GOODS(GNAME, GBRAND)
VALUES('��ǰ��4', '�귣��4');
INSERT INTO GOODS(GBRAND)
VALUES('�귣��5');
-- �÷����� ���X VALUES�׸��� ���̺��� ��� �÷���
INSERT INTO GOODS
VALUES('��ǰ��6', 20000, '�귣��6'); -- GNAME, GPRICE, GBRAND
SELECT * FROM GOODS;
SELECT * FROM GOODS WHERE GPRICE = 10000;

/* ������ ��ȸ - SELECT 
[5]SELECT ��ȸ���÷���, ��ȸ���÷���2...
[1]FROM ���̺�� 
[2]WHERE ����
[3]GROUP BY �׷��� ���� �÷�
[4]HAVING ������ �׷쿡 �ο��� ����
[6]ORDER BY ���ı����÷�
*/

/* ������ ���� : UPDATE
    UPDATE ���̺��
    SET �÷���1 = ������ ������, �÷���2 = ������ ������
    WHERE �����͸� ������ ���ڵ带 ������ ����
*/
SELECT * FROM GOODS;

UPDATE GOODS 
SET GPRICE = 1500; -- 6�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

UPDATE GOODS
SET GPRICE = 10000
WHERE GNAME = '��ǰ��1'; -- 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

UPDATE GOODS
SET GPRICE = 15000, GBRAND = '�귣������'
WHERE GNAME = '��ǰ��1';

/* ������ ���� : DELETE
    DELETE FROM ���̺��
    WHERE ������ ���ڵ带 �����ϴ� ����
*/              
DELETE FROM GOODS
WHERE GNAME = '��ǰ��1'; -- 1 �� ��(��) �����Ǿ����ϴ�.
DELETE FROM GOODS; -- ���̺��� �����ְ� ��� ���ڵ尡 ������(��� �� ����)

SELECT * FROM GOODS;
CREATE TABLE GOODS(
    GNAME NVARCHAR2(20),
    GPRICE NUMBER,
    GBRAND NVARCHAR2(20)
);
INSERT INTO GOODS(GNAME, GPRICE, GBRAND)
VALUES('��ǰ��1', 10000, '�귣��1');
INSERT INTO GOODS(GNAME, GPRICE, GBRAND)
VALUES('�귣��2', 10000, '��ǰ��2');
SELECT * FROM GOODS; -- ���ڵ� 2��
ROLLBACK;            -- ���� ���·�(���̺� �������)
SELECT * FROM GOODS; -- ���ڵ� ����

INSERT INTO GOODS(GNAME, GPRICE, GBRAND)
VALUES('��ǰ��1', 10000, '�귣��1');
INSERT INTO GOODS(GNAME, GPRICE, GBRAND)
VALUES('�귣��2', 10000, '��ǰ��2');
COMMIT;  -- �����Ǿ��ִ� ������ ����(Ȯ��)
ROLLBACK;-- Ŀ���� �� �������� �ѹ�(�ǵ���)
SELECT * FROM GOODS; -- ���ڵ� 2��

INSERT INTO GOODS(GNAME, GPRICE, GBRAND)
VALUES('��ǰ��3', 30000, '�귣��3');
ROLLBACK;
SELECT * FROM GOODS;

CREATE TABLE TESTTBL01(COL01 NUMBER); -- CREATE, ALTER, DROP�� �ڵ����� Ŀ�Եȴ�
ROLLBACK;
SELECT * FROM TESTTBL01;


-----day05
DROP TABLE DEPT;
CREATE TABLE DEPT
    (DEPTNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY,
	DNAME VARCHAR2(14) ,
	LOC VARCHAR2(13) ) ;
DROP TABLE EMP;
CREATE TABLE EMP
       (EMPNO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4),
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2) CONSTRAINT FK_DEPTNO REFERENCES DEPT);
INSERT INTO DEPT VALUES
	(10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES
	(30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES
	(40,'OPERATIONS','BOSTON');
INSERT INTO EMP VALUES
(7369,'SMITH','CLERK',7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);
INSERT INTO EMP VALUES
(7499,'ALLEN','SALESMAN',7698,to_date('20-2-1981','dd-mm-yyyy'),1600,300,30);
INSERT INTO EMP VALUES
(7521,'WARD','SALESMAN',7698,to_date('22-2-1981','dd-mm-yyyy'),1250,500,30);
INSERT INTO EMP VALUES
(7566,'JONES','MANAGER',7839,to_date('2-4-1981','dd-mm-yyyy'),2975,NULL,20);
INSERT INTO EMP VALUES
(7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981','dd-mm-yyyy'),1250,1400,30);
INSERT INTO EMP VALUES
(7698,'BLAKE','MANAGER',7839,to_date('1-5-1981','dd-mm-yyyy'),2850,NULL,30);
INSERT INTO EMP VALUES
(7782,'CLARK','MANAGER',7839,to_date('9-6-1981','dd-mm-yyyy'),2450,NULL,10);
INSERT INTO EMP VALUES
(7788,'SCOTT','ANALYST',7566,to_date('13-JUL-87')-85,3000,NULL,20);
INSERT INTO EMP VALUES
(7839,'KING','PRESIDENT',NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,10);
INSERT INTO EMP VALUES
(7844,'TURNER','SALESMAN',7698,to_date('8-9-1981','dd-mm-yyyy'),1500,0,30);
INSERT INTO EMP VALUES
(7876,'ADAMS','CLERK',7788,to_date('13-JUL-87')-51,1100,NULL,20);
INSERT INTO EMP VALUES
(7900,'JAMES','CLERK',7698,to_date('3-12-1981','dd-mm-yyyy'),950,NULL,30);
INSERT INTO EMP VALUES
(7902,'FORD','ANALYST',7566,to_date('3-12-1981','dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMP VALUES
(7934,'MILLER','CLERK',7782,to_date('23-1-1982','dd-mm-yyyy'),1300,NULL,10);
DROP TABLE BONUS;
CREATE TABLE BONUS
	(
	ENAME VARCHAR2(10)	,
	JOB VARCHAR2(9)  ,
	SAL NUMBER,
	COMM NUMBER
	) ;
DROP TABLE SALGRADE;
CREATE TABLE SALGRADE
      ( GRADE NUMBER,
	LOSAL NUMBER,
	HISAL NUMBER );
INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);
COMMIT;

SELECT * FROM EMP;
SELECT * FROM DEPT;
/* SELECT��
    SELECT �÷���1, �÷���2
    FROM ���̺��
    WHERE ����
*/
-- EMP ���̺��� ��� �÷�
SELECT * 
FROM EMP;
-- ������ȣ(EMPNO), �����̸�(ENAME) ��ȸ
SELECT EMPNO, ENAME 
FROM EMP;
-- �μ���ȣ�� 10���� �������� ��� ������ ��ȸ
SELECT * 
FROM EMP
WHERE DEPTNO = 10;
-- ����(JOB)�� 'SALESMAN'�� �������� ������ȣ(EMPNO), �̸�(ENAME), �޿�(SAL)�� ��ȸ
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE JOB = 'SALESMAN';

-- �μ���ȣ�� 10���� �ƴ� �������� ��� ������ ��ȸ
SELECT *
FROM EMP
WHERE DEPTNO != 10;
-- ����(JOB)�� 'SALESMAN'�� �ƴ� �������� ������ȣ(EMPNO), �̸�(ENAME), �޿�(SAL)�� ��ȸ
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE JOB != 'SALESMAN';

SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE NOT JOB = 'SALESMAN';

-- �޿�(SAL)�� 1500 �̻�,  2500 ������ �������� ��� ������ ��ȸ
SELECT *
FROM EMP
WHERE SAL >= 1500 AND SAL <= 2500;

SELECT *
FROM EMP
WHERE SAL BETWEEN 1500 AND 2500;

/* ���� ������ */
-- ����(JOB)�� 'SALESMAN'�� �������� ������ȣ(EMPNO), �̸�(ENAME), �޿�(SAL)�� ��ȸ
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE JOB = 'SALESMAN';
/* 
���ϵ� ���� : LIKE Ű����� �Բ� ���
1. _ : � ���̵� �ѱ��ڸ� ��ü ���ִ� ����
2. % : ���̿� ������� ��ü ���ִ� ����
*/
--  ����(JOB)�� 'SA  MAN'�� �������� ��� ���� ��ȸ
SELECT *
FROM EMP
WHERE JOB LIKE 'SA___MAN';
SELECT *
FROM EMP
WHERE JOB LIKE 'SA%MAN';
-- �����̸�(ENAME)�� �׹�° ���ڰ� 'K'�� �������� ��� ���� ��ȸ
SELECT *
FROM EMP
WHERE ENAME LIKE '___K%';
-- �����̸��� 4������ ���� ��ȸ
SELECT *
FROM EMP
WHERE ENAME LIKE '____';

/* ���� - NULL( NULL�񱳴� IS) */
-- COMM�� �޴� �ʴ� �������� ��� ������ ��ȸ(COMM �÷��� ���� NULL��)
SELECT *
FROM EMP
WHERE COMM IS NULL;
-- COMM�� �޴� �������� ��� ������ ��ȸ(COMM �÷��� ���� NULL�� �ƴ�)
SELECT *
FROM EMP
WHERE COMM IS NOT NULL;

/* ���� - ��¥�� */
-- �Ի���(HIREDATE)�� 1981�� 9�� 8���� ������ ��� ������ ��ȸ
SELECT *
FROM EMP
WHERE HIREDATE = '1981-09-08';
UPDATE EMP
SET HIREDATE = '1981-09-08 19:37'
WHERE EMPNO = 7844;
-- �Ի���(HIREDATE)�� 1981�� 9�� 8���� ������ ��� ������ ��ȸ -- 1981-09-08 19:37
/* TO_DATE : ���ڸ� ��¥��
   TO_CHAR : ��¥�� ���ڷ� */
SELECT *
FROM EMP
WHERE TO_CHAR(HIREDATE, 'YYYY-MM-DD') = '1981-09-08';
-- �Ի���(HIREDATE) 1981�� 9�� ������ �������� ��� ������ ��ȸ
SELECT *
FROM EMP
WHERE TO_CHAR(HIREDATE, 'YYYY-MM') >= '1981-09';

SELECT *
FROM EMP
WHERE HIREDATE >= TO_CHAR('1981-09', 'YYYY-MM');

-- �Ի���(HIREDATE) 12���� �������� ��� ������ ��ȸ
SELECT *
FROM EMP
WHERE TO_CHAR(HIREDATE, 'MM') = '12';

SELECT SYSDATE, SYSDATE - 1, SYSDATE+1, SYSDATE - 1/24 -- 1=�Ϸ� 1/24=1�ð� 
FROM DUAL;

/* ��Ī(ALIAS) */
--�÷��m AS ��Ī(ù��° ����� ����)
SELECT EMPNO AS ������ȣ, ENAME AS �����̸�, TO_CHAR(HIREDATE, 'YYYY-MM') AS HIREDATE
FROM EMP;
-- �÷��� AS "��Ī"
SELECT EMPNOAS AS "������ȣ", ENAME AS "�����̸�", TO_CHAR(HIREDATE, 'YYYY-MM') AS "HIREDATE"
FROM EMP;
-- �÷��� ��Ī
SELECT EMPNO ������ȣ, ENAME �����̸�, TO_CHAR(HIREDATE, 'YYYY-MM') HIREDATE
FROM EMP;
-- �÷��� "��Ī"
SELECT EMPNO "������ȣ", ENAME "�����̸�", TO_CHAR(HIREDATE, 'YYYY-MM') "HIREDATE"
FROM EMP;

/* ���� ���� */
SELECT ENAME, SAL||' �޷�' -- 800 �޷�
FROM EMP;

SELECT EMPNO||ENAME -- 7369SMITH
FROM EMP;

SELECT EMPNO||','||ENAME -- 7369,SMITH
FROM EMP;

SELECT TO_CHAR(HIREDATE, 'YYYY')||'��' -- 1980��
FROM EMP;

SELECT TO_CHAR(HIREDATE, 'YYYY')||'��'||TO_CHAR(HIREDATE, 'MM')||'��'||TO_CHAR(HIREDATE, 'DD')||'��' AS �Ի���
FROM EMP; -- 1980��12��17��

SELECT ENAME AS �����̸�, SAL AS ����, SAL * 12 AS ����
FROM EMP;


-----day06

-- WHERE - AND, OR
-- �Ի�⵵�� 1981�� �̰� �μ���ȣ�� 30���� �������� �̸���, ��å�� ��ȸ
SELECT ENAME, JOB
FROM EMP
WHERE TO_CHAR(HIREDATE, 'YYYY') = '1981' AND DEPTNO = 30;  -- 6��
-- �Ի�⵵�� 1981�� �̰ų� �μ���ȣ�� 20���� �������� �̸���, ��å�� ��ȸ
SELECT ENAME, JOB
FROM EMP
WHERE TO_CHAR(HIREDATE, 'YYYY') = '1981' OR DEPTNO = 20; -- 11��
-- ��å(JOB)�� 'MANAGER' �̰ų� 'SALESMAN'�� �������� ��� ������ ��ȸ
SELECT *
FROM EMP
WHERE  JOB = 'MANAGER' OR JOB = 'SALESMAN';
-- ��å(JOB)�� 'MANAGER' �̰ų� 'SALESMAN' 'ANALYST'�� �������� ��� ������ ��ȸ
SELECT *
FROM EMP
WHERE  JOB IN('MANAGER','SALESMAN', 'ANALYST'); -- JOB�ȿ� MANAGER, SALESMAN, ANALYST�� ������

-- ��å(JOB)�� 'MANAGER' �̰ų� 'SALESMAN' �� ������ �߿��� COMM�� ���� �ʴ� ������ ���� ��ȸ
SELECT *
FROM EMP
WHERE JOB = 'SALESMAN' OR JOB = 'MANAGER' AND COMM IS NULL; -- OR �������� ���ʿ� �ִ� �Ͱ� ������ ��ü�� ��
 --   JOB = 'SALESMAN' OR ( JOB = 'MANAGER' AND COMM IS NULL; )

SELECT *
FROM EMP
WHERE JOB = 'MANAGER' OR JOB = 'SALESMAN' AND COMM IS NULL; -- AND�� ()�� ���� ���ص��� OR�̸� ()����
 --   JOB = 'MANAGER' OR ( JOB = 'SALESMAN' AND COMM IS NULL; )
 
SELECT *
FROM EMP
WHERE (JOB = 'MANAGER' OR JOB = 'SALESMAN') AND COMM IS NULL;

SELECT *
FROM EMP
WHERE JOB IN('MANAGER', 'SALESMAN') AND COMM IS NULL;

-- ���̺�ȿ� �����ʹ� ��ҹ��� ���� �ؾߵ�
select *
from emp
where job = 'SALESMAN';
-- �빮�� ��ȯ : UPPER, �ҹ��� LOWER
select *
from emp
where job = 'salesman';
-- UPPER('���ڵ�����') >> �빮�ڷ� ��ȯ
select *
from emp
where job = UPPER('salesman');
-- LOWER('���ڵ�����') >> �ҹ��ڷ� ��ȯ
select *
from emp
where LOWER(job) = 'salesman';
-- LENGTH('����') >> ������ ����
SELECT ENAME, LENGTH(ENAME)
FROM EMP;

/* �׷� �Լ� 
   SUM, COUNT, MAX, MIN, AVG
*/
-- SUM() ������ ���ϴ� �Լ�
-- �������� SAL�� ����
SELECT SUM(SAL)
FROM EMP;
-- COUNT() ��ȸ�Ǵ� ���ڵ��� ����
SELECT COUNT(ENAME)
FROM EMP;
-- MAX() �ش� �÷��� �ִ밪 ���ϴ� �Լ�
SELECT MAX(SAL)
FROM EMP;
-- MIN() �ش� �÷��� �ҼҰ��� ���ϴ� �Լ�
SELECT MIN(SAL)
FROM EMP;
-- AVG() �ش� �÷��� ��հ��� ���ϴ� �Լ�
SELECT AVG(SAL)
FROM EMP;

-- ��� ������ �̸���, �޿��� ��ȸ
SELECT ENAME, SAL
FROM EMP;

-- �μ���ȣ �޿� ��ȸ
SELECT DEPTNO, SAL
FROM EMP;

-- �μ��� �޿��� ����
SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO;

-- ��å�� �޿��� ����
SELECT JOB, SUM(SAL)
FROM EMP
GROUP BY JOB;

-- �μ��� �ο���
SELECT DEPTNO, COUNT(*)
FROM EMP
GROUP BY DEPTNO;

-- 20�� �μ��� �ο��� ��ȸ
SELECT DEPTNO, COUNT(*)
FROM EMP
WHERE DEPTNO = 20 -- WHERE ���̺� ��ü�� �������
GROUP BY DEPTNO;

SELECT DEPTNO, COUNT(*)
FROM EMP
GROUP BY DEPTNO
HAVING DEPTNO = 20; -- HAVING ������ �׷��� ������� ����

/*
SELECT �÷���...
FROM ���̺��
WHERE ����(�ʿ��� ���ڵ常 ����)
GROUP BY �׷��� ���� �÷�
HAVING �׷� ����(�׷��� ����� ��ߵ�)
ORDER BY ���ɱ���
*/
-- �μ����� �׷��� �����ϰ�, �ο��� 4�� �̻��� �μ� ��ȸ
SELECT DEPTNO, COUNT(*)
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(*) >= 4;
-- ��å(JOB)�� ��� �޿�(SAL)�� 3000�̻��� ��å(JOB)�� ��� �޿�(AVG), �ο���(COUNT) ��ȸ
SELECT JOB, AVG(SAL), COUNT(*)
FROM EMP
GROUP BY JOB
HAVING AVG(SAL) >= 3000;

-- ��å(JOB)�� ��� �޿�(SAL)�� 3000�̻��� [��å(JOB)�� ��� �޿�(AVG), �ο���(COUNT) ��ȸ]
-- �� �μ��� 10, 30�� ������ �������
SELECT JOB, AVG(SAL), COUNT(*)
FROM EMP
WHERE DEPTNO IN(10,30)
GROUP BY JOB
HAVING AVG(SAL) >= 3000;

SELECT JOB, AVG(SAL), COUNT(*)
FROM EMP
GROUP BY JOB, DEPTNO
HAVING AVG(SAL) >= 3000 AND DEPTNO IN(10,30);

-- �ο����� 5���� �̻��� �μ��� �μ���ȣ, �ο���, ��տ��� ��ȸ
SELECT COUNT(*), DEPTNO, AVG(SAL*12)
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(*) >= 5;

SELECT ENAME, JOB, (SAL + COMM), SAL, COMM -- 800 + NULL = NULL
FROM EMP;
-- NVL(�÷���, ��ü�� ��)- NULL���� �ٸ� ������ ��ü
SELECT ENAME, JOB, (SAL + COMM), SAL, COMM, NVL(COMM, 0), (SAL+ NVL(COMM,0)) -- 800 + 0 = 800(NULL���� 0���� ��ü)
FROM EMP;

/* ORDER BY : ���ı���(���� ������ ������ ���) - ��������(ASC)-�⺻��, ��������(DESC) */
SELECT *
FROM EMP
ORDER BY ENAME; -- �����̸� ���� �������� ���� (�⺻��)

SELECT *
FROM EMP
ORDER BY ENAME DESC; -- �����̸� ���� �������� ���� (DESC �ʼ�)

SELECT *
FROM EMP
ORDER BY JOB DESC, SAL; -- ��å ���� �������� ���� (DESC �ʼ�)

/*
SELECT
FROM
WHERE
GROUP BY
HAVING
ORDER BY
*/
-- �̸��� WARD�� ������ ���� �μ����� �ٹ��ϴ� �������� ���� ��ȸ
-- 1. �̸��� WARD�� ������ �μ���ȣ ��ȸ -- DEPTNO :: 30
SELECT DEPTNO
FROM EMP
WHERE ENAME = 'WARD'; -- 30(�����)
-- 2. ��ȸ�� �μ���ȣ�� �������� �ش� �μ��� ���������� ��ȸ
-- ���� ���� : ������ �ȿ� �� �ٸ� �������� ���� ��
SELECT *
FROM EMP
WHERE DEPTNO = (SELECT DEPTNO
                FROM EMP
                WHERE ENAME = 'WARD');


-----day07

/* ��������(�� Ÿ�Կ� �����Ͱ� �������� ��� =��� IN�� ���) */
/* WHERE �� SELECT�� ��� 
   WHERE ��: Ư���� ���ڵ带 �����ϱ����� ����
*/
-- �μ���ȣ�� 10�� �������� ������ ��ȸ
SELECT *
FROM EMP
WHERE DEPTNO = 10;
-- �����̸��� KING�� ������ ���� �μ����� �ٹ��ϴ� �������� ������ ��ȸ
-- 1. �̸��� KING�� ������ �μ���ȣ ��ȸ
SELECT DEPTNO
FROM EMP
WHERE ENAME = 'KING'; -- 10
-- 2. 10�� �μ����� �ٹ��ϴ� �������� ������ ��ȸ
SELECT *
FROM EMP
WHERE DEPTNO = (SELECT DEPTNO
                FROM EMP
                WHERE ENAME = 'KING');

SELECT *
FROM EMP
WHERE DEPTNO IN (SELECT DEPTNO
                FROM EMP
                WHERE JOB = 'MANAGER');

-- ��� �޿����� ���� �޿��� �޴� �������� ������ ��ȸ
-- 1.��� �޿� ��ȸ
SELECT AVG(SAL)
FROM EMP; -- 2077.084
-- 2.��ȸ�� ��� �޿��� ������ �޿��� ��(�޿�(SAL)�� 2077���� ū ������)
SELECT *
FROM EMP
WHERE SAL >= (SELECT AVG(SAL)
              FROM EMP);
              
-- 'JONES'���� �޿��� ���� �޴� �������� ������ ��ȸ
-- 1.'JONES'�� SAL ��ȸ
SELECT SAL
FROM EMP
WHERE ENAME = 'JONES';

-- 2.��ȸ��'JONES'�� SAL���� ���� �޿��� �޴� �������� ������ ��ȸ
SELECT *
FROM EMP
WHERE SAL >= (SELECT SAL
              FROM EMP
              WHERE ENAME = 'JONES');

/* 'SALESMAN'�� �ٹ����� �ʴ� �μ��� �μ���ȣ�� �ο����� ��ȸ */
SELECT DEPTNO
FROM EMP
WHERE JOB = 'SALESMAN';

SELECT DEPTNO, COUNT(*)
FROM EMP
WHERE DEPTNO NOT IN (SELECT DEPTNO
                     FROM EMP
                     WHERE JOB = 'SALESMAN')
GROUP BY DEPTNO;

-- 'JAMES'�� ���� �޿� �Ի��� ������ �̸��� ���� �޿��� ��ȸ
--1.'JAMEW'�� �Ի��Ѵ�(MONTH) ��ȸ
SELECT TO_CHAR(HIREDATE, 'MM')
FROM EMP
WHERE ENAME = 'JAMES'; -- 12
--2.12���� �Ի��� ������ �̸� ���� �޿� 
SELECT ENAME, JOB, SAL
FROM EMP
WHERE TO_CHAR(HIREDATE, 'MM') = (SELECT TO_CHAR(HIREDATE, 'MM')
                                 FROM EMP
                                 WHERE ENAME = 'JAMES');

-- �μ��� ��� �޿��� 'MANAGER'�� ��� �޿� ���� ���� �μ��� ��ȣ�� ��ձ޿��� ��ȸ
--1.'MANAGER'�� ��� �޿�
SELECT AVG(SAL)
FROM EMP
WHERE JOB = 'MANAGER';
--2.�μ��� ��ձ޿� ��ȸ
SELECT DEPTNO, AVG(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING AVG(SAL) > (SELECT AVG(SAL)
                   FROM EMP
                   WHERE JOB = 'MANAGER');

/* JOIN : �� �� �̻��� ���̺��� �����Ͽ� �ϳ��� ���̺��ͷ� ����� ���
   INNER JOIN, OUTER JOIN
*/
SELECT *
FROM EMP, DEPT; -- 48���� ���ڵ�(������ �Ǵ� ���̺��� ���ڵ���� �� ���� ������ ������ �߸���ų� ���°�)
SELECT * FROM EMP;  -- 12���� ���ڵ�
SELECT * FROM DEPT; -- 4���� ���ڵ�
-- WHERE���� ������ ���� ���ǰ� ���ڵ带 �����ϱ� ���� ������ ���� ���� ���
SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.ENAME = 'SMITH';

-- FROM���� ������ ���� ������ ���� ���
SELECT *
FROM EMP INNER JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO
WHERE EMP.ENAME = 'SMITH';
-- ���̺�� ��Ī(FROM���� ������ �׾ƺ���� ��Ī���� �����)-SQL�� ���α׷��� ������ FROM���� ����
SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
SELECT *
FROM EMP E INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO;

SELECT ENAME, DNAME, D.DEPTNO, E.DEPTNO
FROM EMP E INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO;

-- 'SMITH'�� �ٹ��ϴ� �μ��� �̸�, ���� ��ȸ
-- ����
SELECT DEPT.DEPTNO, DEPT.LOC
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO AND ENAME = 'SMITH';

SELECT DEPT.DEPTNO, DEPT.LOC
FROM EMP INNER JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO
WHERE EMP.ENAME = 'SMITH';
-- ����������
SELECT DEPTNO, LOC
FROM DEPT
WHERE DEPTNO = (SELECT DEPTNO FROM EMP WHERE ENAME = 'SMITH');

-- 'NEW YORK'���� �ٹ��ϴ� ������ �μ��̸�, �����̸�, ��å ��ȸ
SELECT DEPT.DNAME, EMP.ENAME, EMP.JOB
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO AND DEPT.LOC = 'NEW YORK';

SELECT DEPT.DNAME, EMP.ENAME, EMP.JOB
FROM EMP INNER JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO
WHERE DEPT.LOC = 'NEW YORK';

-- 'SMITH' ������ �����(MGR)�� �̸� ��ȸ
SELECT ENAME 
FROM EMP
WHERE EMPNO = (SELECT MGR FROM EMP WHERE ENAME='SMITH');

SELECT E1.ENAME ||'�� MGR��'||E2.ENAME ||'�Դϴ�'
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO; -- EMP.E1-7902 = EMP.E2-7902

/*
|| �μ��̸� ||  ����  || ������ ||
  RESEARCH   DALLAS     3
  SALES      CHICAGO    6
*/
-- �μ��� ������ ��ȸ
SELECT DEPTNO, COUNT(*)
FROM EMP
GROUP BY DEPTNO;
-- SELECT������ ���� ������� �ϳ��� ���̺�� Ȱ��
SELECT D.DNAME, D.LOC, COUNT_E.EMPCOUNT
FROM DEPT D, (SELECT DEPTNO, COUNT(*) AS EMPCOUNT FROM EMP GROUP BY DEPTNO) COUNT_E
WHERE D.DEPTNO = COUNT_E.DEPTNO;


-----day08

--�μ��� ��� �޿� ��ȸ (�μ��̸�, ��ձ޿�)
SELECT D.DNAME, AVG(E.SAL)
FROM EMP E INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
GROUP BY D.DNAME;

SELECT DEPTNO, AVG(SAL)
FROM EMP
GROUP BY DEPTNO;

-- �����̸�, �޿�, �μ��� ���
-- SMITH   800    2258
-- ALLEN   1600   1566

--1. EMP �μ��� ��� �޿� ��ȸ
SELECT DEPTNO, AVG(SAL)
FROM EMP
GROUP BY DEPTNO;
--2. EMP���̺�� 1���� SELECT�� ����� ����
SELECT E1.ENAME, E1.SAL, E2.DEPTNO, E2.DEPTAVG
FROM EMP E1 INNER JOIN (SELECT DEPTNO, AVG(SAL) AS DEPTAVG FROM EMP GROUP BY DEPTNO) E2 ON E1.DEPTNO = E2.DEPTNO;
--WHERE E1.ENAME = 'SMITH';

--3. DEPTNO ��� ENAME(�μ��̸�)���� ���
SELECT E1.ENAME, E1.SAL, E2.DEPTAVG
FROM EMP E1 INNER JOIN (SELECT DEPTNO, AVG(SAL) AS DEPTAVG FROM EMP GROUP BY DEPTNO) E2 
                        ON E1.DEPTNO = E2.DEPTNO INNER JOIN DEPT D ON E1.DEPTNO = D.DEPTNO;
                        
-- �����̸�(ENAME), ����(JOB), ������ �ο���
--1. ������ �ο��� ��ȸ
SELECT JOB, COUNT(*)
FROM EMP
GROUP BY JOB;
--2. EMP���̺� 1�� ����� ����
SELECT E1.ENAME, E1.JOB, E2.JCOUNT
FROM EMP E1, (SELECT JOB, COUNT(*) AS JCOUNT FROM EMP GROUP BY JOB) E2
WHERE E1.JOB = E2.JOB;

-- ROWNUM
SELECT ROWNUM, EMP.*
FROM EMP;

--1.
SELECT ROWNUM AS SALRANK, EMP.*
FROM EMP
ORDER BY SAL DESC;

--2.
SELECT ROWNUM AS SALRANK, EMP.*
FROM (SELECT * FROM EMP ORDER BY SAL DESC) EMP;

--3.
SELECT *
FROM (SELECT ROWNUM AS SALRANK, EMP.* FROM (SELECT * FROM EMP ORDER BY SAL DESC) EMP)
WHERE ENAME = 'SMITH'; -- SMITH�� SAL����

-- VIEW(�������̺�)
-- CREATE VIEW
CREATE OR REPLACE VIEW SALRANK_EMP
AS ( SELECT ROWNUM AS SALRANK, EMP.* 
     FROM (SELECT * FROM EMP ORDER BY SAL DESC) EMP ); -- 3.

SELECT *
FROM SALRANK_EMP
WHERE ENAME = 'SMITH';
;

/*
UPDATE ���̺��
SET �÷��� = ������ ��
WHERE �����͸� ������ ���ڵ�
*/
--JAMES'�� �޿��� 1000���� ����(WHERE���� �ٲܰ� ����-���ϸ� ��簪 �ٲ�)
UPDATE EMP
SET SAL = 1000
WHERE ENAME = 'JAMES';

--JAMES'�� �޿��� 100 ����
UPDATE EMP
SET SAL = SAL + 100
WHERE ENAME = 'JAMES';
SELECT * FROM EMP;

-- MGR �� 'BLAKE'�� �������� �޿��� 200����
UPDATE EMP
SET SAL = SAL + 200
WHERE MGR = (SELECT EMPNO FROM EMP WHERE ENAME = 'BLAKE');

SELECT *
FROM SALRANK_EMP;

-- DELETE
/*
DELETE FROM ���̺��
WHERE ������ ���ڵ带 ����
*/
-- �޿��� ���� ���� �޴� ������ �ٹ��ϴ� �μ��� �������� ��� ����
--1. �޿��� �ּҰ�(MIN(SAL)) ��ȸ : 800
SELECT MIN(SAL)
FROM EMP;
--2. �޿��� MIN(SAL)�� ������ �μ���ȣ ��ȸ : 20
SELECT DEPTNO
FROM EMP
WHERE SAL = (SELECT MIN(SAL) FROM EMP);

--3. �ش� �μ��� �������� ����
DELETE FROM EMP
WHERE DEPTNO = (SELECT DEPTNO
                FROM EMP
                WHERE SAL = (SELECT MIN(SAL) FROM EMP));
SELECT * FROM EMP;
ROLLBACK;

-- 'ALLEN'�� �μ���ȣ�� 50������ ����
UPDATE EMP
SET DEPTNO = 50
WHERE ENAME = 'ALLEN'; 
-- ORA-02291: ���Ἲ ��������(JGH_DBA.FK_DEPTNO)�� ����Ǿ����ϴ�- �θ� Ű�� �����ϴ�
SELECT * FROM DEPT; -- EMP�� DEPTNO�� DEPT�� DEOTNO�� �����ϰ� �־ ����(DEOTNO = 10,20,30,40)

DELETE FROM DEPT
WHERE DEPTNO = 30;
-- ORA-02292: ���Ἲ ��������(JGH_DBA.FK_DEPTNO)�� ����Ǿ����ϴ�- �ڽ� ���ڵ尡 �߰ߵǾ����ϴ�


-----day09

/* ���θ�(ȸ��, ��ǰ, �ֹ�����) */
/* ȸ������ �׾ƺ�(MEMBERS) */
SELECT * FROM USER_TABLES; -- ���� �������� ������ �ִ� ���̺�
SELECT * FROM USER_CONSTRAINTS; -- ���� �������� ������ �ִ� ��������

DROP TABLE LOGINCHECK;
DROP TABLE MEMBERS;
CREATE TABLE MEMBERS(
    MID NVARCHAR2(10),      -- ȸ�� ���̵�(PRIMARY KEY)
    MPW NVARCHAR2(20),      -- ȸ�� ��й�ȣ(NOT NULL)
    MNAME NVARCHAR2(5),     -- ȸ�� �̸�(NOT NULL)
    MPHONE NVARCHAR2(13),   -- ȸ�� ��ȭ��ȣ
    MBIRTH DATE             -- ȸ�� �������
);
-- ���� ���� �ο�
ALTER TABLE MEMBERS
ADD CONSTRAINT PK_MEM_MID PRIMARY KEY (MID)
MODIFY MPW NOT NULL
MODIFY MNAME NOT NULL;
DESC MEMBERS;

/* ��ǰ���� ���̺�(GOODS) */
/* ��ǰ�ڵ�, ��ǰ�̸�, ��ǰ����, ��ǰ����, ��ǰ��� */
DROP TABLE GOODS;
CREATE TABLE GOODS(
    GCODE NVARCHAR2(5),     -- ��ǰ�ڵ�(PRIMARY KEY)
    GNAME NVARCHAR2(30),    -- ��ǰ�̸�(NOT NULL)
    GPRICE NUMBER,          -- ��ǰ����(DEFAULT 1000)
    GTYPE NVARCHAR2(10),    -- ��ǰ����
    GSTOCK NUMBER           -- ��ǰ���
);
ALTER TABLE GOODS
ADD CONSTRAINT PK_GOO_GCODE PRIMARY KEY (GCODE)
MODIFY GNAME NOT NULL
MODIFY GPRICE DEFAULT 1000;
DESC GOODS;

/* CHECK ����
1. GCODE �÷��� ���ڼ� ����(������ 5����)
2. GCODE �÷��� ù���ڴ� 'G'�� �����ϵ��� ����
3. GSTOCK �÷��� 0�̸��� ���� �Է��� �� ������ ����
*/
SELECT LENGTH('ABCD')FROM DUAL;
SELECT SUBSTR('ABCDEFGH', 1.1) FROM DUAL;

ALTER TABLE GOODS
ADD CONSTRAINT CK_GCODE_LTH CHECK(LENGTH(GCODE) = 5);
ALTER TABLE GOODS
ADD CONSTRAINT CK_GCODE_FIRST CHECK(SUBSTR(GCODE, 1,1) = 'G');
ALTER TABLE GOODS
ADD CONSTRAINT CK_GSTOCK CHECK(GSTOCK >= 0);
COMMIT;

/* �ֹ�����(ORDERS) 
    �ֹ��ڵ�(PK), ȸ�����̵�(FK-MEMBER(MID)), ��ǰ�ڵ�(FK-GOODS(GCODE)), �ֹ�����, �ֹ��Ͻ�
*/
CREATE TABLE ORDERS(
    ODCODE NVARCHAR2(5),    -- �ֹ��ڵ�(PRIMARY KEY)
    ODMID NVARCHAR2(10),    -- �ֹ��ھ��̵�(FOREIGN KEY-MEMBERS(MID))
    ODGCODE NVARCHAR2(5),   -- �ֹ���ǰ(FOREIGN KEY-GOODS(GCODE))
    ODQTY NUMBER,           -- �ֹ�����
    ODDATE DATE             -- �ֹ��Ͻ�
);
ALTER TABLE ORDERS
ADD CONSTRAINT PK_ORDERS PRIMARY KEY(ODCODE);
ALTER TABLE ORDERS
ADD CONSTRAINT FK_ORDERS_MID FOREIGN KEY(ODMID) REFERENCES MEMBERS(MID);
ALTER TABLE ORDERS
ADD CONSTRAINT FK_ORDERS_GCODE FOREIGN KEY(ODGCODE) REFERENCES GOODS(GCODE);

INSERT INTO MEMBERS(MID, MPW, MNAME, MPHONE, MBIRTH)
VALUES ('JGH','1234','����ȣ','010-4904-3741','2001-11-09');
INSERT INTO GOODS(GCODE, GNAME, GPRICE, GTYPE, GSTOCK)
VALUES ('G3000','�Ƹ޸�ī��', 3000, '��ǰ', 30);
COMMIT;
SELECT * FROM MEMBERS;
SELECT * FROM GOODS;

/* ���θ�
1. ȸ����� - ȸ������, �α��α��, ������Ȯ��, 
            ���ֹ�����
2. ��ǰ��� - ��ü��ǰ���, ��������ǰ���
             ��ǰ�ֹ���� */
/* [ȸ�����Ա��]
CONSOLE(SCANNER) >> ������ ���̵� ~ ������� �Է� */
INSERT INTO MEMBERS(MID, MPW, MNAME, MPHONE, MBIRTH)
VALUES('�Է��Ѿ��̵�', '�Է��Ѻ�й�ȣ', '�Է����̸�', '�Է�����ȭ��ȣ', TO DATE('�Է��ѻ������','YYYY-MM-DD')); -- ȸ������
/* [�α��α��] 
CONSOLE(SCANNER) >> �α����� ���̵�, �α����� ��й�ȣ >> �Է�
*/
SELECT *
FROM MEMBERS
WHERE MID = '�α����Ҿ��̵�' AND MPW = '�α����Һ�й�ȣ';
-- ���ڵ尡 ��ȸ�Ǹ� >> �α��� ó��
-- ���ڵ尡 ��ȸ���� ������ >> ���̵�/��й�ȣ�� ��ġ���� �ʽ��ϴ�.

/* [������Ȯ�α��] - �α��� ���� ���� */
SELECT *
FROM MEMBERS
WHERE MID = '�α������ξ��̵�';

/* [���ֹ����]��� - �α��� ���� ���� 
��ǰ�̸�(GOODS-GNAME), �ֹ�����(ORDERS-ODQTY), �ֹ��ݾ�(GPRICE * ODQTY), �ֹ���(ORDER - ODDATE)
���� - ODMID = '�α��� ���� ���̵�'
*/


-----day10

/* [��ü��ǰ���] ��� 
��ǰ�̸�, ��ǰ����, ���, ����
*/
SELECT *
FROM GOODS -- ��ü��ǰ���
WHERE GSTOCK > 0; -- �ǸŰ� ������ ��ǰ���(��� 0�� �ƴѰ�) 
--ORDER BY GSTOCK DESC;
/* [��������ǰ���] ������ ���� '��ǰ' ��� */
SELECT *
FROM GOODS
WHERE GTYPE = '��ǰ' AND GSTOCK > 0;

/* [��ǰ�ֹ�]��� - �ٳ������� ��ǰ ����, 5���� ���� */
--1. ORDERS ���̺� INSERT
INSERT INTO ORDERS(ODCODE, ODMID, ODGCODE, ODQTY, ODDATE)
VALUES ('O0001','JGH', 'G0115', 5, SYSDATE); --1 �� ��(��) ���ԵǾ����ϴ�.
--2. GOODS ���̺� UPPDATE
UPDATE GOODS
SET GSTOCK = GSTOCK - 5
WHERE GCODE = 'G0115'; --1 �� ��(��) ������Ʈ�Ǿ����ϴ�.
COMMIT;
SELECT * FROM MEMBERS;
SELECT * FROM GOODS;
SELECT * FROM ORDERS;

/* [��ǰ�ֹ�]��� - G3000 ��ǰ ����, 1���� ���� */
--1. ORDERS ���̺� INSERT
INSERT INTO ORDERS(ODCODE, ODMID, ODGCODE, ODQTY, ODDATE)
VALUES ('O0002','JGH', 'G3000', 1, SYSDATE);
--2. GOODS ���̺� UPPDATE
UPDATE GOODS
SET GSTOCK = GSTOCK - 1
WHERE GCODE = 'G3000';

/* [��ǰ�ֹ�]��� - G1357 ��ǰ ����, 3���� ���� */
--1. ORDERS ���̺� INSERT
INSERT INTO ORDERS(ODCODE, ODMID, ODGCODE, ODQTY, ODDATE)
VALUES ('O0003','YKD', 'G1357', 3, SYSDATE);
--2. GOODS ���̺� UPPDATE
UPDATE GOODS
SET GSTOCK = GSTOCK - 3
WHERE GCODE = 'G1357';

/* [��ǰ�ֹ�]��� - G1234 ��ǰ ����, 1���� ���� */
--1. ORDERS ���̺� INSERT
INSERT INTO ORDERS(ODCODE, ODMID, ODGCODE, ODQTY, ODDATE)
VALUES ('O0004','GDH', 'G1234', 1, SYSDATE);
--2. GOODS ���̺� UPPDATE
UPDATE GOODS
SET GSTOCK = GSTOCK - 1
WHERE GCODE = 'G1234';

/* [��ǰ�ֹ�]��� - G2468 ��ǰ ����, 10���� ���� */
--1. ORDERS ���̺� INSERT
INSERT INTO ORDERS(ODCODE, ODMID, ODGCODE, ODQTY, ODDATE)
VALUES ('O0005','PYJ', 'G2468', 10, SYSDATE);
--2. GOODS ���̺� UPPDATE
UPDATE GOODS
SET GSTOCK = GSTOCK - 10
WHERE GCODE = 'G2468';

/* [�ֹ�������ȸ] ��� 
[�ֹ����̸�][��ǰ�̸�][��ǰ����][�ֹ�����][���ֹ��ݾ�][�ֹ��Ͻ�]
*/
/*
SELECT
FROM ���̺�A, ���̺�B, ���̺�C
WHERE ��������
*/
SELECT MNAME, GNAME, GPRICE, ODQTY, GPRICE*ODQTY, ODDATE
FROM MEMBERS M, GOODS G, ORDERS O
WHERE M.MID = O.ODMID AND G.GCODE = O.ODGCODE AND O.ODMID = 'JGH';

/*
SELECT
FROM ���̺�A INNER JOIN ���̺�B IN �������� INNER JOIN ���̺�C ON ��������
*/
SELECT MNAME, GNAME, GPRICE, ODQTY, GPRICE*ODQTY, ODDATE
FROM MEMBERS M INNER JOIN ORDERS O ON M.MID = O.ODMID INNER JOIN GOODS G ON G.GCODE = O.ODGCODE
WHERE O.ODMID = 'JGH';

/* [��������ǰ���] ������ ���� '��ǰ' ��� - ������ ���� �� */
SELECT *
FROM GOODS
WHERE GTYPE = '��ǰ' AND GSTOCK > 0
ORDER BY GPRICE;
-- �ֹ��ݾ��� ���� ���� ȸ�� ������ ����  - ȸ�����̵�, �ѱ��ž׼�
SELECT O.ODMID, SUM(O.ODQTY*G.GPRICE) AS TOTALPRICE
FROM ORDERS O, GOODS G
WHERE O.ODGCODE = G.GCODE
GROUP BY O.ODMID
ORDER BY TOTALPRICE DESC;

-- �ֹ� ���� ���� ���� ȸ�� ������ ���� - ȸ�����̵�, ���ֹ���
SELECT ODMID, COUNT(*) AS TOTALORDERS
FROM ORDERS
GROUP BY ODMID
ORDER BY TOTALORDERS DESC;

SELECT *
FROM MEMBERS M,(SELECT ODMID, COUNT(*) AS TOTALORDERS
                FROM ORDERS
                GROUP BY ODMID
                ORDER BY TOTALORDERS DESC)OD
WHERE M.MID = OD.ODMID;

SELECT *
FROM MEMBERS M INNER JOIN (SELECT ODMID, COUNT(*) AS TOTALORDERS
                           FROM ORDERS
                           GROUP BY ODMID)OD
ON M.MID = OD.ODMID;

/* OUTER JOIN */
SELECT *
FROM MEMBERS M INNER JOIN ORDERS OD ON M.MID = OD.ODMID;

SELECT *
FROM MEMBERS M LEFT OUTER JOIN ORDERS OD ON M.MID = OD.ODMID; -- ���ʱ���(MEMBERS)-24�� ���ڵ�

SELECT *
FROM MEMBERS M RIGHT OUTER JOIN ORDERS OD ON M.MID = OD.ODMID; -- �����ʱ���(ORDERS)-5�� ���ڵ�

/* �ֹ� ���� ���� ���� ȸ�� ������ ����(�ֹ��� ȸ����) */
SELECT *
FROM MEMBERS M INNER JOIN (SELECT ODMID, COUNT(*) AS TOTALORDERS
                           FROM ORDERS
                           GROUP BY ODMID)OD ON M.MID = OD.ODMID;
/* �ֹ� ���� ���� ���� ȸ�� ������ ����(�ֹ����� ���� ȸ������) */
SELECT *
FROM MEMBERS M LEFT OUTER JOIN (SELECT ODMID, COUNT(*) AS TOTALORDERS
                           FROM ORDERS
                           GROUP BY ODMID)OD ON M.MID = OD.ODMID
ORDER BY OD. TOTALORDERS;

-- �Ǹŷ��� ���� ��(�α���ǰ)
--1. ORDERS
SELECT ODGCODE, SUM(ODQTY) AS TOTALQTY
FROM ORDERS
GROUP BY ODGCODE;
--2
SELECT *
FROM GOODS G INNER JOIN (SELECT ODGCODE, SUM(ODQTY) AS TOTALQTY
                         FROM ORDERS
                         GROUP BY ODGCODE) OD
            ON G.GCODE = OD.ODGCODE
ORDER BY OD.TOTALQTY; -- �Ǹ� ������ �ִ� ��ǰ��

SELECT G.*, NVL(OD.TOTALQTY,0) -- NULL���� 0���� ��ü
FROM GOODS G LEFT OUTER JOIN (SELECT ODGCODE, SUM(ODQTY) AS TOTALQTY
                         FROM ORDERS
                         GROUP BY ODGCODE) OD
            ON G.GCODE = OD.ODGCODE
ORDER BY NVL(OD.TOTALQTY,0) DESC; -- �Ǹ� ������ ���� ��ǰ����



-----day11
/* INNER JOIN  */
SELECT *
FROM ORDERS OD INNER JOIN MEMBERS M ON M.MID = OD.ODMID;

SELECT *
FROM MEMBERS M INNER JOIN ORDERS OD ON M.MID = OD.ODMID;

/* OUTER JOIN, ORDERS, MEMBERS */

SELECT *
FROM ORDERS OD LEFT OUTER JOIN MEMBERS M ON M.MID = OD.ODMID;

SELECT *
FROM MEMBERS M LEFT OUTER JOIN ORDERS OD ON M.MID = OD.ODMID;

SELECT *
FROM ORDERS OD RIGHT OUTER JOIN MEMBERS M ON M.MID = OD.ODMID;

SELECT *
FROM MEMBERS M RIGHT OUTER JOIN ORDERS OD ON M.MID = OD.ODMID;

SELECT *
FROM ORDERS OD FULL OUTER JOIN MEMBERS M ON M.MID = OD.ODMID;

SELECT *
FROM MEMBERS M FULL OUTER JOIN ORDERS OD ON M.MID = OD.ODMID;

/* �Ǹŷ��� ���������� �����ؼ� ��ǰ ����� �����ּ��� */
--1. � ��ǰ�� ��ŭ �ǸŰ� �Ǿ����� ��ȸ - ORDERS
SELECT ODGCODE, SUM(ODQTY)
FROM ORDERS
GROUP BY ODGCODE;

--2. ��ǰ�k �Ǹŷ� ���ɷ� ����
SELECT *
FROM GOODS G INNER JOIN (SELECT ODGCODE, SUM(ODQTY)
                         FROM ORDERS
                         GROUP BY ODGCODE) OD
             ON G.GCODE = OD.ODGCODE;

SELECT *
FROM GOODS G LEFT OUTER JOIN (SELECT ODGCODE, SUM(ODQTY) AS TOTALQTY
                              FROM ORDERS
                              GROUP BY ODGCODE) OD
             ON G.GCODE = OD.ODGCODE
ORDER BY NVL(OD.TOTALQTY,0) DESC;
             
SELECT G.*, NVL(OD.TOTALQTY,0) AS TOTALQTY
FROM GOODS G LEFT OUTER JOIN (SELECT ODGCODE, SUM(ODQTY) AS TOTALQTY
                              FROM ORDERS
                              GROUP BY ODGCODE) OD
             ON G.GCODE = OD.ODGCODE
ORDER BY TOTALQTY DESC;

SELECT G.*, NVL(OD.TOTALQTY,0) AS TOTALQTY
FROM GOODS G LEFT OUTER JOIN (SELECT ODGCODE, SUM(ODQTY) AS TOTALQTY
                              FROM ORDERS
                              GROUP BY ODGCODE) OD
             ON G.GCODE = OD.ODGCODE
ORDER BY TOTALQTY DESC, G.GPRICE;

/* ������� ���� ���� ��ǰ ������ ���� */
--1. ��ǰ�� ����� ��ȸ - ORDERS.ODQTY * GOODS.GPRICE
SELECT OD.ODGCODE, SUM(OD.ODQTY*G.GRPRICE) AS TOTALPRICE
FROM ORDERS OD, GOODS G
WHERE OD.ODGCODE = G.GCDE
GROUP BY OD.ODGCODE;

--2. ��ǰ�� ����� ������ ����
SELECT G.*, NVL(OD.TOTALPRICE,0) AS TOTALPRICE
FROM GOODS G LEFT OUTER JOIN (SELECT OD.ODGCODE, SUM(OD.ODQTY*G.GPRICE) AS TOTALPRICE
                              FROM ORDERS OD, GOODS G
                              WHERE OD.ODGCODE = G.GCODE
                              GROUP BY OD.ODGCODE) OD
            ON G.GCODE = OD.ODGCODE
ORDER BY TOTALPRICE DESC;

SELECT ROWNUM, G.*
FROM (SELECT G.*, NVL(OD.TOTALPRICE,0) AS TOTALPRICE
      FROM GOODS G LEFT OUTER JOIN (SELECT OD.ODGCODE, SUM(OD.ODQTY*G.GPRICE) AS TOTALPRICE
                              FROM ORDERS OD, GOODS G
                              WHERE OD.ODGCODE = G.GCODE
                              GROUP BY OD.ODGCODE) OD
            ON G.GCODE = OD.ODGCODE
      ORDER BY TOTALPRICE DESC) G; -- 

-- ROWNUM
SELECT ROWNUM, GOODS.*
FROM GOODS;

SELECT ROWNUM, GOODS.*
FROM GOODS
ORDER BY GPRICE DESC;

SELECT GOODS.*
FROM GOODS
ORDER BY GPRICE DESC; -- GPRICE�� �������� ����

SELECT ROWNUM RN, GOODS.*
FROM (SELECT GOODS.*
      FROM GOODS
      ORDER BY GPRICE DESC) GOODS; -- GPRICE�� �������� �����Ѱ��� ���������� ���� ROWNUM�� �̿��� ���������� ������� ��ȣ�� �־��ش�(�׷� ���� ��Ѱͺ��� ������ ������ �� �ִ�)

SELECT ROWNUM RN, GOODS.*
FROM (SELECT GOODS.*
      FROM GOODS
      ORDER BY GPRICE DESC) GOODS
WHERE ROWNUM BETWEEN 11 AND 20; -- ���ڵ尡 �ȳ���

SELECT *
FROM(SELECT ROWNUM RN, GOODS.*
     FROM (SELECT GOODS.*
     FROM GOODS
     ORDER BY GPRICE DESC) GOODS)
WHERE RN BETWEEN 11 AND 20; -- GPRICE�� ROWNUM�� 11~20������ ��ȸ

-- ��ǰ�� ����� ������ �����ϰ� ���� ������ ���� ��������
SELECT ROWNUM AS RK, G.*
FROM (SELECT G.*, NVL(OD.TOTALPRICE,0) AS TOTALPRICE
      FROM GOODS G LEFT OUTER JOIN (SELECT OD.ODGCODE, SUM(OD.ODQTY*G.GPRICE) AS TOTALPRICE
                              FROM ORDERS OD, GOODS G
                              WHERE OD.ODGCODE = G.GCODE
                              GROUP BY OD.ODGCODE) OD
            ON G.GCODE = OD.ODGCODE
      ORDER BY TOTALPRICE DESC) G;

-- ��ǰ�� ����� ������ ������ ���� �並 �̿뿡 �ϳ��� ������ ���̺�� ���� �������� �� ���� �ۼ��� �� �ִ�
CREATE VIEW SALESRK
AS (SELECT ROWNUM AS RK, G.*
FROM (SELECT G.*, NVL(OD.TOTALPRICE,0) AS TOTALPRICE
      FROM GOODS G LEFT OUTER JOIN (SELECT OD.ODGCODE, SUM(OD.ODQTY*G.GPRICE) AS TOTALPRICE
                              FROM ORDERS OD, GOODS G
                              WHERE OD.ODGCODE = G.GCODE
                              GROUP BY OD.ODGCODE) OD
            ON G.GCODE = OD.ODGCODE
      ORDER BY TOTALPRICE DESC) G);

SELECT *
FROM SALESRK
WHERE RK BETWEEN 2 AND 5;

/* �������̺�(VIEW)
CREATE VIEW -- ����
CREATE OR REPLACE VIEW - ����?
*/
CREATE OR REPLACE VIEW TESTVIEW1
AS (SELECT GCODE, GNAME FROM GOODS)
WITH READ ONLY; -- �б�����(��ȸ�� ����)

CREATE OR REPLACE VIEW TESTVIEW1
AS (SELECT GCODE, GNAME FROM GOODS);

CREATE OR REPLACE VIEW TESTVIEW1
AS (SELECT * FROM GOODS G INNER JOIN ORDERS OD ON G.GCODE = OD.ODGCODE);

SELECT *
FROM TESTVIEW1;

UPDATE GOODS
SET GNAME = 'BANANAMILK'
WHERE GCODE = 'G0115';

UPDATE GOODS
SET GNAME = '�ٳ�������'
WHERE GCODE = 'G0115';

/* ORDERS, GOODS, MEMBERS ���̺��� INNER JOIN �� VIEW ���� */
SELECT * FROM ORDERS;
SELECT * FROM GOODS;
SELECT * FROM MEMBERS;

CREATE OR REPLACE VIEW SALESVIEW
AS (SELECT *
    FROM ORDERS OD INNER JOIN GOODS G 
                   ON OD.ODGCODE = G.GCODE 
                   INNER JOIN MEMBERS M 
                   ON M.MID = OD.ODMID);

SELECT * FROM SALESVIEW;

SELECT GNAME, MNAME
FROM SALESVIEW
WHERE TO_CHAR(ODDATE, 'YYYY-MM-DD') = '2023-06-01';


-----day12

-- DB12.sql


-----day13

/* ORACLE - ���� �Լ�
TO_CHAR() - ��¥�� >> ������
TO_DATE() - ������ >> ��¥��
UPPER() - ��� �빮�ڷ� ����
LOWER() - ��� �ҹ��ڷ� ����
*/
SELECT UPPER('student'), LOWER('STUDENT')
FROM DUAL;

SELECT *
FROM EMP
WHERE ENAME = 'ALLEN';

SELECT *
FROM EMP
WHERE ENAME = 'allen';

SELECT *
FROM EMP
WHERE UPPER(ENAME) = UPPER('allen');

SELECT *
FROM EMP
WHERE LOWER(ENAME) = LOWER('allen');

-- INITCAP() : ù���ڸ� �빮�ڷ�, �������� �ҹ��ڷ�
SELECT INITCAP('STUDENT'), INITCAP('student'), INITCAP('stUDent')
FROM DUAL;

-- LENCTH() : ���ڿ��� ���̸� Ȯ��
SELECT LENGTH('STUDENT') FROM DUAL;
SELECT ENAME, LENGTH(ENAME) 
FROM EMP;

SELECT MID, LENGTH(MID) 
FROM MEMBERS;

-- LENGTHB() : ������ BYTE Ȯ��
SELECT LENGTH('STUDENT'), LENGTHB('STUDENT') FROM DUAL;
SELECT LENGTH('�л�'), LENGTHB('�л�'), LENGTH('��'), LENGTHB(��') FROM DUAL;

-- SUBSTR(������������, ������ġ, ���ڼ�) : ���ڿ��� �Ϻθ� ����

SELECT SUBSTR('STUDENT', 1), SUBSTR('STUDENT', 3)
FROM DUAL;
SELECT SUBSTR('STUDENT', 3, 2) -- UD
FROM DUAL;
SELECT SUBSTR(ENAME, 2), SUBSTR(ENAME, 2,2)
FROM EMP;

-- INSTR('������������','ã������', '������ġ')
SELECT INSTR('STUDENAT', 'T'), INSTR('STUDENAT', 'T',3)
FROM DUAL;

SELECT INSTR('STUDENAT', 'DEN'), INSTR('STUDENAT', 'Z'), INSTR('STUDENAT', 'SUT')
FROM DUAL;

-- REPLACE('������������', '�����','�����ҹ���') : Ư�� ���ڸ� �ٲٴ� �Լ�
SELECT REPLACE('010-1111-2222', '-', '*')
FROM DUAL;
SELECT ENAME, REPLACE(ENAME, 'A', '����')
FROM EMP;
SELECT ENAME, REPLACE(ENAME, 'A','')
FROM EMP;

-- LPAD(������������, ��ü���ڼ�, 'ä���ٹ���')
-- RPAD()

SELECT LPAD('STU', 10, '-'), RPAD('STU',10,'-')
FROM DUAL;

SELECT LPAD('STUDENT', 5, '-'), RPAD('STU',10,'-')
FROM DUAL;

-- '230607-3456789' ��ȸ ���>> '230607-3*******' ���
SELECT '230607-3456789', RPAD('230607-3',14,'*')
FROM DUAL;
SELECT '230607-3456789', RPAD( SUBSTR('230607-3456789',1,8),14,'*')
FROM DUAL;

-- '������' >> '��*��'(�̸�)
SELECT MNAME
FROM MEMBERS;
SELECT MNAME, REPLACE(MNAME, SUBSTR(MNAME,2,1), '*')
FROM MEMBERS;


-----day14
/* ���� �Լ� */
-- ���밪
SELECT ABS(5), ABS(-10) FROM DUAL;

-- �ݿø� : ROUND(����, �Ҽ����ڸ���)
SELECT 1234.5678, ROUND(1234.5678), ROUND(1234.5678, 0), ROUND(1234.5678, 1) FROM DUAL;
SELECT 1234.5678, ROUND(1234.5678, -1), ROUND(1234.5678, -2) FROM DUAL;

-- ���� : TRUNC(����, �Ҽ����ڸ���)
SELECT 1234.5678, TRUNC(1234.5678), TRUNC(1234.5678, 0), TRUNC(1234.5678, 1) FROM DUAL;
SELECT 1234.5678, TRUNC(1234.5678, -1), TRUNC(1234.5678, -2) FROM DUAL;

-- CEIL(����) : ������ ���ں��� ū ����(�ø�)
-- FLOOR(����) : ������ ���ں��� ���� ����
SELECT 1234.5678, CEIL(1234.5678), FLOOR(1234.5678) FROM DUAL;

/* ��¥�� */
SELECT SYSDATE AS ����ð�, (SYSDATE - 1) AS �Ϸ���, (SYSDATE + 1) AS ������ FROM DUAL;
SELECT SYSDATE AS ����ð�, (SYSDATE - 1/24) AS �ѽð���, (SYSDATE + 1/24) AS �ѽð��� FROM DUAL;
SELECT SYSDATE AS ����ð�, (SYSDATE - 30/24/60) AS ��ʺ��� FROM DUAL;
SELECT SYSDATE AS ����ð�, (SYSDATE - 11/24/60) AS ���Ϻ��� FROM DUAL;

-- ADD_MONTHS(��¥��, ������)
SELECT ADD_MONTHS(SYSDATE, 2) FROM DUAL;

SELECT SYSDATE - ODDATE, SYSDATE, ODDATE FROM ORDERS;

SELECT ODDATE - SYSDATE, SYSDATE, ODDATE FROM ORDERS;

-- MONTHS_BETWEEN(��¥��, ��¥��) : �γ�¥�� ������
SELECT MONTHS_BETWEEN(SYSDATE, '2023-01-10') FROM DUAL;

SELECT MONTHS_BETWEEN('2023-01-10', SYSDATE) FROM DUAL;

-- NEXT_DAY(��¥, ã�� ����) : ������ �Ǵ� ��¥���� ã�� ����
SELECT NEXT_DAY(SYSDATE, '��') FROM DUAL;

-- LAST_DAY(��¥)
SELECT LAST_DAY(SYSDATE), LAST_DAY('2023-07-01') FROM DUAL;

-- TO_CHAR()
SELECT ODDATE, TO_CHAR(ODDATE, 'YYYY') AS ����,  
               TO_CHAR(ODDATE, 'MM') AS ��,
               TO_CHAR(ODDATE, 'DD') AS ��,
               TO_CHAR(ODDATE, 'HH24') AS ��
FROM ORDERS;

SELECT ODDATE, 
        TO_CHAR(ODDATE, 'MON'),
        TO_CHAR(ODDATE, 'DAY'), -- ���� ��������(�����)
        TO_CHAR(ODDATE, 'DY'), -- ����(��)
        TO_CHAR(ODDATE, 'W'),
        TO_CHAR(ODDATE, 'WW'),
        TO_CHAR(SYSDATE, 'W')
FROM ORDERS;

-- NVL(�÷�, ��ü��) : NULL ����ü
-- NVL2(�÷�, NULL�� �ƴѰ��, NULL�� ���)
SELECT ENAME ,COMM, NVL(COMM, 10000) FROM EMP;

SELECT ENAME ,COMM, NVL2(COMM, 'COMM����', 'COMM����') FROM EMP;



---------------------------------------------------------------------
--SYS�������� ���� �� ����
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE USER MOVIEPROJECT IDENTIFIED BY"1111";
GRANT DBA TO MOVIEPROJECT;

DROP USER MOVIEPROJECT;

-- SYS���� ��������
-- MOVIEPROJECT ���� �� ����

/* ��ȭ���� ���̺�(MOVIES - MV) */
CREATE TABLE MOVIES(
    MVCODE NCHAR(7),            -- �ڵ�()
    MVTITLE NVARCHAR2(50),      -- ����
    MVDIRECTOR NVARCHAR2(30),   -- ����
    MVACTORS NVARCHAR2(200),    -- ���
    MVGENRE NVARCHAR2(200),     -- �帣
    MVINFO NVARCHAR2(200),      -- �⺻����
    MVOPEN DATE,                -- ������
    MVPOSTER NVARCHAR2(200),    -- ������URL
    MVSTATE NCHAR(1)            -- ����(1:����,0:����)
);








