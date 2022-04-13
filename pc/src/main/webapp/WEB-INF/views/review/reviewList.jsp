<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>어데 피씹니까?</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="${path}/resources/bootstrap/css/bootstrap(1).css">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.14.0/css/all.css"
	integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc"
	crossorigin="anonymous">
<script type="text/javascript">
	$(document).ready(function() {
		$("#popup_open").click(function() {
			$("#popup_wrap").css("display", "block");
			$("#mask").css("display", "block");
		});
		$("#popup_close").click(function() {
			$("#popup_wrap").css("display", "none");
			$("#mask").css("display", "none");
		});
	});
	
	$(function() {		
		$('#wInsert').click(function() {
			var sendData = $('#frm1').serialize();
			$.post('wInsert.do',sendData, function(data) {
				alert("댓글이 작성 되었습니다");
				$('#review').html(data);
				location.reload();
				frm1.content.value="";// 작성했던 댓글 삭제
			});	 	 
			$('#popup_wrap').css("display", "none");
			$('#mask').css("display", "none");
			
		});
	});
	
	function wDelete(pcno,rno) {
		var sendData = 'pcno='+pcno+'&rno='+rno;
		$.post('wDelete.do', sendData, function(data) {
			alert("리뷰가 삭제 되었습니다");
			$('#review').html(data);
			location.reload();
		});
	}
	function wUpdate(pcno,rno) {
		var txt = $('#td_'+rno).text().trim();
		$("#popup_wrap").css("display", "block");
		$("#mask").css("display", "block");
		$('#tr_a').html("<textarea align='center' rows='5' cols='40' id='rt_"+rno+"'>" +
				txt+"</textarea>");
		$('#tr_c').html("<div class=star-rating id='pre-rating'>"+"<input type='radio' id='5-stars' name='rating' value='5' onclick='strnum(5)'/>"+
				  "<label for='5-stars' class='star'>&#9733</label>"+
				"<input type='radio' id='4-stars' name='rating' value='4' onclick='strnum(4)'/>"+
				  "<label for='4-stars' class='star'>&#9733</label>"+
				 "<input type='radio' id='3-stars' name='rating' value='3' onclick='strnum(3)'/>"+
				  "<label for='3-stars' class='star'>&#9733</label>"+
				 "<input type='radio' id='2-stars' name='rating' value='2' onclick='strnum(2)'/>"+
				  "<label for='2-stars' class='star'>&#9733</label>"+
				 "<input type='radio' id='1-stars' name='rating' value='1' onclick='strnum(1)'/>"+
				  "<label for='1-stars' class='star'>&#9733</label>"+"</div>");		
		$('#btn_b').html("<button onclick='up("+pcno+","+rno+")'"+
			" class='review_likes btn-primary'>수정</button> "+
			"<button onclick='lst("+pcno+")'" +
			" class='review_likes btn-danger'>취소</button>");
	}
	function strnum(num) {
		$('#pre-rating').val(num);
	}
	
	function lst(pcno) {
		$('#mask').load('reviewList.do?pcno='+pcno);
	}
	function up(pcno,rno) {
		var sendData = "content="+$('#rt_'+rno).val()+"&pcno="+pcno+"&rno="+rno+"&rating="+$('#pre-rating').val();
		$.post("wUpdate.do", sendData, function(data) {
			alert("리뷰 수정 되었습니다");
			$('#review').html(data);
		});
	} 
	function wLikes(pcno,rno,pageNum) {
		var sendData = 'pcno='+pcno+'&rno='+rno+'&pageNum='+pageNum;
		$.post('review_likes.do', sendData, function(data) {
			$('#review').html(data);
		});
	}
	
</script>
<style type="text/css">
/* 별점 */
.star-rating {
  border:solid 1px white;
  display:flex;
  flex-direction: row-reverse;
  font-size:1.5em;
  justify-content:space-around;
  padding:0 .2em;
  text-align:center;
  width:5em;
}

.star-rating input {
  display:none;
}

.star-rating label {
  font-size:50px;
  color:#ccc;
  cursor:pointer;
}

.star-rating :checked ~ label {
  color:#f90;
}

.star-rating label:hover,
.star-rating label:hover ~ label {
  color:#fc0;
}

.btn_review {
	display: inline-block;
	vertical-align: top;
	margin: -5px 0 1px 8px;
	width: 86px;
	height: 29px;
	text-align: center;
	color: #000;
	font-weight: bold;
	font-size: 13px;
	line-height: 28px;
	border: 1px solid #b7b7b7;
	border-radius: 3px;
	background-color: #fff;
}

#popup_wrap {
	width: 560px;
	height: 470px;
	background: #fff;
	border: solid 1px #666666;
	position: fixed;
	top: 50%;
	left: 50%;
	margin: -250px 0 0 -250px;
	z-index: 9999;
	display: none;
}

#mask {
	width: 100%;
	height: 100%;
	position: fixed;
	background: rgba(0, 0, 0, 0.7) repeat;
	top: 0;
	left: 0;
	z-index: 999;
	display: none;
}

.popup-cont01 {
	width: 478px;
	margin: 40px auto;
	text-align: center;
}
.review_likes{
/* 	width: 50px; */
/* 	font-size: 12px; */
	height: 30px;
	margin: 10px 1px;
}
.review_list{
	display: flex;
	width: 100%;
	align-items: center;
}
.review_btn {
	display: flex;
	width: 100%;
	justify-content: flex-end;
	align-items: center;
}
.review_writer{
	display:flex;
	width: 100%;
	align-items: flex-end;
 	fonr-size: 6px; 
}
.review_reg_date{
	margin-left: 5px;
 	font-size: 4px; 
}
 .reviewList {
  	width: 90%;  
 } 
.review_nick{
	color: black;
	font-weight: bold;
	font-size: 13px;
}
.btn_size {
  	width: 43px;  
  	height: 27px; 
}
.paging {
	display: flex;
	justify-content: center;
	align-items: center;
}
.review_star_on {
   color:#f90;
   font-size:13px;
}

.review_star_off {
     color:#ccc;
     font-size:13px;
}
.origin_content {
	font-size: 15px;
}
.rightTitle {
	display: flex;
	justify-content: center;
	width: 100%;
	position: relative;
}
.reviewBtn {
	position: absolute;
	right: 5%;
	top: -5px;
}
.reviewText {
	resize: none;
}
.reBtns {
	margin-top: 15px;
}
	.margin-btn {
	margin: 0 2px;
}
</style>
</head>
<body>
	<div>
		<!-- 레이어 팝업 -->
		<div id="popup_wrap">
			<div class="popup-cont01" align="center" id="popup-cont">
				<form action="" name="frm1" id="frm1">
					<input type="hidden" name="pcno" value="${review.pcno }"> <input
						type="hidden" name="pageNum" value="${pageNum }"> <input
						type="hidden" name="mno" value="${memberSession.mno }">
					<div>
						<strong>평점 등록</strong>
					</div>
					<div class="input_star" align="center">
						<div class="star-rating" id="tr_c">
							  <input type="radio" id="5-stars" name="rating" value="5"/>
							  <label for="5-stars" class="star">&#9733;</label>
							  <input type="radio" id="4-stars" name="rating" value="4"/>
							  <label for="4-stars" class="star">&#9733;</label>
							  <input type="radio" id="3-stars" name="rating" value="3"/>
							  <label for="3-stars" class="star">&#9733;</label>
							  <input type="radio" id="2-stars" name="rating" value="2"/>
							  <label for="2-stars" class="star">&#9733;</label>
							  <input type="radio" id="1-star" name="rating" value="1"/>
							  <label for="1-star" class="star">&#9733;</label>
						</div>
						<strong id="pointStarRatingValue" class="st_point"></strong>
						<p class="point_notice">평점을 선택하세요</p>
					</div>
					리뷰 작성
					<div class="review_title" id="tr_a">
						<textarea class="reviewText" rows="5" cols="40" name="content" placeholder="리뷰를 남겨주세요.pc방과 관련없는 내용은 제재를 받을 수 있습니다."></textarea>
					</div>
					<div class="reBtns" id="btn_b">
						<input type="button" value="확인" id="wInsert" class="btn btn-primary"> &nbsp;&nbsp;
						<button id="popup_close" class="btn btn-primary">닫기</button>
					</div>
				</form>
			</div>
		</div>
		<div class="rightTitle">
			<h4>리뷰</h4>
			<button id="popup_open" class="reviewBtn btn btn-primary">리뷰 등록</button>
		</div>
		<div class="reviewList">
				<c:if test="${empty list }">
					<div>댓글이 없습니다.</div>
				</c:if>
				<c:if test="${not empty list }">
					<c:forEach var="review" items="${list }">
						<div class="review_update">
							<c:if test="${review.del == 'y' }">
								<div>
									<br><span>삭제된 댓글입니다.</span><br>
								</div>
							</c:if>
							<c:if test="${review.del != 'y' }">
								<div class="review_list">
									<div class="review_writer">
										<div class="review_nick">${review.nick_name}</div>
										<c:forEach var="rating" varStatus="status" begin="1" end="${ review.rating }"><div class="review_star_on">&#9733</div></c:forEach>
                             			<c:forEach var="rating" varStatus="status" begin="${ review.rating }" end="4"><div class="review_star_off">&#9734</div></c:forEach>
										<div class="review_reg_date">
											<fmt:formatDate value="${review.reg_date }" pattern="yyyy.MM.dd E a HH:mm:ss" />
										</div>
									</div>
									<div class="review_btn">
										<!-- 추천을 안한 사람 일 때 -->
										<c:if test="${review.likesConfirm == 0}">
											<button class="review_likes btn-secondary btn_size" onclick="wLikes(${review.pcno},${review.rno},${pageNum })">
												<i class="far fa-thumbs-up"></i>${review.likes }</button>
										</c:if>
										<!-- 추천을 한 사람 일때 -->
										<c:if test="${review.likesConfirm == 1}">
											<button class="review_likes btn-secondary btn_size" onclick="wLikes(${review.pcno},${review.rno},${pageNum })">
												<i class="fas fa-thumbs-up"></i>${review.likes }</button>
										</c:if>
										<!-- 수정/삭제 -->
										<c:if
											test="${memberSession.mno == review.mno || memberSession.id == 'admin'}">
											<div>
												<c:if test="${memberSession.mno == review.mno }">
													<button class="review_likes btn-primary btn_size" onclick="wUpdate(${review.pcno},${review.rno})">
														<i class="far fa-edit"></i>
													</button>
												</c:if>
												<button class="review_likes btn-danger btn_size" onclick="wDelete(${review.pcno},${review.rno})">
													<i class="far fa-trash-alt"></i>
												</button>
											</div>
										</c:if>
									</div>
									<br>
								</div>
								<div class="origin_content" id="td_${review.rno }">
									<pre>${review.content}</pre>
								</div>
							</c:if>
						</div>
						<hr>
						<br>
					</c:forEach>
					<br>
					<br>
				</c:if>
		</div>
	</div>
	<ul class="pagination paging">
	<!-- 시작 페이지가 pagePerBlock보다 크면 앞에 보여줄 것이 있다 -->
		<c:if test="${pb.startPage > pb.pagePerBlock }">
			<li><a class="margin-btn btn btn-outline-primary" href="pcMainForm.do?pcno=${review.pcno}&pageNum=1">
				<i class="fas fa-angle-double-left"></i></a></li>
			<li><a class="margin-btn btn btn-outline-primary" href="pcMainForm.do?pcno=${review.pcno}&pageNum=${pb.startPage-1}">
				<i class="fas fa-angle-left"></i></a></li>
		</c:if>
		<c:forEach var="i" begin="${pb.startPage }" end="${pb.endPage }">
			<c:if test="${pb.currentPage==i }">
				<li><a class="margin-btn btn btn-outline-primary active" href="pcMainForm.do?pcno=${review.pcno}&pageNum=${i}">${i}</a></li>
			</c:if>
			<c:if test="${pb.currentPage!=i }">
				<li><a class="margin-btn btn btn-outline-primary" href="pcMainForm.do?pcno=${review.pcno}&pageNum=${i}">${i}</a></li>
			</c:if>
		</c:forEach>
		<!-- 보여줄 것이 남아있는 경우에는 endPage보다 totalPage가 큰경우 -->
		<c:if test="${pb.endPage < pb.totalPage }">
			<li><a class="margin-btn btn btn-outline-primary" href="pcMainForm.do?pcno=${review.pcno}&pageNum=${pb.endPage+1}">
				<i class="fas fa-angle-right"></i></a></li>
			<li><a class="margin-btn btn btn-outline-primary" href="pcMainForm.do?pcno=${review.pcno}&pageNum=${pb.totalPage}">
				<i class="fas fa-angle-double-right"></i></a></li>
		</c:if>
	</ul>
	<div id="mask"></div>
	
</body>
</html>