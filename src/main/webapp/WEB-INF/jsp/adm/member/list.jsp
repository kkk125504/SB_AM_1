<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="관리자 페이지" />
<%@ include file="../../usr/common/head.jspf"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<style>
.chart-box{
width: 500px;
height : 500px;
}
</style>
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
			<table>
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
						<tr>
							<td><input type="checkbox" class="checkbox-member-id" value="${member.id }" /></td>
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

<section>
	<div class="container mx-auto text-xl flex mt-10 justify-around">
		<div>
			<div class ="flex justify-center mb-6">
				<span>게시물 통계</span>
			</div>			
			<span>기간 : </span>
			<input type="date" class ="currentDate input input-bordered max-w-xs" value="" name="startDateForArticleStatistics">
			<span> ~ </span>
			<input type="date" class ="currentDate input input-bordered max-w-xs" value="" name="lastDateForArticleStatistics">
		
			<span class="ml-6">게시판 선택 :</span>
			<select id ="boardId" class="select select-bordered">
				<option value="0">전체</option>									
				<option value="1">나만의 명상방법</option>
				<option value="2">좋은글 / 좋은 글귀</option>
				<option value="3">자유</option>
			</select>
			<button type="button" class="btn btn-active btn-ghost" onclick="ArticleStatisticsChart();">조회</button>				
			<div class="chart-box article-chart-box  mx-auto mt-8">
				<canvas id="article-chart" width="50" height="50"></canvas>
			</div>
		</div>
		
		<div>
			<div class ="flex justify-center mb-6">
				<span>회원 통계</span>
			</div>				
			<span>기간 : </span>
			<input type="date"  class ="currentDate input input-bordered max-w-xs" value="" name="startDateForMemberStatistics">
			<span> ~ </span>
			<input type="date"  class ="currentDate input input-bordered max-w-xs" value="" name="lastDateForMemberStatistics">		
			<button type="button" class="btn btn-active btn-ghost" onclick="MemberStatisticsChart();">조회</button>				
			<div class="chart-box member-chart-box mx-auto mt-8">
				<canvas id="member-chart" width="50" height="50"></canvas>
			</div>
		</div>				
	</div>
</section>

<script>
//통계 날짜 선택시 현재 날짜 입력 
let elements = document.getElementsByClassName('currentDate');

let len = elements.length;
for (let i = 0; i < len; i++){
	 elements.item(i).value = new Date().toISOString().slice(0, 10);
}
</script>
<script>
//게시물 통계 차트 생성
function ArticleStatisticsChart(){
	$('.chartjs-hidden-iframe').remove();
	$('.article-chart-box').html('<canvas id="article-chart" width="50" height="50"></canvas>');
	$.get('/adm/statistics/article', {
		startDate : $('input[name=startDateForArticleStatistics]').val(),
		lastDate : $('input[name=lastDateForArticleStatistics]').val(),
		boardId : $('#boardId').val(),
		ajaxMode : 'Y'
	}, function(data) {			
			new Chart(document.getElementById("article-chart"), {
			    type: 'bar',
			    data: {
			      labels: ["생성글 수", "총 조회수", "평균 조회수", "최고 조회수"],
			      datasets: [
			        {
			          label: "",
			          backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9"],
			          data: [data.articlesCount,data.totalViews,data.averageViews,data.topViews]
			        }
			      ]
			    },
			    options: {
			      legend: { display: false },
			      title: {
			        display: false,
			        text: '게시물 통계'
			      },
			      scales : {
			  		yAxes : [ {
			  			ticks : {
			  				beginAtZero : true, // 0부터 시작하게 
			  				stepSize: 1   // 1 씩 증가하도록 설정
			  			}
			  		} ]
			      }
			    }
			});
		}, 'json');		
	}
// 회원 통계 차트 생성
function MemberStatisticsChart(){
	$('.chartjs-hidden-iframe').remove();
	$('.member-chart-box').html('<canvas id="member-chart" width="50" height="50"></canvas>');
	$.get('/adm/statistics/member', {
		startDate : $('input[name=startDateForMemberStatistics]').val(),
		lastDate : $('input[name=lastDateForMemberStatistics]').val(),
		ajaxMode : 'Y'
	}, function(data) {			
			new Chart(document.getElementById("member-chart"), {
			    type: 'bar',
			    data: {
			      labels: ["신규 회원 수", "탈퇴한 회원 수", "총 회원 수", "총 탈퇴한 회원수"],
			      datasets: [
			        {
			          label: "",
			          backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9"],
			          data: [data.newMembersCount, data.withdrawalMembersCount ,data.totalMembersCount, data.totalWithdrawalMembersCount]
			        }
			      ]
			    },
			    options: {
			      legend: { display: false },
			      title: {
			        display: false,
			        text: '회원 수 통계'
			      },
			      scales : {
			  		yAxes : [ {
			  			ticks : {
			  				beginAtZero : true, // 0부터 시작하게 
			  				stepSize: 1   // 1 씩 증가하도록 설정
			  			}
			  		} ]
			      }
			    }
			});
		}, 'json');	
	}
	
</script>
<%@ include file="../../usr/common/foot.jspf"%>