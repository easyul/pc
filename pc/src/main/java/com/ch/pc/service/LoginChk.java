package com.ch.pc.service;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
public class LoginChk extends HandlerInterceptorAdapter{
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		if (session.getAttribute("memberSession") == null) {
			System.out.println("세션체크 테스트");
			response.sendRedirect("sessionChk.do");
			// 원래 요청한 작업을 취소
			return false;
		}
		return true;
	}
}