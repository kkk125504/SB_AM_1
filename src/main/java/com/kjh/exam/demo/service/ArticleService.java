package com.kjh.exam.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kjh.exam.demo.repository.ArticleRepository;
import com.kjh.exam.demo.vo.Article;

@Service
public class ArticleService {
	// 인스턴스 변수
	private ArticleRepository articleRepository;

	@Autowired	
	public ArticleService(ArticleRepository articleRepository){
		this.articleRepository =articleRepository;
	}	

	public Article writeArticle(String title, String body) {
		return articleRepository.writeArticle(title, body);
	}

	public Article getArticle(int id) {
		return articleRepository.getArticle(id);
	}

	public void deleteArticle(int id) {
		articleRepository.deleteArticle(id);
	}

	public void modifyArticle(int id, String title, String body) {
		articleRepository.modifyArticle(id,title,body);
	}

	public List<Article> getArticles() {
		return articleRepository.getArticles();
	}

}