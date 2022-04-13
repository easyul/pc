package com.ch.pc.model;

import java.sql.Date;

import lombok.Data;

@Data
public class Board_reply {
	private int rno;
	private String content;
	private Date reg_date;
	private int likes;
	private String del;
	private int mno;
	private int bno;
	private int pcno;
	
	private String nick_name;
	
	private int likesConfirm;
}
