package com.ch.pc.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.pc.model.Review;

@Repository
public class ReviewDaoImpl implements ReviewDao {
	@Autowired
	private SqlSessionTemplate sst;

	public List<Review> list(Review review) {
		return sst.selectList("reviewns.list", review);
	}

	public void insert(Review review) {
		sst.insert("reviewns.insert", review);
	}
	public void update(Review review) {
		sst.update("reviewns.update", review);
	}
	public void delete(Review review) {
		sst.update("reviewns.delete", review);
	}
	public void likesPlus(int rno) {
		sst.update("reviewns.likesPlus", rno);
	}
	public void likesMinus(int rno) {
		sst.update("reviewns.likesMinus", rno);
	}
	public Review select(int rno) {
		return sst.selectOne("reviewns.select", rno);
	}
	public int getTotal(Review review) {
		return sst.selectOne("reviewns.getTotal", review);
	}

	public double avgRating(int pcno) {
		System.out.println("sst="+sst);
		return sst.selectOne("reviewns.avgRating", pcno);
	}
}
