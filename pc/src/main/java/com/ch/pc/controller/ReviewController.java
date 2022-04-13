package com.ch.pc.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ch.pc.model.Member1;
import com.ch.pc.model.Review;
import com.ch.pc.service.MemberService;
import com.ch.pc.service.PageBean;
import com.ch.pc.service.ReviewService;
import com.ch.pc.service.Review_likesService;

@Controller
public class ReviewController {
	@Autowired
	private MemberService ms;
	@Autowired
	private ReviewService rs;
	@Autowired
	private Review_likesService rls;
	@RequestMapping("reviewList")
	public String reviewList(Review review , String pageNum, Model model, HttpSession session) {
			Member1 memberSession = (Member1) session.getAttribute("memberSession");
			int  rowPerPage = 5;
			if (pageNum == null || pageNum.equals("")) pageNum="1";
			int currentPage = Integer.parseInt(pageNum);
			int total = rs.getTotal(review);
			int startRow = (currentPage - 1) * rowPerPage + 1;
			int endRow = startRow + rowPerPage - 1;
			review.setStartRow(startRow);
			review.setEndRow(endRow);
			List<Review> list = rs.list(review);
			PageBean pb = new PageBean(currentPage, rowPerPage, total);
			for (Review reviews : list) {
				Member1 member1 = ms.selectMno(reviews.getMno());
				reviews.setNick_name(member1.getNick_name());
				int mno = memberSession.getMno(); 
				int rno = reviews.getRno(); 
				int review_likes = rls.select(mno, rno); 
				
				if(review_likes > 0) { // 추천 했으면
					reviews.setLikesConfirm(1);
				} 
				else if (review_likes == 0) { // 추천 안했으면 
					reviews.setLikesConfirm(0);
				}	
			}
			
			model.addAttribute("list", list);
			model.addAttribute("pb", pb);
			model.addAttribute("memberSession", memberSession);
			model.addAttribute("pageNum", pageNum);
		return "/review/reviewList";
	}
	@RequestMapping("wInsert")
	public String wInsert(Review review) {
		rs.insert(review);
		return "redirect:/reviewList.do?pcno="+review.getPcno(); 
	}
	@RequestMapping("wUpdate")
	public String wUpdate(Review review) {
		rs.update(review);
		return "redirect:/reviewList.do?pcno="+review.getPcno();
	}
	@RequestMapping("wDelete")
	public String wDelete(Review review) {
		rs.delete(review);
		return "redirect:/reviewList.do?pcno="+review.getPcno();
	}
	@RequestMapping("review_likes")
	public String review_likes(Review review, HttpSession session, Model model, String pageNum) {
		Member1 memberSession = (Member1) session.getAttribute("memberSession");
		int mno = memberSession.getMno();
		int rno = review.getRno(); 
		int review_likes = rls.select(mno, rno);
		int result = 0;

		if(review_likes == 0) { 
			rls.insert(mno, rno);
			rs.likesPlus(rno);
			result = 1;
		} else if(review_likes != 0) { 
			rls.delete(mno, rno);
			rs.likesMinus(rno);
		}
		// review 테이블의 현재 likes 조회
		Review review1 = rs.select(rno);
		int pcno = review1.getPcno();

		model.addAttribute("pcno", pcno);
		model.addAttribute("rno", rno);
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);

		return "redirect:/reviewList.do?pcno="+pcno;
	}
	
}
