package com.ch.pc.model;

import lombok.Data;

@Data
public class Bookmark {
	private int mno;
	private int pcno;
	
	// 북마크
	private String pcname;
	private String pcaddr;
	private String pcinfo;
		
}
