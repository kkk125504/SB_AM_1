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
		lastArticleId =0;
	}

	@RequestMapping("usr/article/doAdd")
	@ResponseBody
	public String doAdd(String title, String body) {
		int id = lastArticleId + 1;
		lastArticleId = id;
		Article article = new Article(id, title, body);
		articles.add(article);
		return article+"이 추가되었습니다.";
	}

	@RequestMapping("usr/article/getArticles")
	@ResponseBody
	public List<Article> getArticles() {

		return articles;
	}
}