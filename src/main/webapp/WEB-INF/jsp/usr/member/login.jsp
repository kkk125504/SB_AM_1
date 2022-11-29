<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="LOGIN" />
<%@ include file="../common/head.jspf" %>
	<section class="mt-8 text-xl">
		<div class="container mx-auto px-3">
			<form class="table-box-type-1" method="post" action="doLogin">
				<input type="hidden" name="afterLoginUri" value="${param.afterLoginUri}"/>				
				<table class="min mx-auto">
				<colgroup>
				<col width ="200" />		
				</colgroup>					
						<tbody>						
							<tr>
								<td>아이디 </td>
								<td><input type="text" name="loginId" autocomplete="off" placeholder="아이디를 입력해주세요." /></td>
							</tr>
							<tr>
								<td>비밀번호 </td>
								<td><input type="password" name="loginPw" autocomplete="off" placeholder="비밀번호를 입력해주세요." /></td>
							</tr>
							<tr>
								<td></td>
								<td>
									<button class="btn btn-active btn-ghost" type="submit">로그인</button>
								</td>
							</tr>
							<tr>
								<td></td>
								<td>
									<a href="${rq.findLoginIdUri }" class="btn btn-active btn-ghost" type="submit">아이디 찾기</a>
									<a href="${rq.findLoginPwUri }" class="btn btn-active btn-ghost" type="submit">비밀번호 찾기</a>
								</td>
							</tr>					
						</tbody>
				</table>
				<div class="btns flex justify-end btns-box-type-1 mt-2">
					<button class="btn btn-active btn-ghost mx-4" type="button" onclick="history.back()">뒤로가기</button>
				</div>	
			</form>			
		</div>
	</section>
<%@ include file="../common/foot.jspf" %>