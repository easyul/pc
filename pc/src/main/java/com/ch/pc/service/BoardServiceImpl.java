package com.ch.pc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.pc.dao.BoardDao;
import com.ch.pc.model.Board;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	private BoardDao bd;

	public List<Board> list(Board board) {
		return bd.list(board);
	}
	public int getTotal(Board board) {
		return bd.getTotal(board);
	}
	public Board select(int pcno, int bno) {
		return bd.select(pcno, bno);
	}
	public void updateRead_cnt(int pcno, int bno) {
		bd.updateRead_cnt(pcno, bno);
	}
	public int update(Board board) {
		return bd.update(board);
	}
	public int insert(Board board) {
		return bd.insert(board);
	}
	public int delete(int pcno, int bno) {
		return bd.delete(pcno, bno);
	}
	public void likesMinus(int bno) {
		bd.likesMinus(bno);
	}
	public void likesPlus(int bno) {
		bd.likesPlus(bno);
	}
	public Board select(int bno) {
		return bd.select(bno);
	}
}
