package com.ch.pc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.pc.dao.Board_replyDao;
import com.ch.pc.model.Board_reply;

@Service
public class Board_replyServiceImpl implements Board_replyService {
	@Autowired
	private Board_replyDao brd;

	public List<Board_reply> list(int pcno, int bno) {
		return brd.list(pcno, bno);
	}
	public void insert(Board_reply board_reply) {
		brd.insert(board_reply);
	}
	public void update(Board_reply board_reply) {
		brd.update(board_reply);
	}
	public void delete(Board_reply board_reply) {
		brd.delete(board_reply);
	}
	public void likesPlus(int rno) {
		brd.likesPlus(rno);
	}
	public void likesMinus(int rno) {
		brd.likesMinus(rno);
	}
	public Board_reply select(int rno) {
		return brd.select(rno);
	}
}
