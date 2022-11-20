package com.kjh.exam.demo.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kjh.exam.demo.vo.Article;

@Controller
public class UsrArticleController {
	public List<Article> articles;

	private int lastArticleId;

	public UsrArticleController() {
		articles = new ArrayList<>();
		lastArticleId = 0;
	}

	// 서비스 메소드
	private void makeTestData() {
		for (int i = 1; i <= 10; i++) {
			int id = lastArticleId + 1;
			String title = "제목" + i;
			String body = "내용" + i;
			Article article = new Article(id, title, body);
			articles.add(article);
			lastArticleId = id;
		}
	}
	
	// 액션 메소드
	@RequestMapping("usr/article/doAdd")
	@ResponseBody
	public String doAdd(String title, String body) {
		int id = lastArticleId + 1;
		lastArticleId = id;
		Article article = new Article(id, title, body);
		articles.add(article);
		return article + "이 추가되었습니다.";
	}

	@RequestMapping("usr/article/getArticles")
	@ResponseBody
	public List<Article> getArticles() {

		return articles;
	}
}