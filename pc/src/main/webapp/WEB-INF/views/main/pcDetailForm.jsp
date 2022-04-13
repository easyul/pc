<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>어데 피씹니까?</title>
<style type="text/css">
	.detailForm{
		position: absolute;
		width: 300px;
		height: 700px;
		z-index: 50;
		top: 0;
		right: 7.5%;
	}
	.detailForm .pcDetail_form {
		height:100%;
		width:300px;
		right:0;
		background-color: rgba(0, 0, 0, 0.5);
	}

	#carousel-example-generic {
		height: 190px;
		display: flex;
		align-items: center;
	}
	.pcDetail_contentInner {
		position: absolute;
		top: 0;
		right: 0;
		background-color: rgba(255, 255, 255, 0.7);
		width: 300px;
		height: 100%;
		border-radius: 20px;
	}
	.pcTitle {
		display: flex;
		justify-content: center;
		align-items: center;
		width: 100%;
		height: 40px;
		padding: 0 15px;
		position: relative;
		font-size: 20px;
		margin: 15px 0;
		margin-top: 20px;
	}
	.pcLikes {
		position: absolute;
		left: 15px;
	}
	.close {
		display: flex;
		justify-content: center;
		align-items: center;
		position: absolute; 
		height: 30px;
		width: 30px;
		top: 0;
		left: -30;
		margin-top: 10px;
		background-color: rgba(255, 255, 255, 0.7);
	}
	.pcStar {
		position: absolute;
		right: 10%;
	}
	.pccontentde {
		margin-top: 0px;
		padding: 5px 10px; 
	}
	.item {
	width: 100%;
	height: 100%;
	display: flex;
	align-items: center;
	}
	.startpoint {
		font-size: 15px;
	}
	.pccontenticon {
		color: rgba(0, 0, 0, 0.5);
		margin-right: 20px;
	}
	.pccontentline {
		display: flex;
		justify-content: center;
		align-items: center;
		margin-left: -10px;
	}
	.contentpc {
		width: 200px;
		top: 0;
	}
	.seatbtn {
		width: 90%;
		margin: 0 5%;
		margin-top: 20px;
	}
</style>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css" integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc" crossorigin="anonymous">
<script type="text/javascript" src="${path}/resources/bootstrap/js/jquery.js"></script>
<script type="text/javascript" src="${path}/resources/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function() {
		$('.pcDetail_btn').on('click', function() {
			$('.detailForm').show();
			('html body').css('overflow', 'hidden');
		})
		$('.close, .pcDetail_form').on('click', function() {
			$('.detailForm').hide();
			$('html body').css('overflow', 'auto');
		})
	})
	function bookmarkClick(pcno) {
		// 피씨방 북마크 클릭
		$.post("bookmark.do", "pcno="+pcno, function(data) {
			var imgSrc = data;
			$(".bookmark").attr("src", imgSrc);
		});
	} 
</script>
</head>
<body>
	<form class="detailForm" action="pcDetail.do" method="post" name="frm">
<!-- 		<div class="pcDetail_form"></div> -->
<!-- 		<div class="pcDetail_content"></div> -->
		<div class="pcDetail_contentInner">
				
				<!-- pc방 헤드라인 -->
				<div class="pcTitle">
					<!-- 북마크 -->
					<div class="pcLikes">
						<c:if test="${sessionScope.memberSession.id != null}">
							<c:if test="${sessionScope.memberSession.id != 'admin'}">
								<img class="bookmark" onclick="bookmarkClick(${pc.pcno})" alt="" src= "${imgSrc}" width="30px" height="30px">
							</c:if> 
						</c:if>
					</div>
					<!-- 북마크 끝 -->
					<a class="pcName nav-link" href="pcMainForm.do?pcno=${pc.pcno }">${pc.pcname}</a>
					<div class="pcStar">
						<span class="startpoint"><i class="fas fa-star"></i>${avgRating}</span>
					</div>
					<div class="close"><i class="fas fa-times"></i></div>
				</div>
				<!-- pc방 헤드라인 끝 -->
				<!-- pc방 사진 -->
				<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
					<!-- Wrapper for slides -->
					<div class="carousel-inner" role="listbox">
						<div class="item active">
							<img alt="" src="resources/upload/${list[0].imagename }">
						</div>
						<c:forEach var="photo" items="${list }" begin="1">
							<div class="item">
								<img alt="" src="resources/upload/${photo.imagename }">
							</div>
						</c:forEach>
					</div>

					<!-- Controls -->
					<a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev"> 
						<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
						<span class="sr-only">Previous</span>
					</a> 
					<a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next"> 
						<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
						<span class="sr-only">Next</span>
					</a>
				</div>
				<!-- pc방 사진 끝 -->
				
				<!-- pc방 info -->
				<div class="pcContent">
					<input type="button" onclick='location.href="reservationForm.do?pcno=${pc.pcno}"' class="seatbtn btn btn-primary btn-reserve" value="좌석예약">
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
	</form>
</body>
</html>