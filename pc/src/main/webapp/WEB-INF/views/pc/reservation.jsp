<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body> 
	<c:if test="${result > 0 }">
		<script type="text/javascript">
			alert("예약되었습니다.");
			location.href = "pcMainForm.do?pcno=${pcnoSession}";
		</script>
	</c:if>
	<c:if test="${result == 0 }">
		<script type="text/javascript">
			alert("예약이 실패했습니다.");
			history.back();
		</script>
	</c:if>	
	<c:if test="${result == -1 }">
		<script type="text/javascript">
			alert("시간이 오래되어 다시설정하십시오");
			history.back();
		</script>
	</c:if>			
</body>
</html>