package com.ch.pc.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class Board_likesDaoImpl implements Board_likesDao {
	@Autowired
	private SqlSessionTemplate sst;

	public int select(int mno, int bno) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("mno", mno);
		map.put("bno", bno);
		return sst.selectOne("board_likesns.select", map);
	}
	public void delete(int mno, int bno) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("mno", mno);
		map.put("bno", bno);
		sst.selectOne("board_likesns.delete", map);
	}
	public void insert(int mno, int bno) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("mno", mno);
		map.put("bno", bno);
		sst.selectOne("board_likesns.insert", map);
	}
	
}
