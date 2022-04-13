package com.ch.pc.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ch.pc.model.Fee;
import com.ch.pc.model.Member1;
import com.ch.pc.model.Pc;
import com.ch.pc.model.Reservation;
import com.ch.pc.service.MemberService;
import com.ch.pc.service.PcService;
import com.ch.pc.service.ReservationService;

@Controller
public class MemberController {
	@Autowired
	private MemberService ms;
	@Autowired
	private JavaMailSender jMailSender;
	@Autowired
	private PcService ps;
	@Autowired
	private ReservationService rs;
	
	@RequestMapping("insertMember")
	public String insertMember(HttpServletRequest request) {
		Date date = new Date(1, 1, 1);
		for (int i = 0; i < 50; i++) {
			Member1 member = new Member1();
			member.setId("아이디"+i);
			member.setPassword(""+i);
			member.setName("이름"+i);
			member.setNick_name("닉네임"+i);
			member.setPhone(""+i);
			member.setGender("m");
			member.setBirth(date);
			member.setEmail(i+"@"+i+".com");
			member.setIdentity("일반회원");
			member.setProfile("1.jfif");
			int result = ms.insert(member);
		}
		return "/exInsert/insertMember";
	}
	
	
	@RequestMapping("joinForm")
	public String joinForm() { 
		return "/member/joinForm";
	}
	@RequestMapping("join")
	public String join(Member1 member1, Model model, HttpSession session) throws IOException {
		int result = 0;
		// form에서 입력한 member1데이터를 가져와서 member2 객체에 대입하여 아이디가 존재하는지 확인
		Member1 member2 = ms.select(member1.getId());
		if (member2 == null) {
			String fileName = member1.getFile().getOriginalFilename();
			String real = session.getServletContext().getRealPath("/resources/upload");
			FileOutputStream fos=new FileOutputStream(new File(real+"/"+fileName));
			fos.write(member1.getFile().getBytes());
			fos.close();
			member1.setProfile(fileName);
			result = ms.insert(member1);
		} else { 
			result = -1; // 아이디 중복
		}
		model.addAttribute("result", result);
		return "/member/join";
	}
	@RequestMapping(value = "confirmId", produces = "text/html;charset=utf-8") 
	@ResponseBody
	public String confirmId(String id) {
		String msg = "";
		Member1 member1 = ms.select(id); 
		if (member1 == null) msg = "1";
		else msg = "0";
		return msg;
	}
	@RequestMapping(value = "confirmNick_name", produces = "text/html;charset=utf-8") 
	@ResponseBody
	public String confirmNick_name(String nick_name) {
		String msg = "";
		Member1 member1 = ms.confirmNick_name(nick_name); 
		if (member1 == null) msg = "1";
		else msg = "0";
		return msg;
	}
	@RequestMapping(value = "confirmEmail", produces = "text/html;charset=utf-8") 
	@ResponseBody
	public String confirmEmail(String email) {
		String msg = "";
		Member1 member1 = ms.confirmEmail(email); 
		if (member1 == null) msg = "1";
		else msg = "0";
		return msg;
	}
	@RequestMapping("loginForm")
	public String loginForm() {
		return "/member/loginForm";
	}
	@RequestMapping("login")
	public String login(Member1 member1, HttpSession session, Model model) {
		Member1 member2 = ms.select(member1.getId());
		int result = 0; // 암호가 일치하지 않는 경우
		if (member2 == null || member2.getDel().equals("y")) {
			result = -1; // DB에 없는 아이디
		}
		else if (member2.getBlacklist().equals("y   ")) {
			result = -2; // blacklist에 추가된 아이디
		}
		else if (member2.getPassword().equals(member1.getPassword())) {
			result = 1;
			//pc방이 승인이 됐는지 안됐는지 확인을 위해
			Pc pc = ps.selectMno(member2.getMno());
			if(pc == null) {
				member2.setPermitConfirm(-1); // 가맹신청을 아직 안했으면 -1
			}else if(pc.getPermit().equals("y")) {	
				member2.setPermitConfirm(1);	// 가맹승인이 되면 1
			}else if(pc.getPermit().equals("n")) {	
				member2.setPermitConfirm(0);	// 가맹승인이 아직이면 0
			}
			
			session.setAttribute("memberSession", member2);// header출력용
		}
		model.addAttribute("result", result);
		return "/member/login";
	}
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "/member/logout";
	}
	@RequestMapping("mypageForm")
	public String mypageForm() {
		return "/member/mypageForm";
	}
	@RequestMapping("findIdForm")
	public String findIdForm() {
		return "/member/findIdForm";
	}
	@RequestMapping("findId")
	public String findIdResult(Member1 member1, Model model) {
		int result = 0;
		Member1 member2 = ms.findId(member1);
		if (member2 != null) {
			result = 1;
			model.addAttribute("member", member2);
		} else {
			result = -1;
		}
		model.addAttribute("result", result);
		return "member/findId";
	}
	@RequestMapping("findPwForm")
	public String findPasswordForm() {
		return "/member/findPwForm";
	}
	// 비밀번호 찾기
	@RequestMapping("findPw")
	public String findPwResult(Member1 member1, Model model) {
		System.out.println("1");
		int result = 0;
		Member1 member2 = ms.findPw(member1);
		if (member2 != null) {
			// 아이디가 존재 할 때 결과 값 1을 반영
			result = 1;
			model.addAttribute("member1", member2);
			// 난수 생성
			String msg = "";
			String code = "";
			Random random = new Random();
			for(int i=0; i<3; i++) {
				int index = random.nextInt(25)+65; //A~Z까지 랜덤 알파벳 생성
				code += (char)index;
			}
			int numIndex = random.nextInt(9999)+1000; //4자리 랜덤 정수 생성
			code += numIndex;		
			msg = (String)code;  //메시지 내용 함수입력
			MimeMessage mm = jMailSender.createMimeMessage();
			try {
				MimeMessageHelper mmh = new MimeMessageHelper(mm, true, "utf-8");
				mmh.setSubject("어데 피씹니까? 임시비밀번호 입니다.");
				mmh.setText("임시비밀번호 : " + msg);
				mmh.setTo(member1.getEmail());
				mmh.setFrom("moyamoyacJ4@gmail.com");
				jMailSender.send(mm);
				System.out.println("여기까지");
				// 이메일이 성공적으로 보내졌으면 멤버 비밀번호를 변경
				member1.setPassword(msg);
				System.out.println("password ="+member1.getPassword());
				int resultUpdatePw = ms.updatePw(member1);
				model.addAttribute("resultUpdatePw", resultUpdatePw);
				System.out.println("result="+result);
				System.out.println("resultUpdatePw="+resultUpdatePw);
				
			} catch (Exception e) {
				result = 0;
				System.out.println("result="+result);
				model.addAttribute("msg", e.getMessage());
			}	
			model.addAttribute("result", result);
		} else {
			result = -1;
			model.addAttribute("result", result);
		}
		return "/member/findPw";
	}
	@RequestMapping("passChkForm")
	public String passChkForm(Model model, HttpSession session) {
		 Member1 memberSession = (Member1)session.getAttribute("memberSession");      
		 Pc pc = ps.selectMno(memberSession.getMno());
	     if(pc != null) {
		     int pcno = pc.getPcno();
		     Fee f1 = ps.selectFee(pcno);
	    	 model.addAttribute("pc",pc);
	    	 model.addAttribute("f1", f1);
	     }	  	     
	     model.addAttribute("memberSession", memberSession);
		return "/member/passChkForm";
	}
	@RequestMapping("passChk")
	public String passChk(Member1 member1, HttpSession session, Model model) {
		Member1 member2 = (Member1)session.getAttribute("memberSession");
		int result = 0;
		if (member2.getPassword().equals(member1.getPassword())) {
			result = 1;
		}
		model.addAttribute("result", result);
		return "/member/passChk";
	}
	@RequestMapping("updateForm")
	public String updateForm(Model model, HttpSession session) {
	      Member1 member = (Member1)session.getAttribute("memberSession");
	      Pc pc = ps.selectMno(member.getMno());
		     if(pc != null) {
			     int pcno = pc.getPcno();
			     Fee f1 = ps.selectFee(pcno);
		    	 model.addAttribute("pc",pc);
		    	 model.addAttribute("f1", f1);
		     }	  	     
		  System.out.println("member="+member);
	      model.addAttribute("member", member);
	      return "/member/updateForm";
	   }
	@RequestMapping(value = "confirmNick_name2", produces = "text/html;charset=utf-8") 
	@ResponseBody
	public String confirmNick_name2(String nick_name, HttpSession session) {
		Member1 member = (Member1)session.getAttribute("memberSession");
		String nick_name1 = member.getNick_name();
		String msg = "";
		Member1 member1 = ms.confirmNick_name(nick_name); 
		if (member1 == null) msg = "1";
		else if (member1.getNick_name().equals(nick_name1)) msg = "1";
		else msg = "0";
		System.out.println(member1.getNick_name());
		return msg;
	}
	@RequestMapping(value = "confirmEmail2", produces = "text/html;charset=utf-8") 
	@ResponseBody
	public String confirmEmail2(String email, HttpSession session) {
		Member1 member = (Member1)session.getAttribute("memberSession");
		String email1 = member.getEmail();
		String msg = "";
		Member1 member1 = ms.confirmEmail(email); 
		if (member1 == null) msg = "1";
		else if (member1.getEmail().equals(email1)) msg = "1";
		else msg = "0";
		return msg;
	}
	@RequestMapping("update")
	public String update(Member1 member1, Model model, HttpSession session) throws IOException {	
		int result = 0;
		System.out.println("member1="+member1);
		// form에서 입력한 member1데이터를 가져와서 member2 객체에 대입하여 아이디가 존재하는지 확인
		Member1 member2 = ms.select(member1.getId());
		System.out.println("mebmer2="+member2);
		if (member2 == null) {
			result = -1;	// 회원정보 없음
		} else {
			String fileName = member1.getFile().getOriginalFilename();
			if(fileName != null && !fileName.equals("")) { // 값이 새로 들어오면
				member1.setProfile(fileName);
				String real = session.getServletContext().getRealPath("/resources/upload");
				FileOutputStream fos = new FileOutputStream(new File(real+"/"+fileName));
				fos.write(member1.getFile().getBytes());
				fos.close();
			}
			result = ms.update(member1);
			Member1 member3 = ms.select(member1.getId());
			session.setAttribute("memberSession", member3);// header출력용
		}
		System.out.println("result="+result);
		model.addAttribute("result", result);
		return "member/update";
	}
	@RequestMapping("blackin")
	public String blackin(Member1 member1, String pageNum, Model model) {
		int result = 0;
		result = ms.blackin(member1.getMno());
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
		return "/admin/blackin";
	}
	@RequestMapping("blackout")
	public String blackout(Member1 member1, String pageNum, Model model) {
		int result = 0;
		result = ms.blackout(member1.getMno());
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
		return "/admin/blackout";
	}
	@RequestMapping("memberDelete")
	public String memberDelete(Member1 member1, String pageNum, Model model) {
		int result = 0;
		result = ms.memberDelete(member1.getMno());
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
		return "/admin/memberDelete";
	}
	
	@RequestMapping("reserveList")
	public String reserveList(Reservation reservation, HttpSession session, Model model, String pageNum) {
		Member1 memberSession = (Member1)session.getAttribute("memberSession");
		 Pc pc = ps.selectMno(memberSession.getMno());
	     if(pc != null) {
		     int pcno = pc.getPcno();
		     Fee f1 = ps.selectFee(pcno);
	    	 model.addAttribute("pc",pc);
	    	 model.addAttribute("f1", f1);
	     }	  	     
		int mno = memberSession.getMno();
		List<Reservation> nList = rs.nList(mno);
		List<Reservation> yList = rs.yList(mno);
		model.addAttribute("mno", mno);
		model.addAttribute("nList", nList);
		model.addAttribute("yList", yList);
		model.addAttribute("pageNum", pageNum);
		
		return "/member/reserveList";
	}
}
