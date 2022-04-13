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
		height: 500px;
		border-radius: 20px;
		background-color: white;
	}
	.formform {
		display: flex;
		justify-content: center;
		align-items: center;
		width: 70%;
		height: 90%;
	}
	.btn_ok{
		margin: 30px;
	}
	.form-control {
		width: 300px;
	}
	.btn-primary {
		margin: 0 10px;
	}
	.navi_admin{
		float: left;
	/* 	margin-top: 50px; */
		width: 200px;
		margin-left: -50px;
		margin-right: 30px;
		z-index: 100;
	}
	
</style>
<script type="text/javascript">

</script>
</head>
<body>
<div class="content_center">
<div class="total_content">
	<div class="navi_admin"> 
		<ul class="sidebar">
			<li><a href="passChkForm.do">회원정보 수정</a></li>
			<li><a href="reserveList.do">예매내역</a></li>
			<li><a href="mybookmark.do">즐겨찾기</a></li>
			<c:if test="${memberSession.identity == '점주' }">
               <li><a href="mypcUpdateForm.do">가맹점 수정</a></li>
               <li><a href="seatForm.do?pcno=${pc.pcno}">좌석배치 수정</a></li>
               <c:if test="${f1 == 'null' }">
               <li><a href="feeInsertForm.do?pcno=${pc.pcno}">요금 입력</a></li>
               </c:if>
               <c:if test="${f1 != 'null' }">
               <li><a href="feeUpdateForm.do?pcno=${pc.pcno}">요금 수정</a></li>
               </c:if>
            </c:if>
		</ul>
	</div>
	<form class="formform" action="passChk.do">
		<div class="join_content content_id">
			<input class="form-control" type="password" name="password" autofocus="autofocus" required="required" placeholder="암호를 입력하세요">
			<input class="btn btn-primary" type="submit" value="확인">
		</div>
	</form>
</div>
</div>
</body>
</html>