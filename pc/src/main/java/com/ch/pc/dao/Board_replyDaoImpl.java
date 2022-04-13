package com.ch.pc.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.pc.model.Board_reply;

@Repository
public class Board_replyDaoImpl implements Board_replyDao {
	@Autowired
	private SqlSessionTemplate sst;

	public List<Board_reply> list(int pcno, int bno) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("pcno", pcno);
		map.put("bno", bno);
	return sst.selectList("board_replyns.list", map);
	}
	public void insert(Board_reply board_reply) {
		sst.insert("board_replyns.insert", board_reply);
	}
	public void update(Board_reply board_reply) {
		sst.update("board_replyns.update", board_reply);
	}
	public void delete(Board_reply board_reply) {
		sst.update("board_replyns.delete", board_reply);
	}
	public void likesPlus(int rno) {
		sst.update("board_replyns.likesPlus", rno);
	}
	public void likesMinus(int rno) {
		sst.update("board_replyns.likesMinus", rno);
	}
	public Board_reply select(int rno) {
		return sst.selectOne("board_replyns.select", rno);
	}
}
