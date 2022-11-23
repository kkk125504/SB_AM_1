package com.kjh.exam.demo.vo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import lombok.Getter;

public class Rq {
	@Getter
	private boolean isLogined;
	@Getter
	private int loginedMemberId;
	private HttpServletRequest req;
	private HttpServletResponse resp;

	public Rq(HttpServletRequest req, HttpServletResponse resp) {
		this.req = req;
		this.resp = resp;
		HttpSession httpSession = req.getSession();
		if (httpSession.getAttribute("loginedMemberId") != null) {
			this.isLogined = true;
			this.loginedMemberId = (int) httpSession.getAttribute("loginedMemberId");
		}
	}
}
