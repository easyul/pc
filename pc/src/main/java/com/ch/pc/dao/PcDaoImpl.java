package com.ch.pc.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.pc.model.Fee;
import com.ch.pc.model.Pc;
import com.ch.pc.model.Pcimage;
import com.ch.pc.model.Reservation;
import com.ch.pc.model.Seat;
import com.ch.pc.model.Keyword;

@Repository
public class PcDaoImpl implements PcDao {	
	@Autowired
	private SqlSessionTemplate sst;

	public List<Pc> selectPcbnm(String pcbusinessnum) {
		return sst.selectList("pcns.selectPcbnm", pcbusinessnum);
	}
	public List<Pc> selectPcpno(String pcpno) {
		return sst.selectList("pcns.selectPcpno", pcpno);
	}
	public int insertPc(Pc pc) {
		return sst.insert("pcns.insertPc", pc);
	}
	public int givePcno() {
		return sst.selectOne("pcns.givePcno");
	}
	public void insertPi(Pcimage pi) {
		sst.insert("pcns.insertPi", pi);
	}
	public Pc select(int pcno) {
		return sst.selectOne("pcns.select", pcno);
	}
	public List<Pcimage> listPhoto(int pcno) {
		return sst.selectList("pcns.listPhoto", pcno);
	}
	@Override
	public List<Pc> listMap() {
		return sst.selectList("pcns.listMap");
	}
	//관리자
	public List<Pc> list(Pc pc) {
		return sst.selectList("pcns.pcList", pc);
	}
	public int permit(int pcno) {
		return sst.update("pcns.permit", pcno);
	}
	public int getTotal(Pc pc) {
		return sst.selectOne("pcns.getTotal", pc);
	}
	@Override
	public String listSeat(int pcno) {
		return sst.selectOne("pcns.listSeat", pcno);
	}
	@Override
	public int updateseatform(Pc pc) {
		return sst.update("pcns.updateseatform", pc);
	}
	@Override
	public Seat selectseat(int pcno) {
		return sst.selectOne("pcns.selectSeat", pcno);
	}
	@Override
	public int insertSeat(Seat seat) {
		return sst.insert("pcns.insertSeat", seat);
	}
	@Override
	public int updateseat(Seat seat) {
		return sst.update("pcns.updateSeat", seat);
	}
	@Override
	public Pc selectMno(int mno) {
		return sst.selectOne("pcns.selectMno", mno);
	}
	@Override
	public int updatePc(Pc pc) {
		return sst.update("pcns.updatePc", pc);
	}
	@Override
	public void deletePi(Pcimage pi) {
		sst.delete("pcns.deletePi", pi);
	}
	// 요금설정
	@Override
	public int feeInsert(Fee fee) {
		return sst.insert("feens.feeInsert", fee);
	}
	@Override
	public Fee selectFee(int pcno) {
		return sst.selectOne("feens.selectFee", pcno);
	}
	@Override
	public int feeUpdate(Fee fee) {
		return sst.update("feens.feeUpdate", fee);
	}
	// 예약 입력
	@Override
	public int insertReservation(Reservation reservation) {
		return sst.insert("reservationns.insertReservation", reservation);
	}
	@Override
	public List<Reservation> reserveList(int pcno) {
		return sst.selectList("reservationns.reserveList", pcno);
	}
	public List<Reservation> allReserveList() {
		return sst.selectList("reservationns.allReserveList");
	}
	@Override
	public void expired(int reserveno) {
		sst.update("reservationns.expired",reserveno);	
	}
	@Override
	public List<Pc> searchpc(Keyword keyword) {
		return sst.selectList("pcns.searchpc", keyword);
	}


}
