package com.kjh.exam.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kjh.exam.demo.vo.Article;

@Mapper
public interface ArticleRepository {

	public Article getForPrintArticle(int id);

	public List<Article> getForPrintArticles(int boardId);

	public int writeArticle(int actorId, String title, String body, int boardId);

	public void deleteArticle(int id);

	public void modifyArticle(int id, String title, String body);

	public int getLastInsertId();

}