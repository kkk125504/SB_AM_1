<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="ARTICLE" />
<%@ include file="../common/head.jspf" %>
<%@ include file="../common/toastUiEditorLib.jspf" %>
<script>
		const params = {};
		params.id = parseInt('${param.id}');
</script>

<script>
	//조회수 증가
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
	
	//좋아요 버튼 클릭시 실행
	function goodReactionPoint() {
		if(${rq.isLogined()==false}){
			alert('로그인 후 이용 가능합니다.');
			return;
		}						
		$.get('../reactionPoint/doGoodReaction', {
			relId : params.id,
			relTypeCode : 'article',
			ajaxMode : 'Y'
		}, function(data) {
			if(data.fail){
				alert(data.msg);
				return;					
			}
			if(data.resultCode=='S-2'){
				$('.good').addClass('btn-outline');
			}
			
			if(data.resultCode=='S-1'){
				$('.good').removeClass('btn-outline');
			}
			
			$('.good').empty().html('좋아요 👍 : '+data.data1);	
			
		}, 'json');		
	}
	
	//싫어요 버튼 클릭시 실행
	function badReactionPoint() {
		if(${rq.isLogined()==false}){
			alert('로그인 후 이용 가능합니다.');
			return;
		}						
		$.get('../reactionPoint/doBadReaction', {
			relId : params.id,
			relTypeCode : 'article',
			ajaxMode : 'Y'
		}, function(data) {
			if(data.fail){
				alert(data.msg);
				return;					
			}
			if(data.resultCode=='S-2'){
				$('.bad').addClass('btn-outline');
			}
			
			if(data.resultCode=='S-1'){
				$('.bad').removeClass('btn-outline');
			}
			
			$('.bad').empty().html('싫어요 👎 : '+data.data1);	
			
		}, 'json');		
	}
	
	//좋아요, 싫어요 버튼의 배경색 추가
	function selectedReactionPoint() {
		if(${isSelectedGoodReactionPoint}){ 
			$('.good').removeClass('btn-outline');
		}
		if(${isSelectedBadReactionPoint}){ 
			$('.bad').removeClass('btn-outline');
		}
	}
	
	//댓글 작성
	var replyWrite__submitDone = false;
	function ReplyWrite__submitForm(form) {
		
		if(replyWrite__submitDone){
			alert('이미 처리중 입니다.');
			return;
		}
		form.body.value = form.body.value.trim();
		
		if(form.body.value.length == 0){
			alert('댓글을 입력해 주세요.');
			form.body.focus();
			return;
		}
		
		form.submit();
		replyWrite__submitDone = true;
	}
	
	$(function() {
		// 실전코드
		//ArticleDetail__increaseHitCount();
		// 연습코드
		setTimeout(ArticleDetail__increaseHitCount, 2000);
		selectedReactionPoint();
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
						<td>
							<div class="toast-ui-viewer">
								<script type="text/x-template">${article.body}</script>
							</div>
						</td>				
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
						<td>				
							<button class="btn btn-outline btn-xs good" onclick="goodReactionPoint()">좋아요 👍 : ${article.goodReactionPoint}</button>
							<button class="btn btn-outline btn-xs bad" onclick="badReactionPoint()">싫어요 👎 : ${article.badReactionPoint}</button>
						</td>
					</tr>
				</tbody>								
			</table>
			<div class= "btns flex justify-end">
				<c:if test ="${article.extra__actorCanModify}">
					<a class ="btn-text-link btn btn-active btn-ghost mx-4" href="modify?id=${article.id }">수정</a>				
				</c:if>
				<c:if test ="${article.extra__actorCanDelete}">
					<a class ="btn-text-link btn btn-active btn-ghost" onclick="if(confirm('삭제하시겠습니까?') == false) return false;" href="doDelete?id=${article.id }">삭제</a>
				</c:if>				
				<c:if test= "${not empty param.listUri}" >			
					<a class ="btn-text-link btn btn-active btn-ghost mx-4" href="${param.listUri}">뒤로가기</a>
				</c:if>
				<c:if test= "${empty param.listUri}" >			
					<button class ="btn-text-link btn btn-active btn-ghost mx-4" onclick="history.back();">뒤로가기</button>
				</c:if>	
			</div>
		</div>
	</div>
</section>	
<section class="mt-5">
	<div class="container mx-auto px-3">
		<h2>댓글 작성</h2>
		<c:if test="${rq.logined }">
			<form class="table-box-type-1" onsubmit="ReplyWrite__submitForm(this); return false;" method="POST" action="../reply/doWrite">
				<input type="hidden" name="relTypeCode" value="article" />
				<input type="hidden" name="relId" value="${article.id }" />
				<input type="hidden" name="replaceUri" value="${rq.currentUri}" />
				<table class="table table-zebra w-full">
					<colgroup>
						<col width="200" />
					</colgroup>

					<tbody>
						<tr>
							<th>작성자</th>
							<td>${rq.loginedMember.nickname }</td>
						</tr>
						<tr>
							<th>내용</th>
							<td>
								<textarea required="required" class="textarea textarea-bordered w-full" name="body"
									placeholder="댓글을 입력해주세요" rows="5"/></textarea>
							</td>
						</tr>
						<tr>
							<th></th>
							<td>
								<button class="btn btn-active btn-ghost" type="submit">댓글작성</button>
							</td>
						</tr>
					</tbody>	
				</table>
			</form>
		</c:if>
		<c:if test="${rq.notLogined}">
			<a class="btn-text-link btn btn-active btn-ghost" href="${rq.loginUri }">로그인</a> 후 이용해주세요
		</c:if>
	</div>
</section>
<section class="mt-5">
	<div class="container mx-auto px-3 mb-8">
		<h2>댓글 리스트</h2>
		<div class="replyList">
<!-- ajax로 리스팅 -->	
		</div>
	</div>
</section>
<%@ include file="../common/foot.jspf" %>