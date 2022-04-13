package com.ch.pc.dao;

import java.util.List;

import com.ch.pc.model.Reservation;

public interface ReservationDao {

	int getTotal(int mno);

	List<Reservation> nList(int mno);
	
	List<Reservation> yList(int mno);

}
