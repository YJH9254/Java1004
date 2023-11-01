-- 16_제약조건.sql

/*
    # 무결성
    
    - 결함이 없는 성질
    - 데이터를 결함없는 상태로 올바르게 유지하는 것
    - 데이터를 올바르게 관리하기 위해서는 다양한 종류의 무결성을 충족시켜야 한다
    - 데이터베이스에서 다양한 무결성들을 지키기 위해 사용하는 것이 제약조건이다
    
    # 개체 무결성
    
    - 테이블의 데이터는 반드시 하나의 행을 선택할 수 있어야 한다
    - 한 행만 선택할 수 없는 데이터는 개체 무결성이 깨진것이다
    - DB에서는 데이터의 개체 무결성을 지키기 위해서 제약조건으로 
      기본키(PK) 제약조건을 사용한다
      
    # 참조 무결성
    
    - 참조 관계에 있는 데이터는 유효한 데이터를 참고해야 한다
    - DB에서는 데이터의 참조 무결성을 지키기 위해 외래키(FK) 제약조건을 사용한다
    
    # 도메인 무결성
    
    - 하나의 도메인(컬럼)을 구성하는 개체들은 모두 같은 타입이어야 한다
    - DB에서는 컬럼 타입을 지정하여 해당 컬럼의 도메인 무결성을 유지한다
    
    # 데이터 무결성
    
    - 데이터가 정확성, 일관성, 유효성을 유지하는 것
    - CHECK, NOT NULL, UNIQUE 등의 제약 조건을 통해 데이터 무결성을 
      유지할 수 있다
    
    # DB의 제약 조건들
    
    - UNIQUE : 해당 도메인에 중복되는 값을 허용하지 않는다 (null 허용)
    - NOT NULL : 해당 도메인에 null을 허용하지 않는다
    - PRIMARY KEY : 기본키, NOT NULL + UNIQUE, 한 테이블 당 하나만 설정 가능
    - FOREIGN KEY : 해당 도메인을 외래키로 설정. 어느 컬럼을 참조할지 지정해야 한다.
                    기본키 또는 UNIQUE 제약조건이 설정된 컬럼만 참조할 수 있다.
    - CHECK : 원하는 조건을 직접 설정하여 해당 조건을 만족하는 개체만 추가 가능
*/

/*
    # 데이터 딕셔너리 (Data Dictionary)
    
    - 데이터의 정보에 대한 데이터 (데이터 사전, 메타 데이터)
    - 현재 DB의 상황에 대한, DB가 알아서 관리하는 데이터
    - DB 사용자는 데이터 딕셔너리를 직접 수정할 수 없다
    
    # 데이터 딕셔너리 뷰
    
    - 데이터 딕셔너리를 사용자가 확인할 수 있게끔 제공하는 뷰(View)
      * 뷰(View) - DB  오브젝트 중 하나로 전체 컬럼의 일부만 보기좋은 형태로
                  조회할 수 있는 미니 테이블 (원본 테이블의 부분 집합)
    - 앞에 user_를 붙이면 현재 접속 DB 계정의 데이터 딕셔너리를 확인할 수 있다
    - 앞에 all_을 붙이면 전체 계정의 데이터 딕셔너리를 확인할 수 있다
*/

-- 모든 계정을 볼 수 있는 데이터 딕셔너리 뷰
SELECT * FROM all_users;

-- 현재 계정의 테이블 목록을 볼 수 있는 데이터 딕셔너리 뷰
SELECT * FROM user_tables;
-- 모든 계정의 테이블 목록을 볼 수 있는 데이터 딕셔너리 뷰
SELECT * FROM all_tables;

-- 현재 계정에 존재하는 제약조건 보기
SELECT * FROM user_constraints;
SELECT * FROM user_constraints WHERE table_name = 'EMPLOYEES';

-- 모든 계정에 존재하는 제약조건 보기
SELECT * FROM all_constraints;

/*
    # CONSTRAINT_TYPE
    
    - P : Primary Key
    - R : References (Foreign Key) / 외래키
    - U : Unique / 유일함
    - C : Check, Not Null / 조건 직접 설정함
*/

/*
    1. 테이블 생성과 동시에 제약조건 추가하기
    
    - 테이블을 생성시 컬럼명과 컬럼타입 뒤에 제약조건을 추가할 수 있다
    - 데이터 추가/수정/삭제시 제약조건의 영향을 받는다
    - 제약조건 이름을 설정하지 않으면 오라클에서 생성한 자동 이름을 사용한다
      (어떤 잘못을 해서 제약조건을 위배했는지 알기 힘들어진다)
    - "컬럼명 컬럼타입 CONSTRAINT 제약조건명 제약조건타입"을 통해
      제약조건의 이름도 직접 설정할 수 있다
    - 한 도메인에 여러개의 제약조건을 설정할 수도 있다
*/
CREATE TABLE coffee (
    coffee_id NUMBER(4) PRIMARY KEY,
    coffee_name VARCHAR2(40) NOT NULL 
                             UNIQUE,
    coffee_price NUMBER(5) CHECK(coffee_price >= 0), 
    coffee_size CHAR(1) CHECK(coffee_size IN ('T', 'G', 'V')) 
                        NOT NULL
);

INSERT INTO coffee VALUES(1, '아메리카노', 1500, null);
INSERT INTO coffee VALUES(2, '아메리카노(T)', 1200, 'T');
INSERT INTO coffee VALUES(3, '아메리카노(L)', 1200, 'L');

SELECT * FROM coffee;
SELECT * FROM user_constraints;

-- 테이블을 삭제하면 제약조건도 함께 삭제된다
DROP TABLE coffee;
PURGE recyclebin;

CREATE TABLE coffee(
    coffee_id NUMBER(4) -- SYS000 대신 내가 지정한 제약조건명을 사용할 수 있다
        CONSTRAINT coffee_id_pk PRIMARY KEY, 
    coffee_name VARCHAR2(40)
        CONSTRAINT coffee_name_uk UNIQUE
        CONSTRAINT coffee_name_nn NOT NULL,
    coffee_price NUMBER(5)
        CONSTRAINT coffee_price_positive CHECK(coffee_price >= 0)
        CONSTRAINT coffee_price_nn NOT NULL,
    coffee_size CHAR(1)
        CONSTRAINT coffee_size_nn NOT NULL
        CONSTRAINT coffee_size_chk CHECK(coffee_size IN ('T', 'G', 'V'))
);

SELECT * FROM user_constraints WHERE table_name = 'COFFEE';

INSERT INTO coffee VALUES (1, 'Americano', 2000, 'T');
INSERT INTO coffee VALUES (2, 'Caffe Latte', 2300, 'T');
INSERT INTO coffee VALUES (3, '카페라떼', 2500, 'A');
INSERT INTO coffee VALUES (3, '카페라떼', -2500, 'V');


