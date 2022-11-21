<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 리스트</title>
</head>
<body>
	<table border="2">
		<thead>
			<tr>
				<th>번호</th>
				<th>날짜</th>
				<th>제목</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="article" items="${articles}">
					<tr>
						<td>${article.id }</td>
						<td>${article.regDate.substring(0,10)}</td>
						<td>${article.title}</td>
					</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>