package com.ch.pc.dao;

public interface Board_likesDao {

	int select(int mno, int bno);

	void delete(int mno, int bno);

	void insert(int mno, int bno);

}
