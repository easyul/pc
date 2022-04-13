<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>어데 피씹니까?</title>
<link rel="stylesheet" type="text/css" href="${path}/resources/bootstrap/css/bootstrap(1).css">
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
			<form action="login.do" method="post" name="frm">
				<h3>로그인</h3>
				<div class="form-group">
					<input type="text" name="id" required="required" autofocus="autofocus" placeholder="ID" class="form-control">
				</div>
				<div class="form-group">
					<input type="password" name="password" required="required" placeholder="Password" class="form-control">
				</div>
				<div class="btn-group">
					<input type="submit" value="Login" class="btn btn-primary">
				</div>
			</form>	
			<button onclick="location.href='findIdForm.do'" class="btn btn-primary">아이디 찾기</button>
			<button onclick="location.href='findPwForm.do'" class="btn btn-primary">비밀번호 찾기</button>
		</div>
	</div>
</div>
</div>
</body>
</html>