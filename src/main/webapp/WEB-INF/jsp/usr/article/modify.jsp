<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MODIFY" />
<%@ include file="../common/head.jspf" %>
<script>
	var ArticleModify__submitDone = false;
	function ArticleModify__submit(form) {
		if (ArticleModify__submitDone) {
			return;
		}
		form.body.value = form.body.value.trim();
		if (form.body.value.length == 0) {
			alert('내용을 입력해주세요');
			form.body.focus();
			return;
		}
		ArticleModify__submitDone = true;
		form.submit();
	}
</script>
	<section class="mt-8 text-xl">
		<div class="container mx-auto px-3">
			<form class="table-box-type-1" method="post" action="doModify" onsubmit="ArticleModify__submit(this); return false;">
				<table>
					<colgroup>
						<col width="200" />
					</colgroup>	
					<tbody>		
						<tr>
							<td>번호</td>
							<td><input type="hidden" name="id" value="${article.id }"/>${article.id }</td>						
						</tr>
						<tr>
							<td>작성날짜</td>
							<td>${article.regDate }</td>						
						</tr>
						<tr>
							<td>수정날짜</td>
							<td>${article.updateDate }</td>						
						</tr>
						<tr>
							<td>제목</td>
							<td><input type="text" class="w-4/6 input input-bordered input-lg" name="title" value="${article.title }" placeholder="제목을 입력해주세요." /></td>						
						</tr>
						<tr>
							<td>내용</td>
							<td><textarea class="textarea textarea-bordered h-52 w-11/12" name="body" placeholder="내용을 입력해주세요."  cols="80" rows="10">${article.body }</textarea></td>						
						</tr>
						<tr>
							<td>추천 수</td>
							<td><span class="badge">${article.goodReactionPoint }</span></td>						
						</tr>							
					</tbody>								
				</table>

				<div class= "btns flex justify-end">
					<button class ="btn-text-link btn btn-active btn-ghost mx-4" type="submit">수정하기</button>					
					<button class ="btn-text-link btn btn-active btn-ghost" type="button" onclick="history.back()">뒤로가기</button>
				</div>
			</form>
		</div>
	</section>
<%@ include file="../common/foot.jspf" %>