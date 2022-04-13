
-- 회원테이블
drop table member1;
select * from member1;
select * from BOARD;
delete * from board where bno = 5;
create table member1(
	mno number primary key,
	id varchar2(100) not null,
	password varchar2(100) not null,
	name varchar2(100) not null,
	nick_name varchar2(100) not null,
	phone varchar2(100) not null,
	gender char(2) default 'm' not null,
	birth DATE not null,
    email VARCHAR2(100) NOT NULL,
    reg_date DATE NOT NULL,
    del   CHAR(1) default 'n' NOT NULL,
    blacklist char(4) default 'n' not null,
    identity varchar2(30) not null,
    profile varchar2(300)
)
select * from member1;

-- pc테이블
drop table pc;

create table pc(
	pcno number primary key,
	pcbusinessnum varchar2(20) not null,
	pcpno varchar2(20) not null,
	pcname varchar2(100) not null,
	pcaddr varchar2(500) not null,
	pclati decimal(18,10),
	pclongi decimal(18,10),
	permit char(1) default 'n' not null,
	pclikes number, -- 리뷰 키로 바꿔야 될듯(없애도 될듯)
	pcinfo varchar2(4000),
	pcintro varchar2(4000),
	seatlow number,
    seatcol number,
	mno number references member1,
	imagename varchar2(50)
);

select * from pc;

-- pc방 사진
drop table pcimage;

create table pcimage(
	imageno number(10) primary key,
	pcno number references pc(pcno),
	imagename varchar2(50)
)

create sequence pcimage_seq;
-- sql devleoper로
CREATE or replace FUNCTION get_seq
	RETURN NUMBER
IS
BEGIN
	RETURN pcimage_seq.nextval;
END;
/

--요금
drop table fee;

create table fee(
	pcno number references pc not null,
	w1000 number,
	w3000 number,
	w5000 number,
	w10000 number,
	w50000 number,
	w100000 number
)

select * from fee;
DELETE FROM fee WHERE w100000 = 60

--즐겨찾기
drop table bookmark1;

create table bookmark1(
	mno number references member1 not null,
	pcno number references pc not null
)

-- 게시판
drop table board;

create table board(
	bno number primary key,
	subject varchar2(200) not null,
	content varchar2(4000) not null,
	reg_date date not null,
	read_cnt number not null,
	likes number not null,
	del char(1) default 'n' not null,
	mno number references member1 not null,
	pcno number references pc not null
)

--게시판 좋아요
drop table board_likes;

create table board_likes(
	mno number references member1 not null,
	bno number references board not null
)

-- 댓글
drop table board_reply;

create table board_reply(
	rno number primary key,
	content varchar2(4000) not null,
	reg_date date not null,
	likes number not null,
	del char(1) default 'n' not null,
	mno number references member1 not null,
	pcno number references pc not null,
	bno number references board not null
)

--댓글 좋아요
drop table reply_likes;

create table reply_likes(
	mno number references member1 not null,
	rno number references board_reply not null
)

-- 좌석
drop table seat;

create table seat (
	seatno number primary key,
    seatposition varchar2(3000),
	pcno number references pc not null
);
select * from seat;


-- 예약
drop table reservation;
create table reservation(
	reserveno number primary key,
	mno number references member1 not null,
	pcno number references pc not null,
	reservetime number not null,	-- 몇시간동안 사용할건지
	starttime varchar2(50) not null,
	endtime varchar2(50) not null,
	reserveSeatPosition varchar2(3000),
	expiration char(1) default 'n' not null,
	reg_date date not null
)
select * from reservation;

--리뷰
drop table review;

create table review (
	rno number primary key,
	pcno number references pc not null,
	mno number references member1 not null,
	content varchar2(4000) not null,
	reg_date date not null,
	likes number not null,
	rating number not null,
	del char(1) default 'n' not null
)

select * from review

--리뷰 좋아요
drop table review_likes;

create table review_likes(
	mno number references member1 not null,
	rno number references review not null
)

select * from reservation where expiration = 'n';
update reservation set expiration = 'y'
