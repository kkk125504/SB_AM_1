package com.kjh.exam.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kjh.exam.demo.vo.Article;

@Mapper
public interface ArticleRepository {

	public Article getForPrintArticle(int id);

	public List<Article> getForPrintArticles(int boardId, int limitStart, int limitTake, String searchKeywordType,
			String searchKeyword);

	public int writeArticle(int actorId, String title, String body, int boardId, boolean secret);

	public void deleteArticle(int id);

	public void modifyArticle(int id, String title, String body, boolean secret);

	public int getLastInsertId();

	public int getArticlesCount(int boardId, String searchKeywordType, String searchKeyword);

	public int increaseHitCount(int id);

	public int getHitCount(int id);
	
	public int increaseGoodReactionPoint(int relId);

	public int increaseBadReactionPoint(int relId);
	
	public int decreaseGoodReactionPoint(int relId);

	public int decreaseBadReactionPoint(int relId);

	public int getGoodReactionPoint(int relId);

	public int getBadReactionPoint(int relId);

	public Article getArticle(int relId);

	public List<Article> getForPrintBestArticles(int boardId);

}