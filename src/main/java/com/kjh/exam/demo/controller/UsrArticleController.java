package com.kjh.exam.demo.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	public ResultData<Article> doAdd(HttpSession httpSession, String title, String body) {
		boolean isLogined = false;

		int loginedMemberId = -1;

		if (httpSession.getAttribute("loginedMemberId") != null) {
			isLogined = true;
			loginedMemberId = (int) httpSession.getAttribute("loginedMemberId");
		}

		if (isLogined == false) {
			return ResultData.from("F-A", "로그인 후 이용가능 합니다.");
		}

		if (Ut.empty(title)) {
			return ResultData.from("F-1", Ut.f("제목을 입력해 주세요."));
		}
		if (Ut.empty(body)) {
			return ResultData.from("F-2", Ut.f("내용을 입력해 주세요."));
		}
		ResultData<Integer> writeRd = articleService.writeArticle(loginedMemberId, title, body);

		int id = (int) writeRd.getData1();
		Article article = articleService.getArticle(id);

		return ResultData.newData(writeRd, "article", article);
	}

	@RequestMapping("usr/article/detail")
	public String showDetail(Model model, int id) {
		Article article = articleService.getArticle(id);
		model.addAttribute("article", article);
		return "usr/article/detail";
	}

	@RequestMapping("usr/article/list")
	public String showList(Model model) {
		List<Article> articles = articleService.getArticles();

		model.addAttribute("articles", articles);
		return "usr/article/list";
	}

	@RequestMapping("usr/article/doDelete")
	@ResponseBody
	public ResultData doDelete(HttpSession httpSession, int id) {
		boolean isLogined = false;
		int loginedMemberId = -1;

		if (httpSession.getAttribute("loginedMemberId") != null) {
			isLogined = true;
			loginedMemberId = (int) httpSession.getAttribute("loginedMemberId");
		}

		if (isLogined == false) {
			return ResultData.from("F-A", "로그인 후 이용가능 합니다.");
		}
		Article article = articleService.getArticle(id);

		if (article == null) {
			return ResultData.from("F-1", Ut.f("%d번 게시물은 존재하지 않습니다.", id));
		}

		if (loginedMemberId != article.getMemberId()) {
			return ResultData.from("F-2", "해당 게시물에 대한 삭제 권한이 없습니다.");
		}

		articleService.deleteArticle(id);
		return ResultData.from("S-1", Ut.f("%d번 게시물을 삭제 했습니다.", id));
	}

	@RequestMapping("usr/article/doModify")
	@ResponseBody
	public ResultData<Article> doModify(HttpSession httpSession, int id, String title, String body) {
		boolean isLogined = false;
		int loginedMemberId = -1;

		if (httpSession.getAttribute("loginedMemberId") != null) {
			isLogined = true;
			loginedMemberId = (int) httpSession.getAttribute("loginedMemberId");
		}

		if (isLogined == false) {
			return ResultData.from("F-A", "로그인 후 이용가능 합니다.");
		}

		Article article = articleService.getArticle(id);

		if (article == null) {
			return ResultData.from("F-1", Ut.f("%d번 게시물은 존재하지 않습니다.", id));
		}

		ResultData actorCanModifyRd = articleService.actorCanModify(loginedMemberId, article);
		if (actorCanModifyRd.isFail()) {
			return actorCanModifyRd;
		}

		return articleService.modifyArticle(id, title, body);
	}
}