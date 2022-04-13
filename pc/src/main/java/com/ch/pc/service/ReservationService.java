package com.ch.pc.service;

import java.util.List;

import com.ch.pc.model.Reservation;

public interface ReservationService {

	int getTotal(int mno);

	List<Reservation> nList(int mno);
	List<Reservation> yList(int mno);

}
