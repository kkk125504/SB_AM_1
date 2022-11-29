package com.kjh.exam.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kjh.exam.demo.service.MemberService;
import com.kjh.exam.demo.util.Ut;
import com.kjh.exam.demo.vo.Member;
import com.kjh.exam.demo.vo.ResultData;
import com.kjh.exam.demo.vo.Rq;

@Controller
public class UsrMemberController {

	@Autowired
	private MemberService memberService;
	@Autowired
	private Rq rq;

	// 액션 메소드
	@RequestMapping("/usr/member/join")
	public String showJoin() {
		return "usr/member/join";
	}
	
	@RequestMapping("usr/member/doJoin")
	@ResponseBody
	public String doJoin(String loginId, String loginPw, String name, String nickname, String cellphoneNum,
			String email, @RequestParam(defaultValue = "/") String afterLoginUri) {

		if (Ut.empty(loginId)) {
			return rq.jsHistoryBack("F-1", "아이디를 입력해주세요");
		}
		if (Ut.empty(loginPw)) {
			return rq.jsHistoryBack("F-2", "비밀번호를 입력 해주세요.");
		}
		if (Ut.empty(name)) {
			return rq.jsHistoryBack("F-3", "이름을 입력 해주세요.");
		}
		if (Ut.empty(nickname)) {
			return rq.jsHistoryBack("F-4", "닉네임 입력 해주세요.");
		}
		if (Ut.empty(cellphoneNum)) {
			return rq.jsHistoryBack("F-5", "전화번호를 입력 해주세요.");
		}
		if (Ut.empty(email)) {
			return rq.jsHistoryBack("F-6", "이메일을 입력 해주세요.");
		}

		ResultData<Integer> joinRd = memberService.doJoin(loginId, loginPw, name, nickname, cellphoneNum, email);

		if (joinRd.isFail()) {
			return rq.jsHistoryBack(joinRd.getResultCode(), joinRd.getMsg());
		}

		String afterJoinUri = "../member/login?afterLoginUri=" + Ut.getUriEncoded(afterLoginUri);
		return rq.jsReplace("회원가입이 완료되었습니다. 로그인 후 이용해주세요", afterJoinUri);
	}

	@RequestMapping("usr/member/login")
	public String showLogin() {
		return "usr/member/login";
	}

	@RequestMapping("usr/member/doLogin")
	@ResponseBody
	public String doLogin(String loginId, String loginPw, @RequestParam(defaultValue = "/") String afterLoginUri) {

		if (rq.isLogined()) {
			return Ut.jsHistoryBack("이미 로그인 되었습니다.");
		}

		if (Ut.empty(loginId)) {
			return Ut.jsHistoryBack("아이디를 입력 해주세요.");
		}

		if (Ut.empty(loginPw)) {
			return Ut.jsHistoryBack("비밀번호를 입력 해주세요.");
		}

		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			return Ut.jsHistoryBack(Ut.f("해당하는 아이디(%s)를 찾을수 없습니다.", loginId));
		}
		if (member.getLoginPw().equals(loginPw) == false) {
			return Ut.jsHistoryBack("비밀번호가 일치하지 않습니다.");
		}
		rq.login(member);

		return Ut.jsReplace(Ut.f("%s님 환영합니다.", member.getName()), afterLoginUri);
	}

	@RequestMapping("usr/member/doLogout")
	@ResponseBody
	public String doLogout(@RequestParam(defaultValue = "/") String afterLogoutUri) {

		if (rq.isLogined() == false) {
			return Ut.jsHistoryBack("로그아웃 상태 입니다.");
		}
		rq.logout();

		return Ut.jsReplace("로그아웃 했습니다.", afterLogoutUri);
	}

	@RequestMapping("/usr/member/myPage")
	public String showMyPage() {

		return "usr/member/myPage";
	}

	@RequestMapping("/usr/member/checkPassword")
	public String showCheckPassword() {
		return "usr/member/checkPassword";
	}

	@RequestMapping("/usr/member/doCheckPassword")
	@ResponseBody
	public String doCheckPassword(String loginPw, String replaceUri) {
		if (Ut.empty(loginPw)) {
			return rq.jsHistoryBack("비밀번호를 입력하세요.");
		}

		if (rq.getLoginedMember().getLoginPw().equals(loginPw) == false) {
			return rq.jsHistoryBack("비밀번호가 일치하지 않습니다.");
		}

		if (replaceUri.equals("../member/modify")) {
			String memberModifyAuthKey = memberService.genMemberModifyAuthKey(rq.getLoginedMemberId());

			replaceUri += "?memberModifyAuthKey=" + memberModifyAuthKey;
		}

		return rq.jsReplace("비밀번호 확인", replaceUri);
	}

	@RequestMapping("/usr/member/modify")
	public String showModify(String memberModifyAuthKey) {
		if (Ut.empty(memberModifyAuthKey)) {
			return rq.jsHistoryBackOnView("인증코드가 없거나 만료 되었습니다.");
		}
		ResultData checkMemberModifyAuthKeyRd = memberService.checkMemberModifyAuthKey(rq.getLoginedMemberId(),
				memberModifyAuthKey);

		if (checkMemberModifyAuthKeyRd.isFail()) {
			return rq.jsHistoryBackOnView(checkMemberModifyAuthKeyRd.getMsg());
		}
		return "usr/member/modify";
	}

	@RequestMapping("/usr/member/doModify")
	@ResponseBody
	public String doModify(String loginPw, String nickname, String cellphoneNum, String email,
			String memberModifyAuthKey) {

		if (Ut.empty(memberModifyAuthKey)) {
			return rq.jsHistoryBackOnView("인증코드가 없거나 만료 되었습니다.");
		}
		ResultData checkMemberModifyAuthKeyRd = memberService.checkMemberModifyAuthKey(rq.getLoginedMemberId(),
				memberModifyAuthKey);

		if (checkMemberModifyAuthKeyRd.isFail()) {
			return rq.jsHistoryBackOnView(checkMemberModifyAuthKeyRd.getMsg());
		}

		ResultData modifyRd = memberService.modify(rq.getLoginedMemberId(), loginPw, nickname, cellphoneNum, email);

		return rq.jsReplace(modifyRd.getMsg(), "/");
	}
	
	@RequestMapping("/usr/member/getLoginIdDup")
	@ResponseBody
	public ResultData getLoginIdDup(String loginId) {
		if (Ut.empty(loginId)) {
			return ResultData.from("F-A", "아이디를 입력해주세요");
		}

		Member exsistMember = memberService.getMemberByLoginId(loginId);

		if (exsistMember != null) {
			return ResultData.from("F-A2", "이미 사용중인 아이디입니다.", "loginId", loginId);
		}

		return ResultData.from("S-1", "사용 가능한 아이디 입니다.", "loginId", loginId);
	}
}