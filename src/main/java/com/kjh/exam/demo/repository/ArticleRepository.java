package com.kjh.exam.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.kjh.exam.demo.vo.Article;

@Mapper
public interface ArticleRepository {
	
	@Select("SELECT * FROM article WHERE id = #{id}")	
	public Article getArticle(int id);
	
	@Select("SELECT * FROM article")
	public List<Article> getArticles(); 

	public Article writeArticle(String title, String body);
	
	@Delete("DELETE FROM article WHERE id = #{id}")
	public void deleteArticle(int id); 
	
	@Update("UPDATE article SET updateDate = NOW(), title = #{title}, `body`= #{body} WHERE id = #{id}")
	public void modifyArticle(int id, String title, String body); 

}