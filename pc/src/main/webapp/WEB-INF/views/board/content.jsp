<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>어데 피씹니까?</title>
<link rel="stylesheet" type="text/css" href="${path}/resources/bootstrap/css/content.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.14.0/css/all.css"
	integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc"
	crossorigin="anonymous">
<style type="text/css">

 	body {
		background-color: #2c3e50;
	}
	.content_center{
		display: flex;
		justify-content: center;
		align-items: center;
		flex-direction: column;
		}
	.total_content{
		width: 90%; 
		height: 90%;
		border-radius: 20px;
		background-color: white;
		padding: 50px;
		margin-top: -7px;
		
	}  
	.replyContent{
		resize: none;
		width: 100%;
	}
	.boardbtn {
		display: flex;
		justify-content: center;
		align-items: center;
		width: 50px;
		height: 30px;
	}
	.total-btn {
		display: flex;
		justify-content: center;
		align-items: center;
		position: relative;
	}
	.listBtn {
		position: absolute;
		left: 0;
	}
	.deupbtn {
		display: flex;
		justify-content: center;
		align-items: center;
		position: absolute;
		right: 0;
	}
	.likes_cnt {
		margin-left: -10px;
	}
	.likescontent {
		margin-bottom: -30px;
	}
	.total_reply {
		margin-top: 30px;
	}
	.reply_btn {
		width: 100%;
		display: flex;
		justify-content: flex-end;
	}
	.reply_title {
		width: 100%;
		display: flex;
		justify-content: flex-start;
		margin: 5px;
	}
	#disp {
		display: flex;
		justify-content: center;
		width: 100%;
	}
</style>
<script type="text/javascript">
	function del(del_bno) {
		var con = confirm("삭제하시겠습니까?");
		if (con) {
			location.href="boardDelete.do?pcno=${board.pcno}&pageNum=${pageNum}&bno="+del_bno;
		} else alert("삭제가 취소되었습니다.");
	}
	$(function() {
		// 현재 게시글에 해당하는 댓글을 가져와서 보여줘라
		$('#disp').load('replyList.do?pcno=${board.pcno}&bno=${board.bno}&pageNum=${pageNum}');
		$('#rInsert').click(function() {
			var sendData = $('#frm1').serialize();
			$.post('rInsert.do',sendData, function(data) {
				alert("댓글이 작성 되었습니다");	
				$('#disp').html(data);
				frm1.content.value="";  // 작성했던 댓글 삭제
			});
		});
	});
	function likesClick(bno) {
		// 게시글 좋아요 클릭
		$.post("board_likes.do", "bno=" + bno, function(data) {
			var likes = data.split(",")[0];
			var imgSrc = data.split(",")[1];
			$(".likes_cnt").text(likes);
			$(".likes_cnt").siblings("img").attr("src", imgSrc);
		});
	}
</script>

</head>
<body>
<div class="content_center">
<div class="total_content">
<div class="table">
<div class="table_form1">
	<div class="first">${board.subject }</div>
	<div class="second">| ${nick_name }</div>
	<div class="fourth">조회수 : ${board.read_cnt }</div>
	<div class="third">${board.reg_date }</div>
</div>
	<div class="table_form2">${board.content }</div>
</div>
	<div align="center">
		<div class="likescontent">
			<img class="likes" alt="" src="${imgSrc }" style="width: 40px; height: 40px;" onclick="likesClick(${board.bno})">
			<span class="likes_cnt">${board.likes }</span>
		</div>
		<div class="total-btn">
			<a href="boardList.do?pcno=${board.pcno}&pageNum=${pageNum }&searchKey=${board.searchKey}&searchValue=${board.searchValue}" class="listBtn boardbtn btn btn-secondary btn-sm">목록</a>
			<div class="deupbtn">
				<c:if test="${memberSession.id == 'admin'}">
					<a onclick="del('${board.bno}')" class="boardbtn btn btn-danger"><i class="far fa-trash-alt fa-lg"></i></a>
				</c:if>
		  		<c:if test="${memberSession.nick_name == nick_name}"> 
					<a href="boardUpdateForm.do?pcno=${board.pcno}&bno=${board.bno}&pageNum=${pageNum}&searchKey=${board.searchKey}&searchValue=${board.searchValue}" class="boardbtn btn btn-primary btn-sm"><i class="far fa-edit fa-lg"></i></a>
					<a onclick="del('${board.bno}')" class="boardbtn btn btn-danger btn-sm"><i class="far fa-trash-alt fa-lg"></i></a>
		  		</c:if> 
			</div>
		</div>
		<div class="total_reply">
			<form action="" name="frm1" id="frm1">
				<input type="hidden" name="pcno" value="${board.pcno }">
				<input type="hidden" name="bno" value="${board.bno }">
				<input type="hidden" name="pageNum" value="${pageNum }">
				<input type="hidden" name="mno" value="${memberSession.mno }">
				<div class="reply_title">댓글작성</div>
				<textarea class="replyContent" rows="5" cols="80" name="content"></textarea>
				<div class="reply_btn">
					<input type="button" value="확인" id="rInsert" class="btn btn-primary">
				</div>
			</form>
		</div>
	</div>
	<br>
<div id="disp"></div>
</div>
</div>
</body>
</html>