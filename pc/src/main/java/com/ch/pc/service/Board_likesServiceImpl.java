package com.ch.pc.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.pc.dao.Board_likesDao;

@Service
public class Board_likesServiceImpl implements Board_likesService {
	@Autowired
	private Board_likesDao bld;

	public int select(int mno, int bno) {
		return bld.select(mno, bno);
	}
	public void delete(int mno, int bno) {
		bld.delete(mno, bno);
	}
	public void insert(int mno, int bno) {
		bld.insert(mno, bno);
	}
}
