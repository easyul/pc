package com.ch.pc.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ch.pc.model.Member1;
import com.ch.pc.model.Pc;
import com.ch.pc.service.MemberService;
import com.ch.pc.service.PageBean;
import com.ch.pc.service.PcService;
@Controller
public class AdminController {
	@Autowired
	private PcService ps;
	@Autowired
	private MemberService ms;
	
	@RequestMapping("pcList")
	public String pcList(Pc pc, Model model, String pageNum) {
		int  rowPerPage = 10;
		if (pageNum == null || pageNum.equals("")) pageNum="1";
		int currentPage = Integer.parseInt(pageNum);
		int total = ps.getTotal(pc);
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		pc.setStartRow(startRow);
		pc.setEndRow(endRow);
		List<Pc> pcList = ps.list(pc);
		PageBean pb = new PageBean(currentPage, rowPerPage, total);
		String[] title = {"pc방 이름","위치","정보"};
		
		model.addAttribute("pcList", pcList);
		model.addAttribute("pb", pb);
		model.addAttribute("title", title);
		
		return "/admin/pcList";
	}
	@RequestMapping("pcPermit")
	public String pcPermit(Pc pc, Model model, String pageNum) {
		int result = 0;
		result = ps.permit(pc.getPcno());
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
		return "/admin/pcPermit";
	}
	@RequestMapping("memberList")
	public String memberList(Member1 member1, String pageNum, Model model) {
		int  rowPerPage = 10;
		if (pageNum == null || pageNum.equals("")) pageNum="1";
		int currentPage = Integer.parseInt(pageNum);
		int total = ms.getTotal(member1);
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		member1.setStartRow(startRow);
		member1.setEndRow(endRow);
		PageBean pb = new PageBean(currentPage, rowPerPage, total);
		List<Member1> memberList = ms.list(member1);
		String[] title = {"구별","아이디","이름","닉네임"};

		model.addAttribute("memberList", memberList);
		model.addAttribute("pb", pb);
		model.addAttribute("title", title);
		
		return "/admin/memberList";
	}
}
