package com.ch.pc.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ch.pc.model.Board;
import com.ch.pc.model.Member1;
import com.ch.pc.service.BoardService;
import com.ch.pc.service.Board_likesService;
import com.ch.pc.service.Board_replyService;
import com.ch.pc.service.MemberService;
import com.ch.pc.service.PageBean;

@Controller
public class BoardController {
	@Autowired
	private BoardService bs;
	@Autowired
	private MemberService ms;
	@Autowired
	private Board_replyService brs;
	@Autowired
	private Board_likesService bls;
	
	@RequestMapping("boardList")
	public String boardList(Board board, String pageNum, Model model) {
		int  rowPerPage = 10;
		if (pageNum == null || pageNum.equals("")) pageNum="1";
		int currentPage = Integer.parseInt(pageNum);
		int total = bs.getTotal(board);
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		board.setStartRow(startRow);
		board.setEndRow(endRow);
		List<Board> list = bs.list(board);
		PageBean pb = new PageBean(currentPage, rowPerPage, total);
		String[] title = {"제목","작성자","내용"};
		
		for(Board board1:list) {
			Member1 member1 = ms.selectMno(board1.getMno());
			if(member1 != null) {
				board1.setNick_name(member1.getNick_name());
			}
		}		
		model.addAttribute("list", list);
		model.addAttribute("pb", pb);		
		model.addAttribute("title", title);
		return "/board/boardList";
	}
	@RequestMapping("content")
	public String content(Member1 member1, Board board, String pageNum, Model model, HttpSession session) {
		bs.updateRead_cnt(board.getPcno(), board.getBno());      // 조회수 증가
		Board board2 = bs.select(board.getPcno(), board.getBno());
		board2.setSearchKey(board.getSearchKey());
		board2.setSearchValue(board.getSearchValue());
		Member1 memberSession = (Member1)session.getAttribute("memberSession");

		int mno1 = board2.getMno();
		Member1 member2 = ms.selectMno(mno1);
		String nick_name = member2.getNick_name(); 	
		
		String imgSrc = "";
			int mno = memberSession.getMno();
			int bno = board.getBno();
			int board_likes = bls.select(mno, bno);
			if(board_likes > 0) {
				imgSrc = "/pc/resources/images/heart.png";
			} else if (board_likes == 0) {
				imgSrc = "/pc/resources/images/empty_heart.png";
			}
		model.addAttribute("memberSession", memberSession);
		model.addAttribute("board", board2);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("imgSrc", imgSrc);
		model.addAttribute("nick_name", nick_name);
		return "/board/content";
	}
	@RequestMapping("insertForm")
	public String insertForm(Board board, String pageNum, Model model) {	
		model.addAttribute("board", board);		
		model.addAttribute("pageNum", pageNum);
		return "/board/insertForm";
	}
	@RequestMapping("insert")
	public String insert(Board board, String pageNum, Model model, HttpSession session) {
		int result = 0;
		Member1 member1 = (Member1)session.getAttribute("memberSession");
		int mno = member1.getMno();
		board.setMno(mno);
		result = bs.insert(board);
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
		return "/board/insert";
	}
	@RequestMapping("boardUpdateForm")
	public String boardUpdateForm(Board board, String pageNum, Model model) {
		Board board2 = bs.select(board.getPcno(), board.getBno());
		Member1 member1 = ms.selectMno(board2.getMno());
		board2.setNick_name(member1.getNick_name());
		
		model.addAttribute("board", board2);
		model.addAttribute("pageNum", pageNum);
		return "/board/boardUpdateForm";
	}
	@RequestMapping("boardUpdate")
	public String boardUpdate(Board board, String pageNum, Model model) {
		int result = 0;
		result = bs.update(board); 
		
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
		return "/board/boardUpdate";
	}
	@RequestMapping("boardDelete")
	public String boardDelete(Board board, String pageNum, Model model) {
		int result = 0;
		result = bs.delete(board.getPcno(), board.getBno());
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
		return "/board/boardDelete";
	}
	@RequestMapping("board_likes")
	public String board_likes(Board board, Model model, HttpSession session) {
		Member1 member1 = (Member1) session.getAttribute("memberSession");
		int mno = member1.getMno();
		int bno = board.getBno();
		int board_likes = bls.select(mno, bno);
		String imgSrc = "";
		int likes = 0;
		if(board_likes > 0) {
			bls.delete(mno, bno);
			bs.likesMinus(bno);
			imgSrc = "/pc/resources/images/empty_heart.png";
		} else if(board_likes == 0) {
			bls.insert(mno, bno);
			bs.likesPlus(bno);
			imgSrc = "/pc/resources/images/heart.png";
		}
		// board 테이블의 현재 likes 조회
		Board board1 = bs.select(bno);
		likes = board1.getLikes();
		
		model.addAttribute("likes", likes);
		model.addAttribute("imgSrc", imgSrc);
		
		return "/board/board_likes";
	}
}
