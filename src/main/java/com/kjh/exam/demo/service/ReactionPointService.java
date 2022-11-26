package com.kjh.exam.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kjh.exam.demo.repository.ReactionPointRepository;
import com.kjh.exam.demo.vo.ResultData;


@Service
public class ReactionPointService {

	@Autowired
	private ReactionPointRepository reactionPointRepository;
	@Autowired
	private ArticleService articleService;
	
	public boolean actorCanMakeReaction(int actorId, String relTypeCode, int id) {

		if (actorId == -1) {
			return false;
		}
		return reactionPointRepository.getSumReactionPointByMemberId(actorId, relTypeCode, id) == 0;
	}
	
	public boolean isSelectedGoodReactionPoint(int actorId, String relTypeCode, int relId) {
		
		return reactionPointRepository.isSelectedGoodReactionPoint(actorId, relTypeCode, relId);
	}

	public boolean isSelectedBadReactionPoint(int actorId, String relTypeCode, int relId) {
		
		return reactionPointRepository.isSelectedBadReactionPoint(actorId, relTypeCode, relId);
	}

	public ResultData addGoodReactionPoint(int actorId, String relTypeCode, int relId) {
		reactionPointRepository.addGoodReactionPoint(actorId, relTypeCode, relId);
		switch (relTypeCode) {
		case "article":
			articleService.increaseGoodReactionPoint(relId);
			break;
		}
		int goodReactionPoint = articleService.getGoodReactionPoint(relId);
		return ResultData.from("S-1", "좋아요 증가 되었습니다", "goodReactionPoint", goodReactionPoint);
	}

	public ResultData addBadReactionPoint(int actorId, String relTypeCode, int relId) {
		reactionPointRepository.addBadReactionPoint(actorId, relTypeCode, relId);
		switch (relTypeCode) {
		case "article":
			articleService.increaseBadReactionPoint(relId);
			break;
		}
		int badReactionPoint = articleService.getBadReactionPoint(relId);
		return ResultData.from("S-1", "싫어요 증가 되었습니다", "badReactionPoint", badReactionPoint);
	}

	public ResultData removeGoodReationPoint(int actorId, String relTypeCode, int relId) {
		reactionPointRepository.removeReactionPoint(actorId, relTypeCode, relId);

		switch (relTypeCode) {
		case "article":
			articleService.decreaseGoodReactionPoint(relId);
			break;
		}
		int goodReactionPoint = articleService.getGoodReactionPoint(relId);
		return ResultData.from("S-1", "좋아요 감소 되었습니다", "goodReactionPoint", goodReactionPoint);
	}

	public ResultData removeBadReactionPoint(int actorId, String relTypeCode, int relId) {
		reactionPointRepository.removeReactionPoint(actorId, relTypeCode, relId);

		switch (relTypeCode) {
		case "article":
			articleService.decreaseBadReactionPoint(relId);
			break;
		}
		int badReactionPoint = articleService.getBadReactionPoint(relId);
		return ResultData.from("S-1", "싫어요 감소 되었습니다.", "badReactionPoint", badReactionPoint);
	}

}
