package com.ch.pc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.pc.dao.BookmarkDao;
import com.ch.pc.model.Bookmark;

@Service
public class BookmarkServiceImpl implements BookmarkService{
	@Autowired
	private BookmarkDao bd;

	@Override
	public int select(int mno, int pcno) {
		// TODO Auto-generated method stub
		return bd.select(mno,pcno);
	}

	@Override
	public void delete(int mno, int pcno) {
		bd.delete(mno,pcno);
		
	}

	@Override
	public void insert(int mno, int pcno) {
		bd.insert(mno,pcno);
		
	}

	public int getTotalMybookmark(int mno) {
		return bd.getTotalMybookmark(mno);
	}
	public List<Bookmark> mybookmarkList(int mno, int startRow, int endRow) {
		return bd.mybookmarkList(mno, startRow, endRow); 
	}
	
}
