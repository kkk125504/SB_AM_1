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
</script>
	
<script>
	// 댓글리스트 출력	
	var replyIds = [];
	var index = 0;
	function Reply__List() {
	 replyIds = [];
	 index = 0;
 	 var replyListContent = "";
	  $.ajax({
	        type: "GET",
	        url: "../reply/getReplies",
	        dataType: "json",
	    	async : false,
	    	data : {"relId" : params.id, "relTypeCode" : "article"},
	        error: function() {
	          console.log('통신실패!!');
	        },
	        success: function(data) {	        
			  if(data.data1 == null){
			  replyListContent += "";
			  $('.replyList').html(replyListContent);
			  return;
  			  }
			  
 			 $(data.data1).each(function(){
			  var loginedMemberId = ${rq.loginedMemberId};
			  var replyMemberId= this.memberId;
			  var params__reply = '\''+this.id+'/'+this.regDate+'/'+this.forPrintBody+'/'+this.extra__writerName+'/'+this.relTypeCode+'\'';			
			  replyIds[index] = this.id;
  			  index++;
  			  replyListContent += '<div class="divider"></div>';
  			  replyListContent += '<div id = "reply'+ this.id +'">';
  			  replyListContent += '<div><span class="font-extrabold">';
  			  replyListContent += this.extra__writerName +'</span>';
			  
			  // 댓글 삭제, 수정버튼
			  if(loginedMemberId == replyMemberId){
				  replyListContent += '<button class="ml-4" onclick="Reply__ModifyForm('+params__reply+');">수정</button>';			   
				  replyListContent += '<button class="ml-2" onclick="Reply__Delete('+params__reply+');">삭제</button>';
			  }
			  // 답글쓰기 버튼 노출
			  if(${rq.isLogined()}){
				  replyListContent += '<button class="ml-20" onclick="ReOfRe__WriteForm('+this.id+')">답글쓰기</button>';
			  }
			  
			  replyListContent += '</div>';
			  replyListContent += '<div><span class="font-extrabold">'+this.regDate +'</span></div>';
	   		  replyListContent += '<div><span class="input input-bordered w-full max-w-xs">';  
			  replyListContent += this.forPrintBody+'</span></div>';  
			  replyListContent += '</div>';
   			  
   			  replyListContent += '<div id="ReOfRe__WriteForm'+this.id+'"></div>';
			  
			  // 댓글의 답글 리스트
			  replyListContent += '<div id= re'+this.id+'></div>';
			  });  
			  $('.replyList').html(replyListContent);
			 }
	    });
	}
	
	// 댓글 작성
	function Reply__Write() {  
	 $.ajax({
	        type: "POST",
	        url: "../reply/doWrite",
	        dataType: "json",
	    	async : false,
	    	data : {"relId" : params.id, "relTypeCode" : $('input[name=relTypeCode]').val(), "body" : $('textarea[name=replyBody]').val() },
	        error: function() {
	          console.log('통신실패!!');
	        },
	        success: function(data) {
	      	 if(data.fail){
      		  	alert(data.msg);
      		  	return;
	      	}	        		  
	        }
	 	});
	 	$('textarea[name=replyBody]').val('');
	 	Reply__List();
		ReOfRe__List();	
	}

	// 댓글 수정
	function Reply__Modify(form) {					
		$.get('../reply/doModify', {
			id : form.id.value,
			body : form.body.value
		}, function(data) {
			if(data.fail){
				alert(data.data.msg);
				return;
			}
			Reply__List();
			ReOfRe__List();
		}, 'json');			
	}
	
	// 댓글 수정 폼
 	function Reply__ModifyForm(params__reply) {	 	
	   var params__replySplit = params__reply.split('/');
	   var replyId = params__replySplit[0];
	   var regDate = params__replySplit[1];
	   var body = params__replySplit[2];
	   body= body.replace("<br>", "&#10;");
	   var replyWriter = params__replySplit[3];
	   var replyModifyContent= '';
	   replyModifyContent += '<form>'
	   replyModifyContent += '<div>';
	   replyModifyContent += '<span class="font-extrabold">';
	   replyModifyContent += replyWriter +'</span>';		  				 		 		 
	   replyModifyContent += '</div>';
	   replyModifyContent += '<div><span class="font-extrabold">'+ regDate +'</span></div>';
	   replyModifyContent += '<div>';
	   replyModifyContent += '<input type="hidden" name="id" value="'+replyId+'"/>';
	   replyModifyContent += '<textarea class="input input-bordered w-full max-w-xs" name="body">'+body+'</textarea>';
	   replyModifyContent += '<button type="button" onclick="Reply__Modify(form);">수정</button>';
	   replyModifyContent += '<button type="button" onclick="Reply__List(); ReOfRe__List();">취소</button>';
	   replyModifyContent += '</form>';
	   
	   $('#reply'+replyId).html(replyModifyContent);   
 	}	

	//댓글,답글쓰기 삭제
	function Reply__Delete(params__reply) {		
	 var params__replySplit = params__reply.split('/');
 	 var id = params__replySplit[0];
 	 var relTypeCode = params__replySplit[4];
	 $.ajax({
	        type: "POST",
	        url: "../reply/doDelete",
	        dataType: "json",
	    	async : false,
	    	data : {"id" : id, "relTypeCode" : relTypeCode},
	        error: function() {
	          console.log('통신실패!!');
	        },
	        success: function(data) {
	      	 if(data.fail){
   		  	 alert(data.msg);
   		  	  return;
	      	 }
	      	Reply__List();
			ReOfRe__List();
	        }
	 	});
	 	
	}
			
	// 댓글의 답글 리스팅
	function ReOfRe__List(){
	  if(replyIds.length > 0){
	  for(let i  = 0; i < replyIds.length; i++){	
	  var replyId = replyIds[i];
	  var rorListContent = "";	  
    	$.ajax({
          type: "GET",
          url: "../reply/getReplies",
          dataType: "json",
      	  async : false,
      	  data : { "relId" : replyId , "relTypeCode" : "reply"},
          error: function() {
            console.log('통신실패!!');
          },
          success: function(data) {
          	
          	if(data.data1 == null){
            return;
          	}
        
        	$(data.data1).each(function(){
        	var loginedMemberId = ${rq.loginedMemberId};
 			var replyMemberId= this.memberId;
        	var params__reply = '\''+this.id+'/'+this.regDate+'/'+this.body+'/'+this.extra__writerName+'/'+this.relTypeCode+'\'';		
 			
 			rorListContent += '<div class="ml-12 mt-2" id = "reply'+ this.id +'">'
 			rorListContent += '<div><span class="font-extrabold">↳&nbsp;&nbsp;'
 			rorListContent += this.extra__writerName +'</span>';
         
          if(loginedMemberId == replyMemberId){ 			  
        	  rorListContent += '<button class="ml-2" onclick="Reply__Delete('+params__reply+');">삭제</button>';
		  }
          rorListContent += '</div>';          	
          rorListContent += '<div><span class="mx-8">';  
          rorListContent += this.body+'</span></div>';
          rorListContent += '</div>';           
          });
        	
          $('#re'+replyId).html(rorListContent);   
          }
 		});
 	 }
   }  
}
  	 	
	//답글쓰기 
	function ReOfRe__Write(replyId) {
	  $.get('../reply/doWrite', {
	  relId : replyId,
	  relTypeCode : 'reply',
	  body : $('input[name=ReOfRe'+replyId+']').val()
	  }, function(data) {
	  if(data.fail){
	  alert(data.msg);
	  return;
	  }
	  Reply__List();
	  ReOfRe__List();
	  }, 'json');	
	}
	
	// 답글쓰기 폼
	function ReOfRe__WriteForm(replyId) {
  		var content = '<div>답글쓰기 : <input name="ReOfRe'+replyId+'" type="text" class="input input-bordered input-lg mt-2"/>';
  		content += '<button type="button" class="mx-4" onclick="ReOfRe__Write('+replyId+')">작성</button>';
  		content += '<button type="button" onclick="Reply__List(); ReOfRe__List();">취소</button></div>';
  		$('#ReOfRe__WriteForm'+replyId).html(content);
	}
					
	$(function() {
		// 실전코드
		//ArticleDetail__increaseHitCount();
		// 연습코드
		setTimeout(ArticleDetail__increaseHitCount, 2000);
		selectedReactionPoint();
		Reply__List();
		ReOfRe__List();
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
						<th>번호</th>
						<td><span class="badge">${article.id }</span></td>						
					</tr>
					<tr>
						<th>작성날짜</th>
						<td>${article.regDate }</td>						
					</tr>
					<tr>
						<th>수정날짜</th>
						<td>${article.updateDate }</td>						
					</tr>
					<tr>
						<th>제목</th>
						<td>${article.title }</td>						
					</tr>
					<tr>
						<th>내용</th>
						<td>
							<div class="toast-ui-viewer">
								<script type="text/x-template">${article.body}</script>
							</div>
						</td>				
					</tr>
					<tr>
						<th>작성자</th>
						<td>${article.extra__writer }</td>						
					</tr>
					<tr>
						<th>조회수</th>
						<td><span class="badge article-detail__hit-count">${article.hitCount }</span></td>						
					</tr>
					<tr>
						<th>추천</th>
						<td>				
							<button class="btn btn-outline btn-xs good" onclick="goodReactionPoint()">좋아요 👍 : ${article.goodReactionPoint}</button>
							<button class="btn btn-outline btn-xs bad" onclick="badReactionPoint()">싫어요 👎 : ${article.badReactionPoint}</button>
						</td>
					</tr>
				</tbody>								
			</table>
			<div class= "btns flex justify-end">
				<c:if test ="${article.extra__actorCanModify}">
					<a class ="btn-text-link btn btn-active btn-ghost mx-4" href="modify?id=${article.id }&replaceUri=${rq.encodedCurrentUri}">수정</a>				
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
			<form class="table-box-type-1" onsubmit="return false;" name="replyWriteForm">
				<input type="hidden" name="relTypeCode" value="article" />
				<input type="hidden" name="relId" value="${param.id}" />
				<table class="table w-full">
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
								<textarea required="required" class="textarea textarea-bordered w-full" name="replyBody"
									placeholder="댓글을 입력해주세요" rows="5"/></textarea>
							</td>
						</tr>
						<tr>
							<th></th>
							<td>
								<button class="btn btn-active btn-ghost" type="button" onclick="Reply__Write();">댓글작성</button>
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