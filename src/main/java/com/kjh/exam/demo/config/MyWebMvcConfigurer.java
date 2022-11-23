package com.kjh.exam.demo.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kjh.exam.demo.interceptor.BeforeActionInterceptor;

@Configuration
public class MyWebMvcConfigurer implements WebMvcConfigurer {
	
	@Autowired
	BeforeActionInterceptor beforeActionInterceptor;

	// 인터셉터 적용
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(beforeActionInterceptor).addPathPatterns("/**").excludePathPatterns("/resource/**")
				.excludePathPatterns("/error");
	}
}
