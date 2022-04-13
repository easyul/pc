package com.ch.pc.model;
import java.sql.Date;
import lombok.Data;
@Data
public class Board {
	private int bno;
	private String subject;
	private String content;
	private Date reg_date;
	private int read_cnt;
	private int likes;
	private String del;
	private int mno;
	private int pcno;
	// 게시판에 보여주기 위해
	private String nick_name;
	//검색
	private int startRow;
	private int endRow;
	private String searchKey;
	private String searchValue;
}