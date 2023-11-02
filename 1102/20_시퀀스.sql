-- 20_시퀀스.sql

/*
    # 시퀀스 (Sequence)
    
    - 기본키로 사용하기 편리하도록 번호를 자동으로 생성해주는 DB 오브젝트
    
    CREATE SEQUENCE 시퀀스명
                    [START WITH n] - 시작 번호 설정
                    [INCREMENT BY n] - 증가 숫자 설정
                    [MAXVALUE n | NOMAXVALUE] - 최대 숫자 설정
                    [MINVALUE N | NOMINVALUE] - 최소 숫자 설정
                    [CYCLE | NOCYCLE] - 숫자 순환 여부 설정
                    [CACHE n | NOCACHE] - 번호를 미리 만들어놓을 양을 설정
*/

-- 시퀀스 데이터 딕셔너리 뷰
SELECT * FROM user_sequences;
SELECT * FROM all_sequences;

-- 시퀀스 생성하기
CREATE SEQUENCE coffee_seq1;
CREATE SEQUENCE fruit_id_seq START WITH 10 INCREMENT BY 10;

-- 테스트용 테이블 dual : 그냥 연습을 위한 테이블
SELECT * FROM dual;
SELECT 10 * 10 FROM dual;
SELECT upper('apple') FROM dual;
SELECT lower('Smith') FROM dual;

-- 시퀀스.nextval : 다음 번호를 사용한다 (다시는 이전 번호로 돌아갈 수 없다)
SELECT coffee_seq1.nextval FROM dual;
SELECT fruit_id_seq.nextval FROM dual;

-- 시퀀스.crrval : 현재 번호를 확인한다 (nextval을 실행한 이후에만 확인 가능)
SELECT coffee_seq1.currval FROM dual;
SELECT fruit_id_seq.currval FROM dual;

-- 시퀀스를 사용해 테이블에 INSERT하기
ALTER TABLE fruits MODIFY (
    fruit_id NUMBER(10)
        CONSTRAINT fruit_id_pk PRIMARY KEY
);

SELECT * FROM fruits;

-- 기본키 값을 직접 계산하면 힘들기 때문에 시퀀스를 만들어 사용한다
INSERT INTO fruits(fruits_id, fruit_name, fruit_price)
VALUES (fruit_id_seq.nextval, 'Apple', 1234);


CREATE SEQUENCE bank_waiting_seq
    START WITH 10 INCREMENT BY 20 
    MINVALUE 10 MAXVALUE 100 CYCLE NOCACHE;
    
DROP SEQUENCE bank_waiting_seq;
SELECT bank_waiting_seq.nextval FROM dual;

-- 시퀀스 삭제하기 : DROP SEQUENCE 시퀀스명;
-- 시퀀스 수정하기 : ALTER SEQUENCE 시퀀스명 (옵션은 CREATE SEQUENCE와 같음)

