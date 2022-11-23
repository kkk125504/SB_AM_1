package com.kjh.exam.demo.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kjh.exam.demo.service.ArticleService;
import com.kjh.exam.demo.util.Ut;
import com.kjh.exam.demo.vo.Article;
import com.kjh.exam.demo.vo.ResultData;
import com.kjh.exam.demo.vo.Rq;

@Controller
public class UsrArticleController {

	@Autowired
	ArticleService articleService;

	// 액션 메소드
	@RequestMapping("usr/article/doAdd")
	@ResponseBody
	public ResultData<Article> doAdd(HttpServletRequest req, String title, String body) {
		Rq rq = (Rq) req.getAttribute("rq");

		if (Ut.empty(title)) {
			return ResultData.from("F-1", Ut.f("제목을 입력해 주세요."));
		}
		if (Ut.empty(body)) {
			return ResultData.from("F-2", Ut.f("내용을 입력해 주세요."));
		}
		ResultData<Integer> writeRd = articleService.writeArticle(rq.getLoginedMemberId(), title, body);

		int id = (int) writeRd.getData1();
		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);

		return ResultData.newData(writeRd, "article", article);
	}

	@RequestMapping("usr/article/detail")
	public String showDetail(HttpServletRequest req, Model model, int id) {
		Rq rq = (Rq) req.getAttribute("rq");

		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);
		model.addAttribute("article", article);
		return "usr/article/detail";
	}

	@RequestMapping("usr/article/list")
	public String showList(HttpServletRequest req, Model model) {
		Rq rq = (Rq) req.getAttribute("rq");

		List<Article> articles = articleService.getForPrintArticles(rq.getLoginedMemberId());

		model.addAttribute("articles", articles);
		return "usr/article/list";
	}

	@RequestMapping("usr/article/doDelete")
	@ResponseBody
	public String doDelete(HttpServletRequest req, int id) {
		Rq rq = (Rq) req.getAttribute("rq");

		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);

		if (article == null) {
			return Ut.jsHistoryBack(Ut.f("%d번 게시물은 존재하지 않습니다.", id));
		}

		if (rq.getLoginedMemberId() != article.getMemberId()) {
			return Ut.jsHistoryBack("해당 게시물에 대한 삭제 권한이 없습니다.");
		}

		articleService.deleteArticle(id);
		return Ut.jsReplace(Ut.f("%d번 게시물을 삭제 했습니다.", id), "../article/list");
	}

	@RequestMapping("/usr/article/modify")
	public String showModify(HttpServletRequest req, Model model, int id) {
		Rq rq = (Rq) req.getAttribute("rq");

		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);

		if (article == null) {
			return rq.jsHistoryBackOnView(Ut.f("%d번 게시물은 존재하지 않습니다.", id));
		}

		ResultData actorCanModifyRd = articleService.actorCanModify(rq.getLoginedMemberId(), article);

		if (actorCanModifyRd.isFail()) {
			return rq.jsHistoryBackOnView(actorCanModifyRd.getMsg());
		}
		model.addAttribute("article", article);

		return "usr/article/modify";
	}

	@RequestMapping("usr/article/doModify")
	@ResponseBody
	public String doModify(HttpServletRequest req, int id, String title, String body) {
		Rq rq = (Rq) req.getAttribute("rq");

		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);

		if (article == null) {
			return Ut.jsHistoryBack(Ut.f("%d번 게시물은 존재하지 않습니다.", id));
		}

		ResultData actorCanModifyRd = articleService.actorCanModify(rq.getLoginedMemberId(), article);
		if (actorCanModifyRd.isFail()) {
			return Ut.jsHistoryBack(actorCanModifyRd.getMsg());
		}
		articleService.modifyArticle(id, title, body);
		return Ut.jsReplace(Ut.f("%d번 게시물 수정", id), Ut.f("../article/detail?id=%d", id));
	}
}