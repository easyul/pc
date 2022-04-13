package com.ch.pc.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ch.pc.model.Board_reply;
import com.ch.pc.model.Member1;
import com.ch.pc.service.Board_replyService;
import com.ch.pc.service.MemberService;
import com.ch.pc.service.Reply_likesService;

@Controller
public class ReplyController {
	@Autowired
	private MemberService ms;
	@Autowired
	private Board_replyService brs;
	@Autowired
	private Reply_likesService rls;

	@RequestMapping("replyList")
	public String replyList(Board_reply board_reply, String pageNum, Model model, HttpSession session) {
		Member1 memberSession = (Member1) session.getAttribute("memberSession");
		List<Board_reply> list = brs.list(board_reply.getPcno(), board_reply.getBno());
		for (Board_reply reply : list) {
			Member1 member1 = ms.selectMno(reply.getMno());
			reply.setNick_name(member1.getNick_name());
			/*-----------댓글 추천유무 구현-----------------*/			
			int mno = memberSession.getMno(); 
			int rno = reply.getRno(); 
			int reply_likes = rls.select(mno, rno); 
			
			if(reply_likes > 0) { // 추천 했으면
				reply.setLikesConfirm(1);
			} 
			else if (reply_likes == 0) { // 추천 안했으면 
				reply.setLikesConfirm(0);
			}	
			/*-----------댓글 추천유무 구현 끝-----------------*/
		}
		
		model.addAttribute("memberSession", memberSession);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("list", list);
		return "/board/replyList";
	}
	@RequestMapping("rInsert")
	public String rInsert(Board_reply board_reply) {
		brs.insert(board_reply);
		return "redirect:/replyList.do?pcno="+board_reply.getPcno()+"&bno="+board_reply.getBno();
	}
	@RequestMapping("rUpdate")
	public String rUpdate(Board_reply board_reply) {
		brs.update(board_reply);
		return "redirect:/replyList.do?pcno="+board_reply.getPcno()+"&bno="+board_reply.getBno();
	}
	@RequestMapping("rDelete")
	public String rDelete(Board_reply board_reply) {
		brs.delete(board_reply);
		return "redirect:/replyList.do?pcno="+board_reply.getPcno()+"&bno="+board_reply.getBno();
	}
	@RequestMapping("reply_likes")
	public String reply_likes(Board_reply board_reply, HttpSession session, Model model, String pageNum) {
		Member1 memberSession = (Member1) session.getAttribute("memberSession");
		int mno = memberSession.getMno();
		int rno = board_reply.getRno(); 
		int reply_likes = rls.select(mno, rno);
		int result = 0;

		if(reply_likes == 0) { 
			rls.insert(mno, rno);
			brs.likesPlus(rno);
			result = 1;
		} else if(reply_likes != 0) { 
			rls.delete(mno, rno);
			brs.likesMinus(rno);
		}
		// board_reply 테이블의 현재 likes 조회
		Board_reply board_reply1 = brs.select(rno);
		int pcno = board_reply1.getPcno();
		int bno = board_reply1.getBno();

		model.addAttribute("pcno", pcno);
		model.addAttribute("bno", bno);
		model.addAttribute("rno", rno);
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);

		return "redirect:/replyList.do?pcno="+pcno+"&bno="+bno;
	}
}
