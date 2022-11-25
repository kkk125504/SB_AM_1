<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="${board.name}" />
<%@ include file="../common/head.jspf" %>
	
<section class="mt-8 text-xl">
	<div class="container mx-auto px-3">
		<div class="table-box-type-1">
			<div>총 게시물 : ${articlesCount}개</div>
			<table border="2">
				<thead class="bg-gray-200">
					<tr>
						<th>번호</th>
						<th>날짜</th>
						<th>제목</th>
						<th>작성자</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="article" items="${articles}">
						<tr>
							<td>${article.id }</td>
							<td>${article.regDate.substring(0,10)}</td>
							<td><a href="../article/detail?id=${article.id}">${article.title}</a></td>
							<td>${article.extra__writer}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="page-menu mt-3 flex justify-center">
			<c:set var="pageMenuLen" value="5" />
			<c:set var="startPage" value="${page - pageMenuLen >= 1 ? page- pageMenuLen : 1}" />
			<c:set var="endPage" value="${page + pageMenuLen <= pagesCount ? page + pageMenuLen : pagesCount}" />
			<c:set var="pageBaseUri" value="?boardId=${board.id}"/>
			<c:set var="pageBaseUri" value="${pageBaseUri}&searchKeywordType=${param.searchKeywordType}"/>
			<c:set var="pageBaseUri" value="${pageBaseUri}&searchKeyword=${param.searchKeyword}"/>		
			<div class="btn-group">
				<c:if test="${startPage > 1}">
					<a class="btn btn-sm" href="${pageBaseUri}&page=1">1</a>					
				</c:if>
				<c:if test="${startPage > 2}">
					<a class="btn btn-sm btn-disabled">...</a>
				</c:if>
				<c:forEach begin="${startPage }" end="${endPage }" var="i">
					<a class="btn btn-sm ${page == i ? 'btn-active' : '' }" href="${pageBaseUri}&page=${i }">${i }</a>
				</c:forEach>
				<c:if test="${endPage < pagesCount - 1}">
					<a class="btn btn-sm btn-disabled">...</a>
				</c:if>
				<c:if test="${endPage < pagesCount}">					
					<a class="btn btn-sm" href="${pageBaseUri}&page=${pagesCount }">${pagesCount }</a>
				</c:if>
			</div>
		</div>			
	</div>
</section>	

<%@ include file="../common/foot.jspf" %>