package com.ch.pc.service;

import java.util.List;

import com.ch.pc.model.Fee;
import com.ch.pc.model.Pc;
import com.ch.pc.model.Pcimage;
import com.ch.pc.model.Reservation;
import com.ch.pc.model.Seat;

import com.ch.pc.model.Keyword;

public interface PcService {

	List<Pc> selectPcbnm(String pcbusinessnum);

	List<Pc> selectPcpno(String pcpno);

	int insertPc(Pc pc);

	int givePcno();

	void insertPcimage(List<Pcimage> images);

	Pc select(int pcno);

	List<Pcimage> listPhoto(int pcno);

	int permit(int pcno);

	List<Pc> listMap();

	int getTotal(Pc pc);

	List<Pc> list(Pc pc);

	String listSeat(int pcno);

	int updateSeatform(Pc pc);

	Seat selectseat(int pcno);

	int insertSeat(Seat seat);

	int updateSeat(Seat seat);

	Pc selectMno(int mno);

	int updatePc(Pc pc);

	void deletePcimage(List<Pcimage> images);
	
	//
	int feeInsert(Fee fee);

	Fee selectFee(int pcno);

	int feeUpdate(Fee fee);

	int insertReservation(Reservation reservation);

	List<Reservation> reserveList(int pcno);

	List<Reservation> allReserveList();

	void expired(int reserveno);

	List<Pc> searchpc(Keyword keyword);

}
