package com.ch.pc.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ch.pc.model.Keyword;
import com.ch.pc.model.Location;
import com.ch.pc.model.Pc;
import com.ch.pc.service.PcService;

@Controller
public class MainController {
	@Autowired
	private PcService ps;
	
	@SuppressWarnings("null")
	@RequestMapping("main")
	public String main(Location location, Model model, Keyword keyword) {		
		
		if(location.getSido() == null || location.getSido().equals("")) {
			location.setSido("서울특별시");
			location.setSigugun("이대역");
		}
		List<Pc> listsearch = ps.searchpc(keyword);
		System.out.println();
		model.addAttribute("listsearch", listsearch);
		model.addAttribute("location", location);
		return "/main/main";
	}
	
	
	@RequestMapping("sessionChk")
	public String sessionChk() {
		return "/main/sessionChk";
	}
}