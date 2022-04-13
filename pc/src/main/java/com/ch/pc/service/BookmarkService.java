package com.ch.pc.service;

import java.util.List;

import com.ch.pc.model.Bookmark;

public interface BookmarkService {

	int select(int mno, int pcno);

	void delete(int mno, int pcno);

	void insert(int mno, int pcno);

	int getTotalMybookmark(int mno);

	List<Bookmark> mybookmarkList(int mno, int startRow, int endRow);

}
