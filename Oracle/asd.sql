DROP TABLE t_Board CASCADE CONSTRAINTS;

--�Խ��� ���̺��� �����մϴ�.
create table t_Board(
    articleNO number(10) primary key,
    parentNO number(10) default 0,
    title varchar2(500) not null,
    content varchar2(4000),
    imageFileName varchar2(100),
    writedate date default sysdate not null,
    id varchar2(10),
    CONSTRAINT FK_ID FOREIGN KEY(id)
    REFERENCES t_member(id)
);

--���̺� �׽�Ʈ ���� �߰��մϴ�.
insert into t_board(articleNO, parentNO, title, content, imageFileName, writedate, id)
    values(1, 0, '�׽�Ʈ���Դϴ�.', '�׽�Ʈ���Դϴ�.', null, sysdate, 'hong');
    
insert into t_board(articleNO, parentNO, title, content, imageFileName, writedate, id)
    values(2, 0, '�ȳ��ϼ���', '��ǰ �ı��Դϴ�.', null, sysdate, 'hong');
    
insert into t_board(articleNO, parentNO, title, content, imageFileName, writedate, id)
    values(3, 2, '�亯�Դϴ�', '��ǰ �ı⿡ ���� �亯�Դϴ�', null, sysdate, 'hong');
    
insert into t_board(articleNO, parentNO, title, content, imageFileName, writedate, id)
    values(5, 3, '�亯�Դϴ�', '��ǰ �����ϴ�.', null, sysdate, 'lee');
    
insert into t_board(articleNO, parentNO, title, content, imageFileName, writedate, id)
    values(4, 0, '�������Դϴ�.', '������ �׽�Ʈ���Դϴ�.', null, sysdate, 'kim');
    
insert into t_board(articleNO, parentNO, title, content, imageFileName, writedate, id)
    values(6, 2, '��ǰ �ı��Դϴ�..', '�̼��ž��� ��ǰ ��� �ı⸦ �ø��ϴ�!!.', null, sysdate, 'lee');

commit;
select * from t_board;


SELECT LEVEL,
        articleNO,
        parentNO,
        LPAD(' ', 4*(LEVEL-1)) || title title,
        content,
        writeDate,
        id
FROM t_board
START WITH parentNO=0
CONNECT BY PRIOR articleNO=parentNO
ORDER SIBLINGS BY articleNO DESC;
