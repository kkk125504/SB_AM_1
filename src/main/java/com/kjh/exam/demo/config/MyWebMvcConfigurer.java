package com.kjh.exam.demo.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kjh.exam.demo.interceptor.BeforeActionInterceptor;
import com.kjh.exam.demo.interceptor.NeedLoginInterceptor;
import com.kjh.exam.demo.interceptor.NeedLogoutInterceptor;

@Configuration
public class MyWebMvcConfigurer implements WebMvcConfigurer {

	@Autowired
	BeforeActionInterceptor beforeActionInterceptor;
	@Autowired
	NeedLoginInterceptor needLoginInterceptor;
	@Autowired
	NeedLogoutInterceptor needLogoutInterceptor;

	// 인터셉터 적용
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(beforeActionInterceptor).addPathPatterns("/**").excludePathPatterns("/resource/**")
				.excludePathPatterns("/error");

		registry.addInterceptor(needLoginInterceptor)
				.addPathPatterns("/usr/article/write")
				.addPathPatterns("/usr/article/doWrite")
				.addPathPatterns("/usr/article/modify")
				.addPathPatterns("/usr/article/doModify")
				.addPathPatterns("/usr/article/doDelete")
				.addPathPatterns("/usr/reactionPoint/doGoodReaction")
				.addPathPatterns("/usr/reactionPoint/doBadReaction")
				.addPathPatterns("/usr/reply/doWrite")
				.addPathPatterns("/usr/reply/doDelete")
				.addPathPatterns("/usr/reply/modify")
				.addPathPatterns("/usr/reply/doModify")
				.addPathPatterns("/usr/member/doLogout")
				.addPathPatterns("/usr/member/myPage");
				
		registry.addInterceptor(needLogoutInterceptor)
				.addPathPatterns("/usr/member/login")
				.addPathPatterns("/usr/member/doLogin")
				.addPathPatterns("/usr/member/doJoin");		
	}
}
