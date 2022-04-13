package com.ch.pc.dao;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.pc.model.Member1;

@Repository
public class MemberDaoImpl implements MemberDao {
	@Autowired
	private SqlSessionTemplate sst;

	public int insert(Member1 member1) {
		return sst.insert("member1ns.insert", member1);
	}
	public Member1 select(String id) {
		return sst.selectOne("member1ns.select",id);
	}
	public Member1 confirmNick_name(String nick_name) {
		return sst.selectOne("member1ns.confirmNick_name", nick_name);
	}
	public Member1 confirmEmail(String email) {
		return sst.selectOne("member1ns.confirmEmail", email);
	}
	public Member1 findId(Member1 member1) {
		return sst.selectOne("member1ns.findId", member1);
	}
	public Member1 findPw(Member1 member1) {
		return sst.selectOne("member1ns.findPw", member1);
	}
	public int updatePw(Member1 member1) {
		return sst.update("member1ns.updatePw", member1);
	}
	public int update(Member1 member1) {
		return sst.update("member1ns.update", member1);
	}
	public Member1 selectMno(int mno) {
		return sst.selectOne("member1ns.selectMno", mno);
	}
	//점주관리
	public List<Member1> list(Member1 member1) {
		return sst.selectList("member1ns.memberList", member1);
	}
	public int getTotal(Member1 member1) {
		return sst.selectOne("member1ns.getTotal", member1);
	}
	public int blackin(int mno) {
		return sst.update("member1ns.blackin", mno);
	}
	public int blackout(int mno) {
		return sst.update("member1ns.blackout", mno);
	}
	public int memberDelete(int mno) {
		return sst.update("member1ns.memberDelete",mno);
	}

}
