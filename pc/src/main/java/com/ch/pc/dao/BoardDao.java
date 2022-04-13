package com.ch.pc.dao;

import java.util.List;

import com.ch.pc.model.Board;

public interface BoardDao {

	List<Board> list(Board board);

	int getTotal(Board board);

	Board select(int pcno, int bno);

	void updateRead_cnt(int pcno, int bno);

	int update(Board board);

	int insert(Board board);

	int delete(int pcno, int bno);

	void likesMinus(int bno);

	void likesPlus(int bno);

	Board select(int bno);

}
