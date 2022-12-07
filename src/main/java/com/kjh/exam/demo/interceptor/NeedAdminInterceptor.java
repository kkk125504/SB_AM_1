package com.kjh.exam.demo.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kjh.exam.demo.vo.Rq;

@Component
public class NeedAdminInterceptor implements HandlerInterceptor {
	@Autowired
	private Rq rq;

	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler) throws Exception {

		if (!rq.isAdmin()) {
			if (rq.isAjax()) {
				resp.setContentType("application/json; charset=UTF-8");
				resp.getWriter().append("{\"resultCode\":\"F-A\",\"msg\":\"관리자로 로그인 후 이용해주세요\"}");
			} else {
				String afterLoginUri = rq.getAfterLoginUri();
				rq.printReplaceJs("관리자로 로그인 후 이용해주세요", "/");
			}
			return false;
		}

		return HandlerInterceptor.super.preHandle(req, resp, handler);
	}
}