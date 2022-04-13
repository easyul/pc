<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>어데 피씹니까?</title>
<%-- <link rel="stylesheet" type="text/css" href="${path}/resources/bootstrap/css/bootstrap.min.css">   --%>
<script type="text/javascript" src="${path}/resources/bootstrap/js/jquery.js"></script>
<script type="text/javascript" src="${path}/resources/bootstrap/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="${path}/resources/bootstrap/css/bootstrap(1).css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style type="text/css">
	#seatPosition input {
		position: absolute;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
		width: inherit;
		height: inherit;
		margin-bottom: 0;
		z-index: -1;
		opacity: 0; 
	}
	.seatLabel {
		font-size: 13px;
		padding: 3px 0;
		width: 40px;
		margin: 2px 2px;
		border: 1px solid rgba(0, 0, 0, 0.5); 
	}
	.seatLabel.active{
		background-color: rgba(255, 255, 255, 0.8);
	}
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
	}
	.navi_admin{
		float: left;
	/* 	margin-top: 50px; */
		width: 200px;
		margin-left: -50px;
		margin-right: 30px;
		z-index: 100;
	}
	.seat-content {
		display: flex;
		justify-content: center;
		align-items: center;
		flex-direction: column;
		width: 80%;
		height: 90%;
		margin-left: 20px;
	}
	.seatLabel.active{
		background-color: rgba(0, 50, 100, 0.5);
	}
	.seat-btn {
		margin-top: 20px;
		width: 150px;
		right: 0;
	}
</style>
<script type="text/javascript">
function seatSize() {
	$("#seatPosition").html("");
	var width = $("select[name=seatlow]").val();
	var height = $("select[name=seatcol]").val();
	for(var i = 1; i <= width; i++) {
		for(var j = 1; j <= height; j++) {
			$("#seatPosition").append('<label class="seatLabel btn" for="c' + i +'-' + j +'">' + i +'-' + j +'</lable>');
			$("#seatPosition").append('<input id="c' + i +'-' + j +'" class="seat" name="seatposition" type="checkbox" value="'+ i +'-' + j +'"/>');
		}
		$("#seatPosition").append('<br>');
	}
	$('.seatLabel').on('click', function(){
		if ($(this).hasClass("active")) { 
		// active class 제거
			$(this).removeClass("active");
		}
		else {
    	// active class 추가
			$(this).addClass('active');
		}
	});
};
</script>
</head>
<body onload="seatSize()">
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
							<li><a href="feeInsertForm.do">요금 수정</a></li>
						</c:if>
						<c:if test="${f1 != 'null' }">
							<li><a href="feeUpdateForm.do">요금 수정</a></li>
						</c:if>
					</c:if>
				</ul>
			</div>
			<div class="seat-content">
				<h3>좌석 배치 수정</h3>
				<form action="seatSetting.do" name="frm" method="post">
					<span>피씨방 좌석 구조</span> <select name="seatlow">
						<option value=${pc.seatlow }>현재 값(${pc.seatlow })</option>
						<c:forTokens var="i" items="10,15,20,25,30" delims=",">
							<option value=${i }>${i }</option>
						</c:forTokens>
					</select> <select name="seatcol">
						<option value=${pc.seatcol }>현재 값(${pc.seatcol })</option>
						<c:forTokens var="j" items="10,15,20,25,30" delims=",">
							<option value=${j }>${j }</option>
						</c:forTokens>
					</select> 
					<input type="button" onclick="seatSize()" value="좌석 배치">
					<div id="seatPosition"></div>
					<input type="hidden" name="pcno" value="${pcno }"> 
					<input class="btn btn-primary seat-btn" type="submit" value="저장">
				</form>
			</div>
		</div>
	</div>
</body>
</html>