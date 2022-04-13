package com.ch.pc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.pc.dao.ReviewDao;
import com.ch.pc.model.Review;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	private ReviewDao rd;

	public List<Review> list(Review review) {
		return rd.list(review);
	}
	public void insert(Review review) {
		rd.insert(review);
	}
	public void update(Review review) {
		rd.update(review);
	}
	public void delete(Review review) {
		rd.delete(review);
	}
	public void likesPlus(int rno) {
		rd.likesPlus(rno);
	}
	public void likesMinus(int rno) {
		rd.likesMinus(rno);
	}
	public Review select(int rno) {
		return rd.select(rno);
	}
	public int getTotal(Review review) {
		return rd.getTotal(review);
	}

	public double avgRating(int pcno) {
		return rd.avgRating(pcno);
	}
}
