<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>어데 피씹니까?</title>
<style type="text/css">
	body {
		background-color: #2c3e50;
	}
	.content_center{
		display: flex;
		justify-content: center;
		position: relative;
		}
	.total_content{
		width: 90%; 
		height: 90%;
		border-radius: 20px;
		background-color: white;
		padding-left: 0;
	}
	.navi_admin{
	float: left;
	margin-top: 50px;
	width: 200px;
}
	.form-control {
	width: 200px;
}
.join_content {
	display: flex;
	justify-content: flex-end;
}
.paging {
	display: flex;
	justify-content: center;
	align-items: center;
}
	.form_line {
		display: flex;
		justify-content: center;
	}
	.margin-btn {
	margin: 0 2px;
}
/* li a.active { 
	background-color: #2c3e50; 
	color: white; 
}  */
li a:hover:not(.current) { 
	background-color: blue; 
	color: white; 
} 
</style>
</head>
<body>
<div class="content_center">
<div class="total_content">
<div class="navi_admin">
	<ul class="sidebar">
		<li><a href="memberList.do">회원 관리</a></li>
		<li><a href="pcList.do">pc방 관리</a></li>
	</ul>
</div>
	<form action="pcList.do">
		<input type="hidden" name="pageNum" value="1">
		<div class="join_content">
		<select name="searchKey" style="margin:5px;">
			<c:forTokens var="search" items="pcname,pcaddr,pcinfo" delims="," varStatus="i">
				<c:if test="${search==pc.searchKey }">
					<option value="${search}" selected="selected">${title[i.index]}</option>
				</c:if>
				<c:if test="${search!=pc.searchKey }">
					<option value="${search}">${title[i.index]}</option>
				</c:if>
			</c:forTokens>
		</select>
		<input type="text" name="searchValue" value="${pc.searchValue }" class="form-control" placeholder="검색어를 입력하세요.">
		<input type="submit" value="확인" class="btn btn-primary">
		</div>
	</form>
<div class="form_line">
	<table class="table table-hover">
		<tr class="table-primary"><th>번호</th><th>pc방 이름</th><th>위치</th><th>승인여부</th></tr>
		<c:if test="${empty pcList }">
			<tr><td colspan="4">가맹 문의한 pc방이 없습니다.</td></tr>
		</c:if>
		<c:if test="${not empty pcList }">
			<c:forEach var="pc2" items="${pcList }">
				<tr onclick="location.href='pcMainForm.do?pcno=${pc2.pcno}&pageNum=${pb.currentPage}&searchKey=${pc.searchKey}&searchValue=${pc.searchValue}'" style="cursor:hand">
					<td>${pc2.pcno }</td>
					<td>${pc2.pcname }</td>
					<td>${pc2.pcaddr }</td>
					<td>
						<c:if test="${pc2.permit == 'n' }">
							승인 대기중
						</c:if>
						<c:if test="${pc2.permit == 'y' }">
							승인완료
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
</div>
	<ul class="pagination paging">
	<!-- 시작 페이지가 pagePerBlock보다 크면 앞에 보여줄 것이 있다 -->
		<c:if test="${pb.startPage > pb.pagePerBlock }">
			<li><a class="margin-btn btn btn-outline-primary" href="pcList.do?pageNum=1&searchKey=${pc.searchKey}&searchValue=${pc.searchValue}">
				<i class="fas fa-angle-double-left"></i></a></li>
			<li><a class="margin-btn btn btn-outline-primary" href="pcList.do?pageNum=${pb.startPage-1}&searchKey=${pc.searchKey}&searchValue=${pc.searchValue}">
				<i class="fas fa-angle-left"></i></a></li>
		</c:if>
		<c:forEach var="i" begin="${pb.startPage }" end="${pb.endPage }">
			<c:if test="${pb.currentPage==i }">
				<li><a class="margin-btn btn btn-outline-primary active" href="pcList.do?pageNum=${i}&searchKey=${pc.searchKey}&searchValue=${pc.searchValue}">${i}</a></li>
			</c:if>
			<c:if test="${pb.currentPage!=i }">
				<li><a class="margin-btn btn btn-outline-primary" href="pcList.do?pageNum=${i}&searchKey=${pc.searchKey}&searchValue=${pc.searchValue}">${i}</a></li>
			</c:if>
		</c:forEach>
		<!-- 보여줄 것이 남아있는 경우에는 endPage보다 totalPage가 큰경우 -->
		<c:if test="${pb.endPage < pb.totalPage }">
			<li><a class="margin-btn btn btn-outline-primary" href="pcList.do?pageNum=${pb.endPage+1}&searchKey=${pc.searchKey}&searchValue=${pc.searchValue}">
				<i class="fas fa-angle-right"></i></a></li>
			<li><a class="margin-btn btn btn-outline-primary" href="pcList.do?pageNum=${pb.totalPage}&searchKey=${pc.searchKey}&searchValue=${pc.searchValue}">
				<i class="fas fa-angle-double-right"></i></a></li>
		</c:if>
	</ul>
</div>
</div>
</body>
</html>