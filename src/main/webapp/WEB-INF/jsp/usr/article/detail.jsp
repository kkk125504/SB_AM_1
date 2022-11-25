<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="ARTICLE" />
<%@ include file="../common/head.jspf" %>
<script>
		const params = {};
		params.id = parseInt('${param.id}');
</script>

<script>
	function ArticleDetail__increaseHitCount() {
		const localStorageKey = 'article__' + params.id + '__alreadyView';
		
		if(localStorage.getItem(localStorageKey)){
			return;
		}	
		localStorage.setItem(localStorageKey,true);
		
		$.get('../article/doIncreaseHitCountRd', {
			id : params.id,
			ajaxMode : 'Y'
		}, function(data) {
			$('.article-detail__hit-count').empty().html(data.data1);
		}, 'json');
	}
	
	$(function() {
		// 실전코드
		//ArticleDetail__increaseHitCount();
		// 연습코드
		setTimeout(ArticleDetail__increaseHitCount, 2000);
	})
</script>	
<section class="mt-8 text-xl">
	<div class="container mx-auto px-3">
		<div class="table-box-type-1">
			<table>
				<colgroup>
					<col width="200" />
				</colgroup>	
				<tbody>		
					<tr>
						<td class="bg-gray-200">번호</td>
						<td><span class="badge">${article.id }</span></td>						
					</tr>
					<tr>
						<td class="bg-gray-200">작성날짜</td>
						<td>${article.regDate }</td>						
					</tr>
					<tr>
						<td class="bg-gray-200">수정날짜</td>
						<td>${article.updateDate }</td>						
					</tr>
					<tr>
						<td class="bg-gray-200">제목</td>
						<td>${article.title }</td>						
					</tr>
					<tr>
						<td class="bg-gray-200">내용</td>
						<td>${article.body }</td>						
					</tr>
					<tr>
						<td class="bg-gray-200">작성자</td>
						<td>${article.extra__writer }</td>						
					</tr>
					<tr>
						<td class="bg-gray-200">조회수</td>
						<td><span class="badge article-detail__hit-count">${article.hitCount }</span></td>						
					</tr>
					<tr>
						<td class="bg-gray-200">추천</td>
						<td><span class="badge">${article.extra__sumReactionPoint}</span></td>						
					</tr>
				</tbody>								
			</table>
			<div class= "btns flex justify-end">
				<button class ="btn-text-link btn btn-active btn-ghost" type="button" onclick="history.back()">뒤로가기</button>
				<c:if test ="${article.extra__actorCanModify}">
					<a class ="btn-text-link btn btn-active btn-ghost mx-4" href="modify?id=${article.id }">수정</a>				
				</c:if>
				<c:if test ="${article.extra__actorCanDelete}">
					<a class ="btn-text-link btn btn-active btn-ghost" onclick="if(confirm('삭제하시겠습니까?') == false) return false;" href="doDelete?id=${article.id }">삭제</a>
				</c:if>				
			</div>
		</div>
	</div>
</section>	

<%@ include file="../common/foot.jspf" %>