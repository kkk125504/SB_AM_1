package com.kjh.exam.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kjh.exam.demo.service.ReactionPointService;
import com.kjh.exam.demo.vo.ResultData;
import com.kjh.exam.demo.vo.Rq;

@Controller
public class UsrReactionPointController {

	@Autowired
	private ReactionPointService reactionPointService;
	@Autowired
	private Rq rq;

	@RequestMapping("/usr/reactionPoint/doGoodReaction")
	@ResponseBody
	public ResultData doGoodReaction(String relTypeCode, int relId) {
		
		boolean isSelectedGoodReactionPoint = reactionPointService.isSelectedGoodReactionPoint(rq.getLoginedMemberId(),
				relTypeCode, relId);
		boolean isSelectedBadReactionPoint = reactionPointService.isSelectedBadReactionPoint(rq.getLoginedMemberId(),
				relTypeCode, relId);

		if (isSelectedBadReactionPoint) {
			return ResultData.from("F-1", "싫어요 버튼을 누르셨습니다.");
		}

		if (isSelectedGoodReactionPoint) {
			ResultData removeGoodReactionPointRd = reactionPointService.removeGoodReationPoint(rq.getLoginedMemberId(),
					relTypeCode, relId);
			int goodReactionPoint = (int) removeGoodReactionPointRd.getData1();
			return ResultData.from("S-2", "좋아요 취소 하였습니다.", "goodReactionPoint", goodReactionPoint);
		}

		ResultData addGoodReactionPointRd = reactionPointService.addGoodReactionPoint(rq.getLoginedMemberId(),
				relTypeCode, relId);
		int goodReactionPoint = (int) addGoodReactionPointRd.getData1();
		return ResultData.from("S-1", "좋아요!", "goodReactionPoint", goodReactionPoint);
	}

	@RequestMapping("/usr/reactionPoint/doBadReaction")
	@ResponseBody
	public ResultData doBadReaction(String relTypeCode, int relId) {

		boolean isSelectedGoodReactionPoint = reactionPointService.isSelectedGoodReactionPoint(rq.getLoginedMemberId(),
				relTypeCode, relId);
		boolean isSelectedBadReactionPoint = reactionPointService.isSelectedBadReactionPoint(rq.getLoginedMemberId(),
				relTypeCode, relId);

		if (isSelectedGoodReactionPoint) {
			return ResultData.from("F-1", "좋아요 버튼을 누르셨습니다.");
		}

		if (isSelectedBadReactionPoint) {
			ResultData removeBadReactionPointRd = reactionPointService.removeBadReactionPoint(rq.getLoginedMemberId(),
					relTypeCode, relId);
			int baddReactionPoint = (int) removeBadReactionPointRd.getData1();
			return ResultData.from("S-2", "싫어요 취소 하였습니다.", "baddReactionPoint", baddReactionPoint);
		}

		ResultData addBadReactionPointRd = reactionPointService.addBadReactionPoint(rq.getLoginedMemberId(),
				relTypeCode, relId);
		int badReactionPoint = (int) addBadReactionPointRd.getData1();
		return ResultData.from("S-1", "싫어요!", "badReactionPoint", badReactionPoint);
	}
}
