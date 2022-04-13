<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>어데 피씹니까?</title>
</head>
<body>
	<c:if test="${result > 0 }">
		<script type="text/javascript">
 			alert("가맹문의가 완료되었습니다. 좌석배치와 요금설정을 해주세요.");
			location.href = "seatInsertForm.do";
		</script>
	</c:if>
	<c:if test="${result == 0 }">
		<script type="text/javascript">
			alert("사업자등록번호나 전화번호를 다시 확인해주세요.");
			history.back();
		</script>
	</c:if>	
</body>
</html>