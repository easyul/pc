<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>어데 피씹니까?</title>
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.14.0/css/all.css"
	integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc"
	crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style type="text/css">
.font_family {
	font-family: InfinitySans-RegularA1;
	margin: 0 50px;
}
.reply_likes{
	width: 45px;
	font-size: 12px;
	height: 25px;
	margin: 0 1px;
	border-radius: 4px;

	border: 0;
}
.reply_list{
	display: flex;
	width: 100%;
	align-items: center;
}
.reply_btn {
	display: flex;
	width: 100%;
	justify-content: flex-end;
	align-items: center;
}
.reply_writer{
	display:flex;
	width: 100%;
	align-items: flex-end;
}
.reply_reg_date{
	margin-left: 5px;
	font-size: 4px;
}
.container {
	display: flex;
	justify-content: center;
	width: 100%;
	margin: 0;
	margin-top: -30px;
}
.btn_likes{
	margin: 2px 5px;
}
.btn-primary {
	margin: 5px;
}
.container_inner {
	width: 100%;
	margin-top: -30px;
}
</style>
<script type="text/javascript">
function rDelete(pcno,bno,rno) {
	var sendData = 'pcno='+pcno+'&bno='+bno+'&rno='+rno;
	$.post('rDelete.do', sendData, function(data) {
		alert("댓글이 삭제 되었습니다");
		$('#disp').html(data);
	});
}
function rUpdate(pcno,bno,rno) {
	var txt = $('#td_'+rno).text();	
	$('#td_'+rno).html("<textarea rows='3' cols='50' id='rt_"+rno+"'>" +
			txt+"</textarea>");
	$('#btn_'+rno).html("<button onclick='up("+pcno+","+bno+","+rno+")'"+
		" class='reply_likes btn-primary'><i class='far fa-check-circle'></i></button> "+
		"<button onclick='lst("+pcno+","+bno+")'" +
		" class='reply_likes btn-danger'><i class='far fa-times-circle'></i></button>");
}
function lst(pcno,bno) {
	$('#disp').load('replyList.do?pcno='+pcno+'&bno='+bno);
}
function up(pcno,bno,rno) {
	var sendData = "content="+$('#rt_'+rno).val()+"&pcno="+pcno+"&bno="+bno+"&rno="+rno;
	$.post("rUpdate.do", sendData, function(data) {
		alert("댓글 수정 되었습니다");
		$('#disp').html(data);
	});
}
function rLikes(pcno,bno,rno) {
	var sendData = 'pcno='+pcno+'&bno='+bno+'&rno='+rno;
	$.post('reply_likes.do', sendData, function(data) {
		$('#disp').html(data);
	});
}
</script>
</head>
<body style="width: 100%;">
		<div class="container_inner">
			<c:if test="${empty list }">
				<div>댓글이 없습니다.</div>
			</c:if>
			<c:if test="${not empty list }">
				<c:forEach var="board_reply" items="${list }">
					<hr>
					<div class="reply_update">
						<c:if test="${board_reply.del == 'y' }">
							<div><br>
							<span>삭제된 댓글입니다.</span><br>
							</div>
						</c:if>
						<c:if test="${board_reply.del != 'y' }">
 							<div class="reply_list">
								<div class="reply_writer">
									<div style="color: black;">${board_reply.nick_name}</div>
									<div class="reply_reg_date">
										<fmt:formatDate value="${board_reply.reg_date }" pattern="yyyy.MM.dd E a HH:mm:ss" />
									</div>
								</div>
								<div class="reply_btn">
									<!-- 추천을 안한 사람 일 때 -->
 									<c:if test="${board_reply.likesConfirm == 0}"> 
 										<button class="reply_likes btn-secondary btn_likes"
 											onclick="rLikes(${board_reply.pcno},${board_reply.bno},${board_reply.rno})"><i class="far fa-thumbs-up"></i>${board_reply.likes }</button>
									</c:if>
									<!-- 추천을 한 사람 일때 -->
									<c:if test="${board_reply.likesConfirm == 1}">
										<button class="reply_likes btn-secondary btn_likes" 
											onclick="rLikes(${board_reply.pcno},${board_reply.bno},${board_reply.rno})"><i class="fas fa-thumbs-up"></i>${board_reply.likes }</button>
									</c:if> 
									<!-- 수정/삭제 -->
									<c:if
										test="${memberSession.mno == board_reply.mno || memberSession.id == 'admin'}">
										<div id="btn_${board_reply.rno }">
											<c:if test="${memberSession.mno == board_reply.mno }">
												<button class="reply_likes btn btn-primary"	onclick="rUpdate(${board_reply.pcno},${board_reply.bno},${board_reply.rno})"><i class="far fa-edit"></i></button>
											</c:if>
											<button class="reply_likes btn btn-danger" onclick="rDelete(${board_reply.pcno},${board_reply.bno},${board_reply.rno})"><i class="far fa-trash-alt"></i></button>
										</div>
									</c:if>
								</div>
								<br>
							</div>
							<div class="origin_content" id="td_${board_reply.rno }"><pre>${board_reply.content}</pre></div>
						</c:if>
					</div><br>
				</c:forEach><br><br>
			</c:if>
		</div>
</body>
</html>