<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="관리자 페이지" />
<%@ include file="../../usr/common/head.jspf"%>

<section class="mt-8 text-xl">
	<div class="container mx-auto px-3">
		<div class="flex">
			<div>
				회원 수 : <span class="badge">${membersCount}명</span>
			</div>
			<div class="flex-grow"></div>
			<form class="flex">
				<select name="authLevel" class="select select-bordered">
					<option disabled="disabled">회원 타입</option>
					<option value="3">일반</option>
					<option value="7">관리자</option>
					<option value="0">전체</option>
				</select> 
				<select name="searchKeywordTypeCode" class="select select-bordered">
					<option disabled="disabled">검색 타입</option>
					<option value="loginId">아이디</option>
					<option value="name">이름</option>
					<option value="nickname">닉네임</option>
					<option value="loginId,name,nickname">전체</option>
				</select>
				<input name="searchKeyword" type="text" class="ml-2 w-96 input input-borderd" placeholder="검색어를 입력해주세요"
					maxlength="20" value="${param.searchKeyword }"/>
				<button type="submit" class="ml-2 btn btn-ghost">검색</button>
			</form>
		</div>
		<div class="table-box-type-1 mt-3">
			<table class="table table-fixed w-full">
				<colgroup>
					<col width="100" />
					<col width="100" />
					<col width="200" />
					<col width="200" />
					<col width= />
					<col width="200" />
					<col width="200" />
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" class="checkbox-all-member-id" /></th>
						<th>번호</th>
						<th>가입날짜</th>
						<th>수정날짜</th>
						<th>아이디</th>
						<th>이름</th>
						<th>닉네임</th>
					</tr>
				</thead>

				<tbody>
					<c:forEach var="member" items="${members }">
						<tr class="hover">
							<th><input type="checkbox" class="checkbox-member-id" value="${member.id }" /></th>
							<td>${member.id}</td>
							<td>${member.forPrintType1RegDate}</td>
							<td>${member.forPrintType1UpdateDate}</td>
							<td>${member.loginId}</td>
							<td>${member.name}</td>
							<td>${member.nickname}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>				
		<div>
			<button class="btn btn-error btn-delete-selected-members">선택삭제</button>
		</div>
		<form method="POST" name="do-delete-members-form" action="../member/doDeleteMembers">
			<input type="hidden" name="ids" value="" />
			<input type="hidden" name="replaceUri" value="${rq.currentUri}" />
		</form>
		<div class="page-menu mt-3 flex justify-center">
			<div class="btn-group">
				<c:set var="pageMenuLen" value="6" />
				<c:set var="startPage" value="${page - pageMenuLen >= 1 ? page- pageMenuLen : 1}" />
				<c:set var="endPage" value="${page + pageMenuLen <= pagesCount ? page + pageMenuLen : pagesCount}" />
				<c:set var="pageBaseUri" value="?boardId=${boardId }" />
				<c:set var="pageBaseUri" value="${pageBaseUri }&searchKeywordTypeCode=${param.searchKeywordTypeCode}" />
				<c:set var="pageBaseUri" value="${pageBaseUri }&searchKeyword=${param.searchKeyword}" />

				<c:if test="${startPage > 1}">
					<a class="btn btn-sm" href="${pageBaseUri }&page=1">1</a>
					<c:if test="${startPage > 2}">
						<a class="btn btn-sm btn-disabled">...</a>
					</c:if>
				</c:if>
				<c:forEach begin="${startPage }" end="${endPage }" var="i">
					<a class="btn btn-sm ${page == i ? 'btn-active' : '' }" href="${pageBaseUri }&page=${i }">${i }</a>
				</c:forEach>
				<c:if test="${endPage < pagesCount}">
					<c:if test="${endPage < pagesCount - 1}">
						<a class="btn btn-sm btn-disabled">...</a>
					</c:if>
					<a class="btn btn-sm" href="${pageBaseUri }&page=${pagesCount }">${pagesCount }</a>
				</c:if>
			</div>
		</div>
	</div>
</section>
<script>
	$('.checkbox-all-member-id').change(function() {
		const $all = $(this);
		const allChecked = $all.prop('checked');
		$('.checkbox-member-id').prop('checked', allChecked);
	});
	
	$('.checkbox-member-id').change(function() { 
		const checkboxMemberIdCount = $('.checkbox-member-id').length;
		const checkboxMemberIdCheckedCount = $('.checkbox-member-id:checked').length;
		const allChecked = checkboxMemberIdCount == checkboxMemberIdCheckedCount;
		$('.checkbox-all-member-id').prop('checked', allChecked);
	});
</script>
<script>
	$('.btn-delete-selected-members').click(function() {
		const values = $('.checkbox-member-id:checked').map((index, el) => el.value).toArray();
		if ( values.length == 0 ) {
	 		alert('삭제할 회원을 선택 해주세요.');
	 		return;
		}
		if ( confirm('정말 삭제하시겠습니까?') == false ) {
			return;
		}
		document['do-delete-members-form'].ids.value = values.join(',');
		document['do-delete-members-form'].submit();
	});
</script>
<%@ include file="../../usr/common/foot.jspf"%>