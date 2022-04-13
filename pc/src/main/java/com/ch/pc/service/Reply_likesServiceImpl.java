package com.ch.pc.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.pc.dao.Reply_likesDao;

@Service
public class Reply_likesServiceImpl implements Reply_likesService {
	@Autowired
	private Reply_likesDao rld;

	public int select(int mno, int rno) {
		return rld.select(mno, rno);
	}
	public void insert(int mno, int rno) {
		rld.insert(mno, rno);
	}
	public void delete(int mno, int rno) {
		rld.delete(mno, rno);
	}
}
