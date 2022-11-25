package com.kjh.exam.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kjh.exam.demo.service.ArticleService;
import com.kjh.exam.demo.service.BoardService;
import com.kjh.exam.demo.util.Ut;
import com.kjh.exam.demo.vo.Article;
import com.kjh.exam.demo.vo.Board;
import com.kjh.exam.demo.vo.ResultData;
import com.kjh.exam.demo.vo.Rq;

@Controller
public class UsrArticleController {

	@Autowired
	private ArticleService articleService;
	@Autowired
	private BoardService boardService;
	@Autowired
	private Rq rq;

	// 액션 메소드
	@RequestMapping("usr/article/write")
	public String showWrite() {
		return "usr/article/write";
	}

	@RequestMapping("usr/article/doWrite")
	@ResponseBody
	public String doWrite(String title, String body, int boardId) {

		if (Ut.empty(title)) {
			return rq.jsHistoryBack("제목을 입력해 주세요.");
		}
		if (Ut.empty(body)) {
			return rq.jsHistoryBack("내용을 입력해 주세요.");
		}
		ResultData<Integer> writeRd = articleService.writeArticle(rq.getLoginedMemberId(), title, body, boardId);

		int id = (int) writeRd.getData1();

		return rq.jsReplace(Ut.f("%d번 게시물이 작성 되었습니다.", id), Ut.f("../article/detail?id=%d", id));
	}

	@RequestMapping("usr/article/detail")
	public String showDetail(Model model, int id) {
		boolean actorCanMakeReaction = articleService.actorCanMakeReaction(rq.getLoginedMemberId(), id);

		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);

		model.addAttribute("actorCanMakeReaction", actorCanMakeReaction);
		model.addAttribute("article", article);
		return "usr/article/detail";
	}
	
	@RequestMapping("usr/article/list")
	public String showList(Model model, @RequestParam(defaultValue = "1") int boardId,
			@RequestParam(defaultValue = "title,body") String searchKeywordType,
			@RequestParam(defaultValue = "") String searchKeyword, @RequestParam(defaultValue = "1") int page) {

		Board board = boardService.getBoardById(boardId);
		if (board == null) {
			return rq.jsHistoryBackOnView("존재하지 않는 게시판 입니다.");
		}

		int itemsInAPage = 10;
		int articlesCount = articleService.getArticlesCount(boardId, searchKeywordType, searchKeyword);
		int pagesCount = (int) (Math.ceil((double) articlesCount / itemsInAPage));
		List<Article> articles = articleService.getForPrintArticles(rq.getLoginedMemberId(), boardId, page,
				itemsInAPage, searchKeywordType, searchKeyword);
		model.addAttribute("articles", articles);
		model.addAttribute("board", board);
		model.addAttribute("page", page);
		model.addAttribute("articlesCount", articlesCount);
		model.addAttribute("pagesCount", pagesCount);
		return "usr/article/list";
	}

	@RequestMapping("usr/article/doDelete")
	@ResponseBody
	public String doDelete(int id) {

		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);

		if (article == null) {
			return rq.jsHistoryBack(Ut.f("%d번 게시물은 존재하지 않습니다.", id));
		}

		if (rq.getLoginedMemberId() != article.getMemberId()) {
			return rq.jsHistoryBack("해당 게시물에 대한 삭제 권한이 없습니다.");
		}

		articleService.deleteArticle(id);
		return rq.jsReplace(Ut.f("%d번 게시물을 삭제 했습니다.", id), Ut.f("../article/list?boardId=%d", article.getBoardId()));
	}

	@RequestMapping("/usr/article/modify")
	public String showModify(Model model, int id) {

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
	public String doModify(int id, String title, String body) {

		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);

		if (article == null) {
			return rq.jsHistoryBack(Ut.f("%d번 게시물은 존재하지 않습니다.", id));
		}

		ResultData actorCanModifyRd = articleService.actorCanModify(rq.getLoginedMemberId(), article);
		if (actorCanModifyRd.isFail()) {
			return rq.jsHistoryBack(actorCanModifyRd.getMsg());
		}
		articleService.modifyArticle(id, title, body);
		return rq.jsReplace(Ut.f("%d번 게시물 수정", id), Ut.f("../article/detail?id=%d", id));
	}
	
	@RequestMapping("/usr/article/doIncreaseHitCountRd")
	@ResponseBody
	public ResultData<Integer> doIncreaseHitCount(int id){
		ResultData<Integer> increaseHitCountRd = articleService.increaseHitCount(id);
		if(increaseHitCountRd.isFail()) {
			return increaseHitCountRd;
		}
		int hitCount = articleService.getHitCount(id);
		ResultData<Integer> rd = ResultData.newData(increaseHitCountRd, "hitCount", hitCount);
		rd.setData2("id",id);
		return rd;
	}
}