<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>어데 피씹니까?</title>
</head>
<body>
<c:if test="${result > 0 }">
	<script type="text/javascript">
		alert("작성되었습니다.");
		location.href="boardList.do?pcno=${board.pcno}&pageNum=${pageNum}";
	</script>
</c:if>
<c:if test="${result == 0 }">
	<script type="text/javascript">
		alert("작성 실패하였습니다. 다시 시도해주세요.");
		history.go(-1);
	</script>
</c:if>
</body>
</html>