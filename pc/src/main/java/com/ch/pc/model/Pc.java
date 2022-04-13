package com.ch.pc.model;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Pc {
	private int pcno;
	private String pcbusinessnum;
	private String pcpno;
	private String pcname;
	private String pcaddr;
	private int pclikes;
	private String pcinfo;
	private String pcintro;
	private int mno;
	private String imagename;
	private MultipartFile pcimage;
	private float pclati;
	private float pclongi;
	//승인확인용
	private String permit; 
	
	//검색용
 	private String searchKey;
 	private String searchValue;
 	//페이징용
 	private int startRow;
 	private int endRow;
 	
	private int seatlow;
	private int seatcol;
}
