<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MODIFY" />
<%@ include file="../common/head.jspf" %>
<script>
	let MemberModify__submitDone = false;
	function MemberModify__submitForm(form){
		if(MemberModify__submitDone){
			alert('이미 처리중 입니다.');
			return;
		}
		form.nickname.value = form.nickname.value.trim();
		if(form.nickname.value.length==0){
			alert('닉네임을 작성해주세요.');
			form.nickname.focus();
			return;
		}
		
		form.cellphoneNum.value = form.cellphoneNum.value.trim();		
		if(form.cellphoneNum.value.length==0){
			alert('전화번호를 작성 해주세요.');
			form.cellphoneNum.focus();
			return;
		}
		
		form.email.value = form.email.value.trim();		
		if(form.email.value.length==0){
			alert('이메일을 작성 해주세요.');
			form.email.focus();
			return;
		}
		
		form.loginPw.value = form.loginPw.value.trim();		
		if(form.loginPw.value.length==0){
			alert('새 비밀번호를 작성 해주세요.');
			form.loginPw.focus();
			return;
		}
		
		form.loginPwConfirm.value = form.loginPwConfirm.value.trim();		
		if(form.loginPwConfirm.value.length==0){
			alert('새 비밀번호 확인을 작성 해주세요.');
			form.loginPwConfirm.focus();
			return;
		}
		
		if(form.loginPw.value != form.loginPwConfirm.value){
			alert('비밀번호가 일치하지 않습니다.');
			form.loginPw.focus();
			return;
		}		
		
		MemberModify__submitDone = true;
		form.submit();		
	}	
	
	function passwordChangeCancel(){
		var passwordChangeContent = "";	
		passwordChangeContent += '<div id="passwordChangeForm">';
		passwordChangeContent += '<button class="btn-text-link btn btn-active btn-ghost" type="button" onclick="passwordChangeForm()">변경</button>';
		passwordChangeContent += '</div>';
		$('#passwordChangeForm').replaceWith(passwordChangeContent);
	}	
	
	function passwordChangeForm(){
		var passwordChangeContent = "";
		passwordChangeContent += '<div id="passwordChangeForm">';
		passwordChangeContent += '새 비밀번호 : <input type="text" class="input input-bordered input-lg" name="loginPw"/>';
		passwordChangeContent += '&nbsp&nbsp&nbsp';
		passwordChangeContent += '새 비밀번호 확인 : <input type="text" class="input input-bordered input-lg" name="loginPwConfirm"/>';
		passwordChangeContent += '<button type="button" class="btn btn-active btn-ghost" onclick="passwordChangeCancel()">취소<button/>';
		passwordChangeContent += '</div>';
		$('#passwordChangeForm').replaceWith(passwordChangeContent);
	}
</script>
<section class="mt-8 text-xl">
	<div class="container mx-auto px-3">
		<form class="table-box-type-1" method="post" action="doModify" onsubmit="MemberModify__submitForm(this); return false">
			<table>
				<colgroup>
					<col width="200" />
				</colgroup>	
				<tbody>				
					<tr>
						<td>가입일</td>
						<td>${rq.loginedMember.regDate }</td>						
					</tr>
					<tr>
						<td>수정일</td>
						<td>${rq.loginedMember.updateDate }</td>						
					</tr>
					<tr>
						<td>아이디</td>
						<td>${rq.loginedMember.id }</td>						
					</tr>
					<tr>
						<td>비밀번호 변경</td>
						<td>
							<div id="passwordChangeForm">
								<button type="button" class="btn btn-active btn-ghost" onclick="passwordChangeForm()">변경</button>	
							</div>
						</td>						
					</tr>
					<tr>
						<td>이름</td>
						<td>${rq.loginedMember.name }</td>						
					</tr>
					<tr>
						<td>닉네임</td>
						<td><input type="text" name="nickname" placeholder="닉네임을 입력해주세요" class="input input-bordered input-lg" value="${rq.loginedMember.nickname }"/></td>						
					</tr>
					<tr>
						<td>전화번호</td>
						<td><input type="text" name="cellphoneNum" placeholder="전화번호를 입력해주세요" class="input input-bordered input-lg" value="${rq.loginedMember.cellphoneNum }"/></td>						
					</tr>
					<tr>
						<td>이메일</td>
						<td><input type="text" name="email" placeholder="이메일을 입력해주세요" class="input input-bordered input-lg" value="${rq.loginedMember.email }"/></td>						
					</tr>						
				</tbody>								
			</table>

			<div class= "btns flex justify-end">
				<button class ="btn-text-link mx-4 btn btn-active btn-ghost" type="submit">회원정보수정</button>					
				<button class ="btn-text-link btn btn-active btn-ghost" type="button" onclick="history.back()">뒤로가기</button>
			</div>
		</form>
	</div>
</section>
<%@ include file="../common/foot.jspf" %>