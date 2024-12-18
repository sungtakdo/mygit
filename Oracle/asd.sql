DROP TABLE t_Board CASCADE CONSTRAINTS;

--게시판 테이블을 생성합니다.
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

--테이블에 테스트 글을 추가합니다.
insert into t_board(articleNO, parentNO, title, content, imageFileName, writedate, id)
    values(1, 0, '테스트글입니다.', '테스트글입니다.', null, sysdate, 'hong');
    
insert into t_board(articleNO, parentNO, title, content, imageFileName, writedate, id)
    values(2, 0, '안녕하세요', '상품 후기입니다.', null, sysdate, 'hong');
    
insert into t_board(articleNO, parentNO, title, content, imageFileName, writedate, id)
    values(3, 2, '답변입니다', '상품 후기에 대한 답변입니다', null, sysdate, 'hong');
    
insert into t_board(articleNO, parentNO, title, content, imageFileName, writedate, id)
    values(5, 3, '답변입니다', '상품 좋습니다.', null, sysdate, 'lee');
    
insert into t_board(articleNO, parentNO, title, content, imageFileName, writedate, id)
    values(4, 0, '김유신입니다.', '김유신 테스트글입니다.', null, sysdate, 'kim');
    
insert into t_board(articleNO, parentNO, title, content, imageFileName, writedate, id)
    values(6, 2, '상품 후기입니다..', '이순신씨의 상품 사용 후기를 올립니다!!.', null, sysdate, 'lee');

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
