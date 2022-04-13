package com.ch.pc.model;

import java.sql.Date;

import lombok.Data;

@Data
public class Reservation {
	private int reserveno;
	private int mno;
	private int pcno;
	private int reservetime;	
	private String starttime;
	private String endtime;
	private String reserveSeatPosition;
	private String expiration;
	private Date reg_date;
	
	private int startRow;
	private int endRow;
	
	private String pcname;
}
