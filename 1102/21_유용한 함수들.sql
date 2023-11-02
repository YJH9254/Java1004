-- 21_유용한 함수들.sql

/******         숫자 타입 함수들         ******/

-- TO_NUMBER(data) : 다른 타입 데이터를 숫자타입으로 변환하는 함수
SELECT to_number('1234') FROM dual;

-- 포맷을 사용해 형식이 있는 문자열도 숫자 타입으로 변환할 수 있다
SELECT to_number('10,000', '999,999') FROM dual;
SELECT to_number('1,000,000', '9,999,999') FROM dual;
SELECT to_number('$100', '$999') FROM dual;

-- abs(n) : 절대값
SELECT abs(-5) FROM dual;

-- floor(n) : 내림
SELECT floor(123.999) FROM dual;

-- ceil(n) : 올림
SELECT CEIL(123.111) FROM dual;

-- round(n,m) : 반올림, 자릿수 설정 가능
SELECT round(123.12345, 4) FROM dual;

-- mod(n,m) : 나머지 연산
SELECT mod(10,3) FROM dual;

-- trunce(n,m) : 원하는 자릿수에서 자르기
SELECT trunc(123.12345, 3) FROM dual;
SELECT trunc(112323.12345, -2) FROM dual;
SELECt trunc(112323.12345, -4) FROM dual;

/******         문자 타입 함수들         ******/

-- to_char(data) : 데이터를 문자 타입으로 변환
SELECT to_char(1234) FROM dual;
SELECT to_char(sysdate) FROM dual; -- 시간을 문자 타입으로 변환

-- 숫자를 화폐 형식의 문자열로 변환할 수 있다
SELECT to_char(1000000, '9,999,999') FROM dual;
SELECT to_char(1000000, '＄9,999,999') FROM dual;
SELECT to_char(1000000, '9,999,999L') FROM dual;

-- 날짜를 원하는 포맷의 문자열로 변환할 수 있다
SELECT to_char(sysdate, 'YYYY/MM/DD HH:MT:SS') FROM dual;
SELECT first_name, to_char(hire_date, 'YYYY/MM/DD HH:MT:SS') FROM employees;

-- substr(str, start, count) : 문자열 자르기 (0부터 시작이 아니므로 주의)
SELECT substr('Hellooooo', 2, 5) FORM dual;
SELECT substr('Hellooooo', 1, 5) FORM dual;

-- ltrim(str, 제거대상문자들) : 왼쪽의 제거 대상 문자들을 제거한다
SELECT ltrim('!!!!!!!!!Hello', '!') FROM dual;
SELECT ltrim('         Hello', ' ') FORM dual;
SELECT ltrim('!!!!@@@!!##!!!!Hello', '!@#') FROM dual;

-- rtrim(str, 제거대상문자들) : 오른쪽의 제거 대상 문자들을 제거한다
SELECT rtrim('ABC!!!!!!@#@#', '!@#') FROM dual;

-- lpad(str, len, char) : 원하는 길이만큼 왼쪽에 문자들을 채워준다
SELECT lpad('Hello', 20, ' ') FROM dual;
SELECT lpad('Nice to meet you', 20, ' ') FROM dual;

-- rpad(str, len, char) : 원하는 길이만큼 오른쪽에 문자들을 채워준다
SELECT rpad('Shoes', 20, '>') FROM dual;

-- upper(str) : 대문자로
-- lower(str) : 소문자로
-- initcap(str) : 첫 글자만 대문자로
SELECT initcap('employees') FROM dual;
SELECT email FROM employees;
SELECT initcap(email) FROM employees;
SELECT lpad(first_name, 20, ' ') FROM employees;

-- replace(str, old, new)
SELECT replace('abc@naver.com', 'naver', 'gmail') FROM dual;


/******         날짜 타입 함수들         ******/

-- to_date(data) : 데이터를 날짜 타입으로 변환
SELECT to_date ('1999/12/12') FROM dual;
SELECT to_date ('1999/12/12 12:12:12', 'YYYY/MM/DD HH24:MI:SS') FROM dual;

-- trunc(date) : 원하는 단위로 날짜를 자름
SELECT
    to_char(trunc(sysdate, 'day'), 'YYYY/MM/DD HH24:MI:SS')
FROM dual; -- day 밑으로 자름 (시간을 제거)

SELECT 
    to_char(trunc(sysdate, 'month'), 'YYYY/MM/DD HH24:MI:SS')
FROM dual;
