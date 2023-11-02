-- 18_ON DELETE.sql

/*
    # ON DELETE
    
    - 외래키를 설정할 때 부모키를 삭제할 때의 정책을 결정한다
    - ON DELETE RESTRICT : 부모키를 삭제하려고 할 때 삭제를 막는다 (기본값)
    - ON DELETE SET NULL : 부모키를 삭제하고 참조하던 자식키들의 값을 null로 바꾼다
    - ON DELETE CASCADE : 부모키를 삭제하면 참조하던 자식행을 모두 삭제해버린다
*/
SELECT * FROM user_tables;

SELECT * FROM coffee;
SELECT * FROM fruits;

UPDATE fruits SET country_id = 'AR' WHERE country_id = 'KR';

-- countries3의 국가를 지우면 fruits에서 참조하던 국가의 값을 null로 바꾸겠다
ALTER TABLE fruits ADD CONSTRAINT fruits_c_id_fk
FOREIGN KEY(country_id) REFERENCES countries3(country_id)
ON DELETE SET NULL;

ALTER TABLE coffee MODIFY (
    country_id CHAR(2)
        CONSTRAINT coffee_c_id_fk REFERENCES countries3(country_id)
            ON DELETE CASCADE
);

SELECT * FROM user_constraints WHERE table_name = 'COFFEE';
ALTER TABLE coffee DROP CONSTRAINT coffee_c_id_fk;
ALTER TABLE fruits DROP CONSTRAINT sys_c007005;

-- 부모키 삭제해보기 (coffee와 fruits의 모든 삭제 정책이 필요하다)
DELETE FROM countries3 WHERE country_id = 'AU';

SELECT * FROM coffee; -- CASCADE였기 때문에 국가코드가 'AU'였던 커피행이 모두 삭제됨
SELECT * FROM fruits; -- SET NULL이었기 때문에 국가코드가 'AU'였던 행이 모두 null이 됨





