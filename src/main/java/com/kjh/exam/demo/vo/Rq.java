package com.kjh.exam.demo.vo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import lombok.Getter;

public class Rq {
	@Getter
	private boolean isLogined;
	@Getter
	private int loginedMemberId;

	public Rq(HttpServletRequest req) {
		HttpSession httpSession = req.getSession();
		if (httpSession.getAttribute("loginedMemberId") != null) {
			this.isLogined = true;
			this.loginedMemberId = (int) httpSession.getAttribute("loginedMemberId");
		}
	}
}
