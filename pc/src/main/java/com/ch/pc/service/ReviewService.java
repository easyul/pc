package com.ch.pc.service;

import java.util.List;

import com.ch.pc.model.Review;

public interface ReviewService {


	void insert(Review review);

	void update(Review review);

	void delete(Review review);

	void likesPlus(int rno);

	void likesMinus(int rno);

	Review select(int rno);
	
	List<Review> list(Review review);

	int getTotal(Review review);

	double avgRating(int pcno);

}
