package com.kjh.exam.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kjh.exam.demo.repository.MemberRepository;

@Service
public class MemberService {

	private MemberRepository memberRepository;

	@Autowired
	MemberService(MemberRepository memberRepository) {
		this.memberRepository = memberRepository;
	}

	public void doJoin(String loginId, String loginPw, String name, String nickname, String cellphoneNum,
			String email) {
		memberRepository.doJoin(loginId, loginPw, name, nickname, cellphoneNum, email);
	}
}
