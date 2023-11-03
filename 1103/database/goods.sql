-- 상품번호, 이름, 당첨확률, 남은수량

CREATE TABLE goods (
    good_id NUMBER(3)
        CONSTRAINT good_id_pk PRIMARY KEY,
    good_name VARCHAR2(30) 
        CONSTRAINT good_name_nn NOT NULL,                  
    good_odds NUMBER(3,1) 
        CONSTRAINT good_odds_chk CHECK(good_odds >= 0.1 AND good_odds <= 100),
    good_remaining NUMBER(4) 
        CONSTRAINT good_remaining_chk CHECK(good_remaining >= 0),
    good_price NUMBER(8) 
        CONSTRAINT good_price_chk CHECK(good_price > 0)
);

INSERT INTO goods VALUES(777, '냉장고', 5, 10, 3000000);
INSERT INTO goods VALUES(333, '최신형컴퓨터', 15, 20, 1500000);
INSERT INTO goods VALUES(555, '다이슨청소기', 20, 30, 1200000);
INSERT INTO goods VALUES(111, '애플워치', 25, 40, 300000);
INSERT INTO goods VALUES(222, '5만원상품권', 35, 50, 50000);

DROP TABLE goods;
