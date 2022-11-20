package com.kjh.exam.demo.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.kjh.exam.demo.vo.Article;

@Service
public class ArticleService {
	// 인스턴스 변수
	private List<Article> articles;
	private int lastArticleId;

	public ArticleService() {
		articles = new ArrayList<>();
		lastArticleId = 0;
		makeTestData();
	}

	// 서비스 메소드
	private void makeTestData() {
		for (int i = 1; i <= 10; i++) {
			String title = "제목" + i;
			String body = "내용" + i;

			writeArticle(title, body);
		}
	}

	public Article writeArticle(String title, String body) {
		int id = lastArticleId + 1;

		Article article = new Article(id, title, body);

		articles.add(article);
		lastArticleId = id;
		return article;
	}

	public Article getArticle(int id) {

		for (Article article : articles) {
			if (article.getId() == id) {
				return article;
			}
		}
		return null;
	}

	public void deleteArticle(int id) {
		Article article = getArticle(id);

		articles.remove(article);
	}

	public void modifyArticle(int id, String title, String body) {
		Article article = getArticle(id);
		article.setTitle(title);
		article.setBody(body);
	}

	public List<Article> getArticles() {
		return articles;
	}

}