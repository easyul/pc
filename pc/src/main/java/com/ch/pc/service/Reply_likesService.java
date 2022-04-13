package com.ch.pc.service;

public interface Reply_likesService {

	int select(int mno, int rno);

	void insert(int mno, int rno);

	void delete(int mno, int rno);

}
