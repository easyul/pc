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
<c:if test="${result > 0}">
	<script type="text/javascript">
		alert("로그인 되었습니다.");
		location.href="main.do";
	</script>
</c:if>
<c:if test="${result == 0}">
	<script type="text/javascript">
		alert("암호를 다시 입력해주세요.");
		history.go(-1);
	</script>
</c:if>
<c:if test="${result == -1}">
	<script type="text/javascript">
		alert("없는 아이디입니다.");
		history.go(-1);
	</script>
</c:if>
<c:if test="${result == -2}">
	<script type="text/javascript">
		alert("블랙리스트에 추가된 아이디입니다.");
		history.go(-1);
	</script>
</c:if>
</body>
</html>