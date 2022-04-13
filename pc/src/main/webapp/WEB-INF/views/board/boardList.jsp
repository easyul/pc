<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>어데 피씹니까?</title>
<style type="text/css">
.paging {
	display: flex;
	justify-content: center;
}

body {
	background-color: #2c3e50;
}

.content_center {
	display: flex;
	justify-content: center;
	position: relative;
}

.total_content {
	width: 90%;
	height: 90%;
	border-radius: 20px;
	background-color: white;
	padding-left: 50px;
}

.form-control {
	width: 200px;
}

.paging {
	display: flex;
	justify-content: center;
	align-items: center;
}

.join_content {
	display: flex;
	justify-content: flex-end;
}

.btn_ok {
	margin: 30px;
}

.margin-btn {
	margin: 0 2px;
}
</style>
</head>
<body>
	<div class="content_center">
		<div class="total_content">
			<form action="boardList.do">
				<input type="hidden" name="pageNum" value="1">
				<div class="join_content">
					<select name="searchKey" style="margin: 5px;">
						<c:forTokens var="search" items="subject,nick_name,content" delims="," varStatus="i">
							<c:if test="${search==board.searchKey}">
								<option value="${search}" selected="selected">${title[i.index]}</option>
							</c:if>
							<c:if test="${search!=board.searchKey}">
								<option value="${search}">${title[i.index]}</option>
							</c:if>
						</c:forTokens>
					</select> 
					<input type="text" name="searchValue" value="${board.searchValue}" class="form-control"
						placeholder="검색어를 입력하세요."> 
					<input type="submit" value="검색" class="btn btn-primary">
				</div>
			</form>
			<div class="form_line">
				<table class="table table-hover">
					<tr class="table-primary">
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조회수</th>
						<th>좋아요</th>
					</tr>
					<c:if test="${empty list }">
						<tr>
							<td colspan="6">작성된 게시글이 없습니다</td>
						</tr>
					</c:if>
					<c:if test="${not empty list }">
						<c:forEach var="board2" items="${list }">
							<c:if test="${board2.del == 'y' }">
								<tr>
									<td>${board2.bno }</td>
									<td colspan="5">삭제된 글입니다</td>
								</tr>
							</c:if>
							<c:if test="${board2.del != 'y' }">
								<tr
									onclick="location.href='content.do?pcno=${board2.pcno}&bno=${board2.bno}&pageNum=${pb.currentPage}&searchKey=${board.searchKey}&searchValue=${board.searchValue}'"
									style="cursor: hand">
									<td>${board2.bno }</td>
									<td title="${board.content }">${board2.subject }</td>
									<td>${board2.nick_name }</td>
									<td>${board2.reg_date }</td>
									<td>${board2.read_cnt }</td>
									<td>${board2.likes }</td>
								</tr>
							</c:if>
						</c:forEach>
					</c:if>
				</table>
				<ul class="pagination paging">
					<!-- 시작 페이지가 pagePerBlock보다 크면 앞에 보여줄 것이 있다 -->
					<c:if test="${pb.startPage > pb.pagePerBlock }">
						<li><a class="margin-btn btn btn-outline-primary"
							href="boardList.do?pcno=${board.pcno}&pageNum=1&searchKey=${board.searchKey}&searchValue=${board.searchValue}">
								<i class="fas fa-angle-double-left"></i>
						</a></li>
						<li><a class="margin-btn btn btn-outline-primary"
							href="boardList.do?pcno=${board.pcno}&pageNum=${pb.startPage-1}&searchKey=${board.searchKey}&searchValue=${board.searchValue}">
								<i class="fas fa-angle-left"></i>
						</a></li>
					</c:if>
					<c:forEach var="i" begin="${pb.startPage }" end="${pb.endPage }">
						<c:if test="${pb.currentPage==i }">
							<li><a class="margin-btn btn btn-outline-primary active"
								href="boardList.do?pcno=${board.pcno}&pageNum=${i}&searchKey=${board.searchKey}&searchValue=${board.searchValue}">${i}</a></li>
						</c:if>
						<c:if test="${pb.currentPage!=i }">
							<li><a class="margin-btn btn btn-outline-primary"
								href="boardList.do?pcno=${board.pcno}&pageNum=${i}&searchKey=${board.searchKey}&searchValue=${board.searchValue}">${i}</a></li>
						</c:if>
					</c:forEach>
					<!-- 보여줄 것이 남아있는 경우에는 endPage보다 totalPage가 큰경우 -->
					<c:if test="${pb.endPage < pb.totalPage }">
						<li><a class="margin-btn btn btn-outline-primary"
							href="boardList.do?pcno=${board.pcno}&pageNum=${pb.endPage+1}&searchKey=${board.searchKey}&searchValue=${board.searchValue}">
								<i class="fas fa-angle-right"></i>
						</a></li>
						<li><a class="margin-btn btn btn-outline-primary"
							href="boardList.do?pcno=${board.pcno}&pageNum=${pb.totalPage}&searchKey=${board.searchKey}&searchValue=${board.searchValue}">
								<i class="fas fa-angle-double-right"></i>
						</a></li>
					</c:if>
				</ul>
			</div>
			<button class="btn btn-primary btn_ok"
				onclick='location.href="insertForm.do?pcno=${board.pcno}&bno=0&pageNum=1"'>글쓰기</button>
		</div>
	</div>
</body>
</html>