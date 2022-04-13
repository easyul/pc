package com.ch.pc.dao;

import java.util.List;

import com.ch.pc.model.Fee;
import com.ch.pc.model.Pc;
import com.ch.pc.model.Pcimage;
import com.ch.pc.model.Reservation;
import com.ch.pc.model.Seat;

import com.ch.pc.model.Keyword;

public interface PcDao {
	List<Pc> selectPcbnm(String pcbusinessnum);

	List<Pc> selectPcpno(String pcpno);

	int insertPc(Pc pc);

	int givePcno();

	void insertPi(Pcimage pi);

	Pc select(int pcno);

	List<Pcimage> listPhoto(int pcno);

	List<Pc> list(Pc pc);

	int permit(int pcno);

	int getTotal(Pc pc);

	List<Pc> listMap();

	String listSeat(int pcno);

	int updateseatform(Pc pc);

	Seat selectseat(int pcno);

	int insertSeat(Seat seat);

	int updateseat(Seat seat);

	Pc selectMno(int mno);

	int updatePc(Pc pc);

	void deletePi(Pcimage pi);

	int feeInsert(Fee fee);

	Fee selectFee(int pcno);

	int feeUpdate(Fee fee);

	int insertReservation(Reservation reservation);

	List<Reservation> reserveList(int pcno);
	
	List<Reservation> allReserveList();

	void expired(int reserveno);

	List<Pc> searchpc(Keyword keyword);

}
