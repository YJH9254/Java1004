-- 19_트랜잭션.sql

/*
    # 트랜잭션 (Transaction)
    
    - 하나의 작업 단위 (ex: 송금)
    - 데이터베이스는 하나의 트랜잭션에 속한 모든 작업이
      정상적으로 완료되는 경우에만 변경사항을 확정지을 수 있는 기능을 제공한다
      (All or Nothing)
    - 트랜잭션을 관리하기 위해 COMMIT, ROLLBACK, SAVEPOINT, ROLLBACK TO를 사용한다
    - 하나의 트랜잭션은 마지막 커밋 이후부터 새로운 커밋 사이에서
      실행된 모든 DML만을 의미한다
      (INSERT, UPDATE, DELETE는 트랜잭션의 관리 대상이나
       CREATE, ALTER 등의 DDL은 트랜잭션의 관리 대상이 아니다)
*/
SELECT * FROM fruits;
DELETE FROM fruits;

-- COMMIT: 여태까지의 변경 사항을 확정 짓는다 (하나의 트랜잭션을 마무리한다)
COMMIT;

INSERT INTO fruits VALUES('Apple', 1234, 'C', 'ZM');

-- ROLLBACK: 가장 최근에 했던 커밋으로 돌아간다
ROLLBACK;

-- 짐바브웨의 과일 가격을 500원 증가
UPDATE fruits SET fruit_price = fruit_price + 500 WHERE country_id = 'ZM';

SAVEPOINT MYSAVEPOINT1;

UPDATE fruits SET fruit_price = fruit_price + 500 WHERE country_id = 'ZM';

SAVEPOINT MYSAVEPOINT2;

UPDATE fruits SET fruit_price = fruit_price + 500 WHERE country_id = 'ZM';

SELECT * FROM fruits;

ROLLBACK TO mysavepoint2;
ROLLBACK TO mysavepoint1;
ROLLBACK TO mysavepoint2; -- 1로 돌아간 시점에서 savepoint2는 미래이므로 돌아갈 수 없다

-- 트랜잭션의 작업 중 일부만 취소하고 계속해서 진행하고 싶은 경우
-- SAVEPOINT와 ROLLBACK TO를 활용한다
