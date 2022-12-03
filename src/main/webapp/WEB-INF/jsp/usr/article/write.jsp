<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="WRITE" />
<%@ include file="../common/head.jspf" %>
<%@ include file="../common/toastUiEditorLib.jspf" %>
<script>
	var ArticleWrite__submitDone = false;
	function ArticleWrite__submit(form){		
		form.title.value = form.title.value.trim();
		
		if(form.title.value.length == 0){
			alert('제목을 입력해 주세요');
			return;
		}
		const editor = $(form).find('.toast-ui-editor').data('data-toast-editor');
		
		const markdown = editor.getMarkdown().trim();
		
		if (markdown.length == 0) {
			alert('내용을 입력해주세요');
			editor.focus();
			return;
		}
		
		form.body.value = markdown;
		form.submit();		
	}
</script>
	<section class="mt-8 text-xl">
		<div class="container mx-auto px-3">
			<form class="table-box-type-1" method="post" action="doWrite" onsubmit ="ArticleWrite__submit(this); return false;">
				<input type="hidden" name ="body" />
				<table>
					<colgroup>
						<col width="200" />
					</colgroup>	
					<tbody>
						<tr>
						<td>게시판선택</td>
						<td>
							<select name="boardId" class="select select-bordered">
								<option disabled>게시판을 선택해주세요</option>
								<option value="1">공지사항</option>
								<option value="2">자유</option>
							</select>
							<input type="checkbox" name="secret">&nbsp;비밀글 설정
						</td>
						</tr>														
						<tr>
							<td>제목</td>
							<td>
								<input required="required" type="text" class="w-4/6 input input-bordered input-lg" name="title" value="${article.title }" placeholder="제목을 입력해주세요." />
							</td>						
						</tr>
						<tr>
							<td>내용</td>
							<td>
								<div class="toast-ui-editor">
	     							 <script type="text/x-template"></script>
	    						</div>
	    					</td>								
						</tr>
						<tr>
							<td>작성자</td>
							<td>${rq.loginedMember.nickname }</td>						
						</tr>						
					</tbody>								
				</table>

				<div class= "btns flex justify-end">
					<button class ="btn-text-link mx-4 btn btn-active btn-ghost" type="submit">게시글 작성</button>					
					<button class ="btn-text-link btn btn-active btn-ghost" type="button" onclick="history.back()">뒤로가기</button>
				</div>
			</form>
		</div>
	</section>
<%@ include file="../common/foot.jspf" %>