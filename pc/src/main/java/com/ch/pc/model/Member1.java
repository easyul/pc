package com.ch.pc.model;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Member1 {
	private int mno;
	private String id;
	private String password;
	private String name;
	private String nick_name;
	private String phone;
	private String gender;
	private Date birth;
	private String email;
	private Date reg_date;
    private String del;
    private String blacklist;
    private String identity;
    private String profile;
 // upload용
 	private MultipartFile file;
 	//검색용
 	private String searchKey;
 	private String searchValue;
 	//페이징용
 	private int startRow;
 	private int endRow;
 	//인증 대기용
 	private int permitConfirm;
}
