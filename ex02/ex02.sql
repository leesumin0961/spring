

/* Create Tables */

CREATE TABLE board
(
	-- 글번호
	bno number NOT NULL,
	-- 회원아이디
	id varchar2(20) NOT NULL,
	-- 글제목
	title varchar2(200) NOT NULL,
	-- 글내용
	content varchar2(1000) NOT NULL,
	PRIMARY KEY (bno)
);


CREATE TABLE goods
(
	-- 상품번호  / 년월일 일련번호의 조합
	code char(12) NOT NULL,
	-- 상품명
	name varchar2(20) NOT NULL,
	-- 상품가격 /현재시점의 상품가격
	price number NOT NULL,
	PRIMARY KEY (code)
);


CREATE TABLE members
(
	-- 회원아이디
	id varchar2(20) NOT NULL,
	-- 회원이름
	name varchar2(50) NOT NULL,
	-- 회원비밀번호
	pw varchar2(50),
	PRIMARY KEY (id)
);


CREATE TABLE orderDetails
(
	-- 주문번호 
	-- 년월일(8자리)+카테고리번호(4자리)+일련번호(8자리) 
	ono char(20) NOT NULL,
	-- 상품번호  / 년월일 일련번호의 조합
	code char(12) NOT NULL,
	PRIMARY KEY (ono, code)
);


CREATE TABLE orders
(
	-- 주문번호 
	-- 년월일(8자리)+카테고리번호(4자리)+일련번호(8자리) 
	ono char(20) NOT NULL,
	-- 회원아이디
	id varchar2(20) NOT NULL,
	PRIMARY KEY (ono)
);



/* Create Foreign Keys */

ALTER TABLE orderDetails
	ADD FOREIGN KEY (code)
	REFERENCES goods (code)
;


ALTER TABLE board
	ADD FOREIGN KEY (id)
	REFERENCES members (id)
;


ALTER TABLE orders
	ADD FOREIGN KEY (id)
	REFERENCES members (id)
;


ALTER TABLE orderDetails
	ADD FOREIGN KEY (ono)
	REFERENCES orders (ono)
;



