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
			String title = "제목" + i;
			String body = "내용" + i;

			writeArticle(title, body);
		}
	}

	private Article writeArticle(String title, String body) {
		int id = lastArticleId + 1;
		lastArticleId = id;
		Article article = new Article(id, title, body);
		articles.add(article);
		return article;
	}

	private Article getArticle(int id) {

		for (Article article : articles) {
			if (article.getId() == id) {
				return article;
			}
		}
		return null;
	}

	private void deleteArticle(int id) {
		Article article = getArticle(id);

		articles.remove(article);
	}

	private void modifyArticle(int id, String title, String body) {
		Article article = getArticle(id);
		article.setTitle(title);
		article.setBody(body);
	}

	// 액션 메소드
	@RequestMapping("usr/article/doAdd")
	@ResponseBody
	public Article doAdd(String title, String body) {
		Article article = writeArticle(title, body);
		return article;
	}
	
	@RequestMapping("usr/article/getArticle")
	@ResponseBody
	public Object getArticleAction(int id) {
		Article article = getArticle(id);

		if (article == null) {
			return id + "번 게시물은 존재하지 않습니다.";
		}		
		return article;
	}

	@RequestMapping("usr/article/getArticles")
	@ResponseBody
	public List<Article> getArticles() {

		return articles;
	}

	@RequestMapping("usr/article/doDelete")
	@ResponseBody
	public String doDelete(int id) {
		Article article = getArticle(id);

		if (article == null) {
			return id + "번 게시물은 존재하지 않습니다.";
		}

		deleteArticle(id);
		return id + "번 게시물을 삭제 했습니다.";
	}

	@RequestMapping("usr/article/doModify")
	@ResponseBody
	public Object doModify(int id, String title, String body) {
		Article article = getArticle(id);

		if (article == null) {
			return id + "번 게시물은 존재하지 않습니다.";
		}

		modifyArticle(id, title, body);
		return article;
	}
}