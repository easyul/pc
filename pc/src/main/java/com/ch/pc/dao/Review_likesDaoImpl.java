package com.ch.pc.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class Review_likesDaoImpl implements Review_likesDao {
	@Autowired
	private SqlSessionTemplate sst;

	// 추천한 적이 있는지 조회
	public int select(int mno, int rno) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("mno", mno);
		map.put("rno", rno);
	return sst.selectOne("review_likesns.select", map);
	}
	public void insert(int mno, int rno) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("mno", mno);
		map.put("rno", rno);
	sst.selectOne("review_likesns.insert", map);
	}
	public void delete(int mno, int rno) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("mno", mno);
		map.put("rno", rno);
	sst.selectOne("review_likesns.delete", map);
	}
}
