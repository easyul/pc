package com.ch.pc.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ch.pc.model.Fee;
import com.ch.pc.model.Member1;
import com.ch.pc.model.Pc;
import com.ch.pc.service.PcService;
	
@Controller
public class FeeController {
	@Autowired
	private PcService ps;
	
	
	
	@RequestMapping("feeUpdateForm")
	public String feeUpdate(Model model, HttpSession session) {
		Member1 member = (Member1)session.getAttribute("memberSession");
		Pc pc = ps.selectMno(member.getMno());
	    int pcno = pc.getPcno();    
		Fee fee = ps.selectFee(pcno);
		model.addAttribute("pcno",pcno);
		model.addAttribute("fee", fee);
		return "/fee/feeUpdateForm";
	}
	
	@RequestMapping("feeUpdate")
	public String feeUpdate(Fee fee, Model model, HttpSession session) {
		Member1 member = (Member1)session.getAttribute("memberSession"); 
		Pc pc = ps.selectMno(member.getMno());
	    int pcno = pc.getPcno();
	    Fee f1 = ps.selectFee(pcno);
	    fee.setPcno(pcno);
	    int result = 0;
	    
	    if(f1 == null) {
	    	result = ps.feeInsert(fee);
	    } else {	    	
	    	result = ps.feeUpdate(fee);
	    }
		model.addAttribute("pcno",pcno);
		model.addAttribute("result", result);
		return "/fee/feeUpdate";
	}
}
