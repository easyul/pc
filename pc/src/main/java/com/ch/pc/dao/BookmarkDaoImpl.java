package com.ch.pc.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.pc.model.Bookmark;

@Repository
public class BookmarkDaoImpl implements BookmarkDao{
	@Autowired
	private SqlSessionTemplate sst;

	@Override
	public int select(int mno, int pcno) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("mno", mno);
		map.put("pcno", pcno);
		return sst.selectOne("bookmarkns.select",map);
	}

	@Override
	public void delete(int mno, int pcno) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("mno", mno);
		map.put("pcno", pcno);
		sst.delete("bookmarkns.delete",map);
		
	}

	@Override
	public void insert(int mno, int pcno) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("mno", mno);
		map.put("pcno", pcno);
		sst.insert("bookmarkns.insert",map);
		
	}
	
	public int getTotalMybookmark(int mno) {
		return sst.selectOne("bookmarkns.getTotalMybookmark", mno);
	}
	public List<Bookmark> mybookmarkList(int mno, int startRow, int endRow) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("mno", mno);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return sst.selectList("bookmarkns.mybookmarkList", map);
	}
}
