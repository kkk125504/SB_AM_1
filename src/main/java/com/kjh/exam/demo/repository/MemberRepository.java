package com.kjh.exam.demo.repository;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberRepository {

	void doJoin(String loginId, String loginPw, String name, String nickname, String cellphoneNum, String email);
}
