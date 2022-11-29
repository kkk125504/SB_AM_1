package com.kjh.exam.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kjh.exam.demo.repository.MemberRepository;
import com.kjh.exam.demo.util.Ut;
import com.kjh.exam.demo.vo.Member;
import com.kjh.exam.demo.vo.ResultData;

@Service
public class MemberService {

	private MemberRepository memberRepository;
	private AttrService attrService;

	@Autowired
	MemberService(MemberRepository memberRepository, AttrService attrService) {
		this.memberRepository = memberRepository;
		this.attrService = attrService;
	}

	public ResultData<Integer> doJoin(String loginId, String loginPw, String name, String nickname, String cellphoneNum,
			String email) {
		Member existsMember = getMemberByLoginId(loginId);
		if (existsMember != null) {
			return ResultData.from("F-7", Ut.f("중복되는 아이디(%s)가 있습니다", loginId));
		}
		existsMember = getMemberByNameAndEmail(name, email);
		if (existsMember != null) {
			return ResultData.from("F-8", Ut.f("중복되는 이름(%s)과 이메일(%s)이 있습니다", name, email));
		}

		loginPw = Ut.sha256(loginPw);
		memberRepository.doJoin(loginId, loginPw, name, nickname, cellphoneNum, email);
		int id = memberRepository.getLastInsertId();

		return ResultData.from("S-1", Ut.f("%s님 회원가입 성공", nickname), "id", id);
	}

	public Member getMemberById(int id) {
		Member member = memberRepository.getMemberById(id);
		return member;
	}

	public Member getMemberByLoginId(String loginId) {
		Member member = memberRepository.getMemberByLoginId(loginId);
		return member;
	}

	private Member getMemberByNameAndEmail(String name, String email) {
		Member member = memberRepository.getMemberByNameAndEmail(name, email);
		return member;
	}

	public ResultData modify(int actorId, String loginPw, String nickname, String cellphoneNum, String email) {
		loginPw = Ut.sha256(loginPw);
		memberRepository.modify(actorId, loginPw, nickname, cellphoneNum, email);
		return ResultData.from("S-1", "회원정보가 수정 되었습니다.");
	}

	public String genMemberModifyAuthKey(int actorId) {
		String memberModifyAuthKey = Ut.getTempPassword(10);

		attrService.setValue("member", actorId, "extra", "memberModifyAuthKey", memberModifyAuthKey,
				Ut.getDateStrLater(60 * 5));

		return memberModifyAuthKey;
	}

	public ResultData checkMemberModifyAuthKey(int actorId, String memberModifyAuthKey) {
		String saved = attrService.getValue("member", actorId, "extra", "memberModifyAuthKey");

		if (!saved.equals(memberModifyAuthKey)) {
			return ResultData.from("F-1", "일치하지 않거나 만료되었습니다");
		}
		return ResultData.from("S-1", "정상 코드입니다");
	}
}
