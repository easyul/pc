package com.ch.pc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.pc.dao.PcDao;
import com.ch.pc.model.Fee;
import com.ch.pc.model.Pc;
import com.ch.pc.model.Pcimage;
import com.ch.pc.model.Reservation;
import com.ch.pc.model.Seat;

import com.ch.pc.model.Keyword;

@Service
public class PcServiceImpl implements PcService {	
	@Autowired
	private PcDao pd;
	
	public List<Pc> selectPcbnm(String pcbusinessnum) {
		return pd.selectPcbnm(pcbusinessnum);
	}
	public List<Pc> selectPcpno(String pcpno) {
		return pd.selectPcpno(pcpno);
	}
	public int insertPc(Pc pc) {
		return pd.insertPc(pc);
	}
	public int givePcno() {
		return pd.givePcno();
	}
	public void insertPcimage(List<Pcimage> images) {
		for(Pcimage pi : images) {
			pd.insertPi(pi);
		}
	}
	public Pc select(int pcno) {
		return pd.select(pcno);
	}
	public List<Pcimage> listPhoto(int pcno) {
		return pd.listPhoto(pcno);
	}

	// 관리자
	public List<Pc> list(Pc pc) { 
		return pd.list(pc);
	}
	public int permit(int pcno) { 
		return pd.permit(pcno);
	}
	public int getTotal(Pc pc) {
		return pd.getTotal(pc);
	}
	public List<Pc> listMap() {
		return pd.listMap();
	}
	
	//좌석예약
	public String listSeat(int pcno) {
		return pd.listSeat(pcno);
	}
	public int updateSeatform(Pc pc) {
		return pd.updateseatform(pc);
	}
	public Seat selectseat(int pcno) {
		return pd.selectseat(pcno);
	}
	public int insertSeat(Seat seat) {
		return pd.insertSeat(seat);
	}
	public int updateSeat(Seat seat) {
		return pd.updateseat(seat);
	}
	public Pc selectMno(int mno) {
		return pd.selectMno(mno);
	}
	
	//pc방 수정
	public int updatePc(Pc pc) {
		return pd.updatePc(pc);
	}

	public void deletePcimage(List<Pcimage> images) {
		for(Pcimage pi : images) {
			pd.deletePi(pi);
		}
	}	
	//
	@Override
	public int feeInsert(Fee fee) {
		return pd.feeInsert(fee);
	}
	@Override
	public Fee selectFee(int pcno) {
		return pd.selectFee(pcno);
	}
	@Override
	public int feeUpdate(Fee fee) {
		return pd.feeUpdate(fee);
	}
	@Override
	public int insertReservation(Reservation reservation) {
		return pd.insertReservation(reservation);
	}
	@Override
	public List<Reservation> reserveList(int pcno) {
		return pd.reserveList(pcno);
	}
	@Override
	public List<Reservation> allReserveList() {
		return pd.allReserveList();
	}
	@Override
	public void expired(int reserveno) {
		pd.expired(reserveno);
		
	}
	@Override
	public List<Pc> searchpc(Keyword keyword) {
		return pd.searchpc(keyword);
	}
	
}
