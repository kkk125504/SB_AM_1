package com.kjh.exam.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kjh.exam.demo.repository.ArticleRepository;
import com.kjh.exam.demo.util.Ut;
import com.kjh.exam.demo.vo.Article;
import com.kjh.exam.demo.vo.ResultData;

@Service
public class ArticleService {
	// 인스턴스 변수
	private ArticleRepository articleRepository;

	@Autowired
	public ArticleService(ArticleRepository articleRepository) {
		this.articleRepository = articleRepository;
	}

	public ResultData<Integer> writeArticle(int actorId, String title, String body) {
		articleRepository.writeArticle(actorId, title, body);

		int id = articleRepository.getLastInsertId();

		return ResultData.from("S-1", Ut.f("%d번 게시물이 생성되었습니다.", id), "id", id);
	}

	public Article getArticle(int id) {
		return articleRepository.getArticle(id);
	}

	public List<Article> getArticles() {
		return articleRepository.getArticles();
	}

	public void deleteArticle(int id) {
		articleRepository.deleteArticle(id);
	}

	public ResultData<Article> modifyArticle(int id, String title, String body) {
		articleRepository.modifyArticle(id, title, body);
		Article article = getArticle(id);
		return ResultData.from("S-1", Ut.f("%d번 게시물 수정 했습니다.", id), "article", article);
	}

	public ResultData actorCanModify(int actorId, Article article) {

		if (actorId != article.getMemberId()) {
			return ResultData.from("F-2", "해당 게시물에 대한 수정 권한이 없습니다.");
		}
		return ResultData.from("S-1", "수정 가능 합니다.");
	}

}