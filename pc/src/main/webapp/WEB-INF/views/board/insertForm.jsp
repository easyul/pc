<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>어데 피씹니까?</title>
<link rel="stylesheet" type="text/css" href="${path}/resources/bootstrap/css/insertForm.css">
<link rel="stylesheet" href="${path}/resources/ckeditor/contents.css">
<script type="text/javascript" src="${path}/resources/ckeditor/ckeditor.js"></script>
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
		height: 90%;
		border-radius: 20px;
		background-color: white;
		margin-top: 0;
		padding-top: 20px;
	}
	.subject_css {
		width: 100%;
	}
</style>
</head>
<body>
<div class="content_center">
	<div class="total_content">
		<form action="insert.do" method="post">
			<input type="hidden" name="pcno" value="${board.pcno}">
			<input type="hidden" name="bno" value="${board.bno}">
			<input type="hidden" name="pageNum" value="${pageNum}">
			<div>제목</div>
			<div class="subject_css">
				<input class="form-control" maxlength="50" type="text" name="subject" required="required" autofocus="autofocus">
			</div>
			<div>내용</div>
			<div>
				<textarea class="form-control" rows="10" cols="50" name="content" required="required"></textarea>
					<script>
						CKEDITOR.replace('content', {
							height: 500
						});
					</script>
			</div>
			<div class="write_ok">
				<input type="submit" value="확인" class="btn btn-primary">
			</div>
		</form>
	</div>
</div>
</body>
</html>