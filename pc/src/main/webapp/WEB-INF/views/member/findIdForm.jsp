<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
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
	.login_dis {
	position: relative;
	justify-content: center;
	left: 50%;
}
	.jumbotron {
		margin-top: 100px;
	}
</style>
</head>
<body>
<div class="content_center">
<div class="total_content ">
	<div class="login_dis">
		<div class="jumbotron">
		<h3>아이디 찾기</h3>
		<form action="findId.do" method="post" name="frm">
			<div class="form-group">
				<input type="text" name="name" required="required" autofocus="autofocus" placeholder="이름" class="form-control">
			</div>
			<div class="form-group">
				<input type="tel" name="phone" required="required" placeholder="전화번호" class="form-control">
			</div>
			<div class="btn-group">
				<input type="submit" value="확인" class="btn btn-primary">
			</div>
		</form>
		<div>
			<button onclick="location.href='findPwForm.do'" class="btn btn-primary">비밀번호 찾기</button>
		</div>
		</div>
	</div>
</div>
</div>
</body>
</html>