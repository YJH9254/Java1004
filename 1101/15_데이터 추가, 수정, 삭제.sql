-- 15_데이터 추가, 수정, 삭제.sql

/*
    # 테이블에 데이터 추가하기
    
    - INSERT INTO 테이블명(컬럼1, 컬럼2, ...) VALUES(값1, 값2, ...);
    - INSERT INTO 테이블명 VALUES(반드시 모든 컬럼값을 순서대로);
*/
CREATE TABLE fruits (
    fruit_name VARCHAR2(30),
    fruit_price NUMBER(6),
    fruit_grade VARCHAR2(2),
    country_id CHAR(2) NOT NULL
);
SELECT * FROM fruits;

-- 가장 기본적인 INSERT
INSERT INTO fruits (
    fruit_name, fruit_price, fruit_grade, country_id
) VALUES ( 'Apple', 1300, 'A+', 'KR' );

-- # INSERT시에 컬럼 순서를 꼭 지킬 필요는 없다
--   컬럼 순서를 바꿨다면 값의 순서도 바꿔야 한다
INSERT INTO fruits (
    country_id,  fruit_grade, fruit_price, fruit_name
) VALUES ( 'AU', 'SS', 2800, 'Banana' );

-- # INSERT시에 컬럼을 모두 적지 않을 수 있다
--   단, 적지 않은 컬럼에는 행 추가시 자동으로 null이 들어간다
--   적지 않은 컬럼이 null을 허용하지 않는 컬럼인 경우 에러가 발생한다

-- 생략한 컬럼인 fruit_price와 fruit_grade에는 null이 들어갔다
INSERT INTO fruits (fruit_name, country_id) VALUES ('Grape', 'FR');
-- 생략한 컬럼이 null을 허용하지 않아서 insert가 거부되었다
INSERT INTO fruits (fruit_name, fruit_price) VALUES ('Grape', 3000);


-- # 컬럼명을 아예 생략하면 모든 컬럼값을 순서대로 적어야 한다
INSERT INTO fruits VALUES('Peach', 1800, 'A', 'KR');

-- # 서브쿼리로 INSERT 하기 (테이블 구조가 동일한 경우에만 가능
INSERT INTO fruits (SELECT * FROM fruits);

/*
    # 테이블 데이터 수정하기
    
    - UPDATE 테이블명 SET 컬럼1=값1, 컬럼2=값2, ... WHERE 조건절;
    - 만약 조건을 지정하지 않으면 모든 행이 수정된다
    - 하나의 행만 수정하기 위해서 기본키와 함께 자주 활용된다
*/
COMMIT; -- 현재까지의 변경 사항을 저장한다

-- 조건을 지정하지 않으면 해당 테이블의 모든 행이 수정되므로 주의해야 한다
UPDATE fruits SET fruit_name = 'PineApple';

-- 조건을 지정해야 원하는 행만 수정할 수 있다
UPDATE fruits
SET
    fruit_name = 'PineApple',
    fruit_price = 5000
WHERE
    fruit_name = 'Apple';

ROLLBACK; -- 변경 사항을 모두 취소하고 가장 최근의 COMMIT 상태로 돌아간다 (DCL)


/*
    # 테이블 데이터 삭제하기
    
    - DELETE FROM 테이블명 WHERE 조건절:
    - 조건을 적지 않으면 해당 테이블의 모든 데이터가 삭제된다
*/
COMMIT;

-- 조건을 적지 않으면 모든 행이 삭제되므로 주의해야 한다
DELETE FROM fruits;

-- 조건을 적어야 원하는 행만 삭제할 수 있다
DELETE FROM fruits WHERE fruit_grade IS NULL;

ROLLBACK;

SELECT * FROM fruits WHERE country_id = 'KR';
SELECT * FROM fruits;
DROP TABLE fruits;
PURGE recyclebin;


-- 연습1: 직접 설계하고 정의했던 테이블에 알맞은 데이터들을 넣어보세요

-- 연습2: 두 테이블 이상을 JOIN하여 원하는 데이터를 조회해보세요

CREATE TABLE SoccerStadium (
    stadium_id NUMBER(5), -- PK
    stadium_name VARCHAR2(30),
    stadium_address VARCHAR2(100)
);

INSERT INTO SoccerStadium 
VALUES (10000, '서울올림픽주경기장', '서울특별시 송파구 올림픽로 25');
INSERT INTO SoccerStadium 
VALUES (20000, '서울월드컵경기장', '서울특별시 마포구 성산동 515');
INSERT INTO SoccerStadium 
VALUES (30000, '부산아시아드주경기장', '부산광역시 연제구 월드컵대로 344');
INSERT INTO SoccerStadium 
VALUES (40000, '대구스타디움', '대구광역시 수성구 유니버시아드로 180');
INSERT INTO SoccerStadium 
VALUES (50000, '인천문학종합경기장', '인천광역시 미추홀구 매소홀로 618');
INSERT INTO SoccerStadium 
VALUES (60000, '수원월드컵경기장', '경기도 수원시 팔달구 월드컵로 310');
INSERT INTO SoccerStadium 
VALUES (70000, '고양종합운동장', '경기도 고양시 일산서구 중앙로 1601(대화동)');
INSERT INTO SoccerStadium 
VALUES (80000, '대전월드컵경기장', '대전광역시 유성구 월드컵대로 32');
INSERT INTO SoccerStadium 
VALUES (90000, '광주월드컵경기장', '광주광역시 서구 금화로 240');
INSERT INTO SoccerStadium 
VALUES (11000, '울산문수축구경기장', '울산광역시 남구 문수로 44');

SELECT * FROM SoccerStadium;

CREATE TABLE SoccerTeam (
    team_id NUMBER(5),  -- PK
    team_name VARCHAR2(30),
    owner_name VARCHAR2(20),
    team_leader_id NUMBER(8), -- 1:1 관계이지만 외래키를 사용하는 경우
    home_stadium_id NUMBER(5)
);
INSERT INTO soccerteam 
VALUES ( 11111, 'FC서울', '허태수', 1111, 10000); 
INSERT INTO soccerteam 
VALUES ( 22222, '성남FC', '신상진', 2222, 20000);
INSERT INTO soccerteam 
VALUES ( 33333, '전북 현대 모터스', '장재훈', 3333, 30000 );
INSERT INTO soccerteam 
VALUES ( 44444, '울산 현대', '권오갑', 4444, 40000);
INSERT INTO soccerteam 
VALUES ( 55555, '김천 상무', '김충섭', 5555, 50000);
INSERT INTO soccerteam 
VALUES ( 66666, '수원 삼성 블루윙즈', '염기훈', 6666, 60000);
INSERT INTO soccerteam 
VALUES ( 77777, '포항 스틸러스', '최정우', 7777, 70000);
INSERT INTO soccerteam 
VALUES ( 88888, '인천 유나이티드', '유정복', 8888, 80000);
INSERT INTO soccerteam 
VALUES ( 99999, '대구FC', '홍준표', 9999, 90000);
INSERT INTO soccerteam 
VALUES ( 12345, '강원FC', '김진선', 1010, 11000);

SELECT * FROM soccerteam;
COMMIT;

CREATE TABLE SoccerPlayer (
    player_id NUMBER(8), -- PK
    player_eng_name VARCHAR2(25), -- 영어는 한 글자가 1바이트 차지한다
    player_kor_name VARCHAR2(40), -- 한글은 한 글자가 3바이트 정도 차지한다
    player_position VARCHAR2(3),
    player_back_number NUMBER(2),
    country_id CHAR(2), -- Countries 테이블로부터 땡겨올 외래키
    team_id NUMBER(5) -- SccoerTeam 테이블로부터 땡겨올 외래키
);

INSERT INTO soccerplayer 
VALUES (1111, 'Ronaldo', '호날두', 'SS', 1, 'AR', 11111);
INSERT INTO soccerplayer 
VALUES (2222, 'Mbappe', '옴바페', 'CF', 2, 'AU', 22222);
INSERT INTO soccerplayer 
VALUES (3333, 'Messi', '메시', 'AM', 3, 'BE', 33333);
INSERT INTO soccerplayer 
VALUES (4444, 'Thiago', '티아고', 'CM', 4, 'BR', 44444);
INSERT INTO soccerplayer 
VALUES (5555, 'Bruno', '브루노', 'DM', 5, 'CA', 55555);
INSERT INTO soccerplayer 
VALUES (6666, 'Lampard', '램파드', 'CB', 6, 'CH', 66666);
INSERT INTO soccerplayer 
VALUES (7777, 'Alaba', '알라바', 'GK', 7, 'CN', 77777);
INSERT INTO soccerplayer 
VALUES (8888, 'Deligt', '데 리흐트', 'RWF', 8, 'DE', 88888);
INSERT INTO soccerplayer 
VALUES (9999, 'Vandijk', '반 다이크', 'RM', 9, 'DK', 99999);
INSERT INTO soccerplayer 
VALUES (1010, 'Roberto', '로베르토', 'RWB', 10, 'FG', 12345);
INSERT INTO soccerplayer 
VALUES (1541, 'Ramos', '라모스', 'RB', 11, 'FG', 12345);

SELECT * FROM soccerplayer;
COMMIT;
ROLLBACK;
DROP TABLE soccerplayer;

SELECT 
    team_leader_id AS "주장" ,
    player_kor_name AS "선수이름",
    team_name AS "소속된 팀이름",
    country_name AS "국적"
FROM 
    soccerplayer
    INNER JOIN soccerteam USING (team_id)
    INNER JOIN countries USING (country_id)
WHERE  
    team_leader_id = player_id;
