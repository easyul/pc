package com.ch.pc.model;

import java.sql.Date;

import lombok.Data;

@Data
public class Review {
	private int rno;
	private int pcno;
	private int mno;
	private String content;
	private Date reg_date;
	private int likes;
	private int rating;
	private String del;
	
	private String nick_name;
	
	private int likesConfirm;
	
	private int startRow;
	private int endRow;
}
