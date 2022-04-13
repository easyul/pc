package com.ch.pc.service;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.ch.pc.model.Reservation;
public class ExpiredReservation extends HandlerInterceptorAdapter{
	@Autowired
	private PcService ps;
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		LocalTime now = LocalTime.now();
		LocalDate nowDay = LocalDate.now();

		int currentMin = now.getMinute();
		int currentHour = now.getHour();
		int currentDay = nowDay.getDayOfMonth();
		
		List<Reservation> allreservelist = ps.allReserveList();

		for(Reservation reservation : allreservelist) {
			Date regdate = reservation.getReg_date(); 
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd");
			String starttime = reservation.getStarttime();
			String Shour = starttime.substring(0, 2);
			String Smin = starttime.substring(3, 5);
			
			int IShour = Integer.parseInt(Shour);
			int ISmin = Integer.parseInt(Smin);
			int reservetime = reservation.getReservetime();	//예약 시간 (분) 돈
			
			int absolEndtime = IShour*60 + ISmin + reservetime;
			int plusDay = 0;
			
			if(absolEndtime > 24*60) {
				plusDay = absolEndtime/1440;
			}
			
			String startDay = simpleDateFormat.format(regdate);//예약했을때의 날짜
			
			int endDay = Integer.parseInt(startDay)+ plusDay;
			
			String endtime = reservation.getEndtime();
			String endhour = endtime.substring(0, 2);
			String endmin = endtime.substring(3, 5);
			
			int iEndhour = Integer.parseInt(endhour);
			int iEndMin = Integer.parseInt(endmin);
			int endHourToMin = iEndhour*60;
			int endDayToMin = endDay*1440;
			
			int currentHourToMin = currentHour*60;
			int currentDayToMin = currentDay*1440;
			
			if(endDayToMin + endHourToMin + iEndMin  <= currentDayToMin+currentHourToMin+currentMin ) {
				ps.expired(reservation.getReserveno());
				System.out.println(reservation.getReserveno()+"가 만료되었습니다.");
			}
		}	
		return true;
	}
}