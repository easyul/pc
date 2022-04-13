package com.ch.pc.dao;

public interface Review_likesDao {

	int select(int mno, int rno);

	void insert(int mno, int rno);

	void delete(int mno, int rno);

}
