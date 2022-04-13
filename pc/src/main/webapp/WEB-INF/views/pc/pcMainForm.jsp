<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>어데 피씹니까?</title>
<%-- <link rel="stylesheet" type="text/css" href="${path}/resources/bootstrap/css/bootstrap.min.css">   --%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css" integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc" crossorigin="anonymous">
<script type="text/javascript" src="${path}/resources/bootstrap/js/jquery.js"></script>
<script type="text/javascript" src="${path}/resources/bootstrap/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="${path}/resources/bootstrap/css/bootstrap(1).css">
<link rel="stylesheet" type="text/css" href="${path}/resources/bootstrap/css/pcMainForm.css">
<style type="text/css">
.pcContent {
	width: 90%;
}
.pccontenticon {
	color: rgba(0, 0, 0, 0.5);
	margin-right: 20px;
}
.pccontentline {
	display: flex;
	align-items: center;
}
.contentpc {
	display: flex;
	justify-content: flex-start;
	width: 70%;
	top: 0;
}
.pccontentde {
	margin-top: 0px;
	padding: 5px 10px; 
}
.bookmark_pcname {
	width: 100%;
	align-items: center;
	margin-left: 20px;
	margin-bottom: 10px;
}
.total_content {
	padding: 20px;
}
.btn-between {
	margin: 0 5px;
}
.startBottom {
	margin-bottom: -5px;
	margin-right: 10px;
}
</style>
<script type="text/javascript">
	// 가맹점 승인(관리자만)
	function permit(p_pcno){
		var con = confirm("가맹점 승인하시겠습니까?");
		if(con){
			location.href="pcPermit.do?pageNum=${pageNum}&pcno="+p_pcno;
		}
	}
	function seatSize2() {
		var width = ${pc.seatlow};
		var height = ${pc.seatcol};
		for(var i = 1; i <= width; i++) {
			for(var j = 1; j <= height; j++) {
					$("#seatChoice").append('<label class="seatLabel2 ' + i +'-' + j +'" for="' + i +'-' + j +'">' + i +'-' + j +'</lable>');
					$("#seatChoice").append('<input id="' + i +'-' + j +'" class="seat2" name="seatposition" type="checkbox" value="'+ i +'-' + j +'" disabled="disabled"/>');
			}
			$("#seatChoice").append('<br>');
		}
	 	var seatlists = "${seatlists}";
	 	var ss = seatlists.replace('[','');
	 	var sss = ss.replace(']','');
	 	var array = sss.split(',');
	 	for (var s in array) {
			var trim = array[s].trim();
			$("." + trim).addClass('btn');
			$("#" + trim).removeAttr('disabled');	
		}
	 	$('.seatLabel2').on('click', function(){
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
	function bookmarkClick(pcno) {
		// 피씨방 북마크 클릭
		$.post("bookmark.do", "pcno="+pcno, function(data) {
			var imgSrc = data;
			$(".bookmark").attr("src", imgSrc);
		});
	} 
	$(function() {
		// 현재 게시글에 해당하는 댓글을 가져와서 보여줘라
		$('#review').load('reviewList.do?pcno=${pc.pcno}&pageNum=${pageNum}');
	});
	$(function() {
		$('#seatCurrent').load('seatCurrent.do')
	});
</script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body onload="seatSize2()">
<div class="content_center">
<div class="total_content">
	<!-- 북마크 -->
	<div class="bookmark_pcname">
		<div class="pcLikes">
			<c:if test="${id != null}">
				<c:if test="${id != 'admin'}">
					<img class="bookmark" onclick="bookmarkClick(${pc.pcno})" alt=""
						src="${imgSrc}" width="30px" height="30px">
				</c:if>
			</c:if>
		</div>
		<!-- 북마크 끝 -->
		<h3>${pc.pcname }</h3><h6 class="startBottom"><i class="fas fa-star"></i>${avgRating }</h6>
		<c:if test="${id == 'admin'}">
			<c:if test="${pc.permit == 'n' }">
				<button onclick="permit(${pc.pcno})" class="btn-between btn btn-primary">승인</button>
			</c:if>
			<c:if test="${pc.permit == 'y' }">
				<span class="btn-between admissionPc">승인완료</span>
			</c:if>
		</c:if>
		<button class="btn-between btn btn-primary btn-reserve" onclick='location.href="boardList.do?pcno=${pc.pcno}"'>게시판</button>
		<c:if test="${id == 'admin'}">
			<button class="btn-between btn btn-primary" onclick="location.href='pcList.do?pageNum=${pageNum}'">목록</button>
		</c:if>
		<button onclick='location.href="reservationForm.do?pcno=${pc.pcno}"' class="btn-between btn btn-primary btn-reserve">좌석예약</button>
	</div>
	<div class="left" align="center">
		<div id="carousel-example-generic" class="carousel slide"
			data-ride="carousel">

			<!-- Wrapper for slides -->
			<div class="carousel-inner" role="listbox">
				<div class="item active">
					<img alt="" src="resources/upload/${photolist[0].imagename }">
				</div>
				<c:forEach var="photo" items="${photolist }" begin="1">
					<div class="item">
						<img alt="" src="resources/upload/${photo.imagename }">
					</div>
				</c:forEach>
			</div>

			<!-- Controls -->
			<a class="left carousel-control" href="#carousel-example-generic"
				role="button" data-slide="prev"> <span
				class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
				<span class="sr-only">Previous</span>
			</a> <a class="right carousel-control" href="#carousel-example-generic"
				role="button" data-slide="next"> <span
				class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				<span class="sr-only">Next</span>
			</a>
		</div>
		<div class="pcContent">
			<hr>
			<div class="pccontentde pcNum">
				<div class="pccontentline">
					<i class="pccontenticon fas fa-phone-square-alt"></i>
					<div class="contentpc">${pc.pcpno }</div>
				</div>
			</div>
			<hr>
			<div class="pccontentde pcAddr">
				<div class="pccontentline">
					<i class="pccontenticon fas fa-map-marked-alt"></i>
					<div class="contentpc">${pc.pcaddr }</div>
				</div>
			</div>
			<hr>
			<div class="pccontentde pcInfo">
				<div class="pccontentline">
					<i class="pccontenticon fas fa-envelope-open-text"></i>
					<div class="contentpc">${pc.pcinfo }</div>
				</div>
			</div>
			<hr>
			<div class="pccontentde pcIntro">
				<div class="pccontentline">
					<i class="pccontenticon fas fa-info-circle"></i>
					<div class="contentpc">${pc.pcintro }</div>
				</div>
			</div>
		</div>
	</div>
	<div class="right" align="center">
		<div id="review"></div>		
	</div>
</div>
</div>
</body>
</html>