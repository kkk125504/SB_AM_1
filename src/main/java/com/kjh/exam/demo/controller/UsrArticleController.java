package com.kjh.exam.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kjh.exam.demo.service.ArticleService;
import com.kjh.exam.demo.util.Ut;
import com.kjh.exam.demo.vo.Article;
import com.kjh.exam.demo.vo.ResultData;

@Controller
public class UsrArticleController {

	@Autowired
	ArticleService articleService;

	// 액션 메소드
	@RequestMapping("usr/article/doAdd")
	@ResponseBody
	public ResultData<Article> doAdd(String title, String body) {
		if (Ut.empty(title)) {
			return ResultData.from("F-1", Ut.f("제목을 입력해 주세요."));
		}
		if (Ut.empty(body)) {
			return ResultData.from("F-2", Ut.f("내용을 입력해 주세요."));
		}
		ResultData<Integer> writeRd = articleService.writeArticle(title, body);

		int id = (int) writeRd.getData1();
		Article article = articleService.getArticle(id);

		return ResultData.newData(writeRd, article);
	}

	@RequestMapping("usr/article/getArticle")
	@ResponseBody
	public ResultData<Article> getArticle(int id) {
		Article article = articleService.getArticle(id);

		if (article == null) {
			return ResultData.from("F-1", Ut.f("%d번 게시물은 존재하지 않습니다.", id));
		}
		return ResultData.from("S-1", Ut.f("%d번 게시물입니다.", id), article);
	}

	@RequestMapping("usr/article/getArticles")
	@ResponseBody
	public ResultData<List<Article>> getArticles() {
		List<Article> articles = articleService.getArticles();
		return ResultData.from("S-1", "Article List", articles);
	}

	@RequestMapping("usr/article/doDelete")
	@ResponseBody
	public ResultData doDelete(int id) {
		Article article = articleService.getArticle(id);

		if (article == null) {
			return ResultData.from("F-1", Ut.f("%d번 게시물은 존재하지 않습니다.", id));
		}

		articleService.deleteArticle(id);
		return ResultData.from("S-1", Ut.f("%d번 게시물을 삭제 했습니다.", id));
	}

	@RequestMapping("usr/article/doModify")
	@ResponseBody
	public ResultData<Article> doModify(int id, String title, String body) {
		Article article = articleService.getArticle(id);

		if (article == null) {
			return ResultData.from("F-1", Ut.f("%d번 게시물은 존재하지 않습니다.", id));
		}

		articleService.modifyArticle(id, title, body);
		article = articleService.getArticle(id);
		return ResultData.from("S-1", Ut.f("%d번 게시물을 수정 했습니다.", id), article);
	}
}