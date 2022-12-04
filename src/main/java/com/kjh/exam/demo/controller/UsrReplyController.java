package com.kjh.exam.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kjh.exam.demo.service.ArticleService;
import com.kjh.exam.demo.service.ReplyService;
import com.kjh.exam.demo.util.Ut;
import com.kjh.exam.demo.vo.Article;
import com.kjh.exam.demo.vo.Reply;
import com.kjh.exam.demo.vo.ResultData;
import com.kjh.exam.demo.vo.Rq;

@Controller
public class UsrReplyController {

	@Autowired
	private ReplyService replyService;
	@Autowired
	private ArticleService articleService;
	@Autowired
	private Rq rq;

	@RequestMapping("/usr/reply/doWrite")
	@ResponseBody
	public ResultData doWrite(String relTypeCode, int relId, String body) {

		if (Ut.empty(relTypeCode)) {
			return ResultData.from("F-1", "relTypeCode을(를) 입력해주세요");
		}

		if (Ut.empty(relId)) {
			return ResultData.from("F-2", "relId을(를) 입력해주세요");
		}

		if (Ut.empty(body)) {
			return ResultData.from("F-3", "body을(를) 입력해주세요");
		}

		ResultData writeReplyRd = replyService.writeReply(rq.getLoginedMemberId(), relTypeCode, relId, body);

		return writeReplyRd;
	}

	@RequestMapping("/usr/reply/doDelete")
	@ResponseBody
	public ResultData doDelete(int id) {
		if (Ut.empty(id)) {
			return ResultData.from("F-1", "id가 없습니다");
		}

		Reply reply = replyService.getForPrintReply(rq.getLoginedMember(), id);

		if (reply == null) {
			return ResultData.from("F-2", Ut.f("%d번 댓글은 존재하지 않습니다", id));
		}

		if (reply.isExtra__actorCanDelete() == false) {
			return ResultData.from("F-3", "해당 댓글을 삭제할 권한이 없습니다");
		}

		ResultData deleteReplyRd = replyService.deleteReply(id);

		return deleteReplyRd;
	}

//	@RequestMapping("/usr/reply/modify")
//	public String modify(Model model, int id) {
//		if (Ut.empty(id)) {
//			return rq.jsHistoryBackOnView("id가 없습니다");
//		}
//		Reply reply = replyService.getForPrintReply(rq.getLoginedMember(), id);
//
//		if (reply == null) {
//			return rq.jsHistoryBackOnView(Ut.f("%d번 댓글은 존재하지 않습니다", id));
//		}
//
//		if (reply.isExtra__actorCanModify() == false) {
//			return rq.jsHistoryBack("해당 댓글을 수정할 권한이 없습니다");
//		}
//
//		String relDataTitle = null;
//
//		switch (reply.getRelTypeCode()) {
//		case "article":
//			Article article = articleService.getArticle(reply.getRelId());
//			relDataTitle = article.getTitle();
//			break;
//		}
//		model.addAttribute("reply", reply);
//		model.addAttribute("relDataTitle", relDataTitle);
//
//		return "usr/reply/modify";
//	}

	@RequestMapping("/usr/reply/doModify")
	@ResponseBody
	public ResultData doModify(int id, String body) {
		if (Ut.empty(id)) {
			return ResultData.from("F-1", "id가 없습니다");		
		}
		if (Ut.empty(body)) {
			return ResultData.from("F-2", "내용을 입력해주세요");	
		}
		Reply reply = replyService.getForPrintReply(rq.getLoginedMember(), id);

		if (reply == null) {
			return ResultData.from("F-3", Ut.f("%d번 댓글은 존재하지 않습니다", id));	
		}

		if (reply.isExtra__actorCanModify() == false) {
			return ResultData.from("F-4", "해당 댓글을 삭제할 권한이 없습니다.");	
		}

		ResultData modifyReplyRd = replyService.modifyReply(id, body);

		return modifyReplyRd;
	}

	@RequestMapping("/usr/reply/getReplies")
	@ResponseBody
	public ResultData getReplies(String relTypeCode, int relId) {
		List<Reply> replies = replyService.getForPrintReplies(rq.getLoginedMember(), relTypeCode, relId);
		if (replies.isEmpty()) {
			return ResultData.from("S-2", "댓글이 없습니다.");
		}
		return ResultData.from("S-1", "댓글리스트", "replies", replies);
	}
}
