package com.ch.pc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.pc.dao.ReservationDao;
import com.ch.pc.model.Reservation;

@Service
public class ReservationServiceImpl implements ReservationService {
	@Autowired
	private ReservationDao rd;

	//예매내역
	public int getTotal(int mno) {
		return rd.getTotal(mno);
	}
	public List<Reservation> nList(int mno) {
		return rd.nList(mno);
	}
	public List<Reservation> yList(int mno) {
		return rd.yList(mno);
	}
}
