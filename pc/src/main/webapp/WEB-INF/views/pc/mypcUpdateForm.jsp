<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>어데 피씹니까?</title>
<link rel="stylesheet" type="text/css" href="${path}/resources/bootstrap/css/registerForm.css">
<script type="text/javascript" src="resources/bootstrap/js/jquery.js"></script>
<style type="text/css">
.service-tit:hover + .layer-service {
    display: block;
   }
   
    .layer-service:hover {
   display: block;
   }

   .clear {
    clear: both;
   }
   
   .layer-service {
   display: none;
   position: absolute;
    left: 0;
    top: 100; 
    width: 500px;
    background: #fff;
    z-index: 2;
    border: 1px solid #d9d9d9;
    padding: 17px 25px 20px;
   }
   
    .service-cont {
       float: left;
       position: relative;
       justify-content: center;
    }
   
   .service-tit {
    display: block;
    width: 500px;
    height: 26px;
    border: 1px solid #000000;
    text-decoration-line: none;
   }
input[type="image"] {
	border: 1px solid;
	width: 100px;
	height: 120px;
}

.color {
	color: red;
}

.a {
	display: inline-block
}

.b {
	display: inline-block
}

.c {
	display: inline-block
}

body {
	background-color: #2c3e50;
}

.total_content {
	width: 90%;
	height: 90%;
	border-radius: 20px;
	background-color: white;
}

.content_center {
	display: flex;
	justify-content: center;
	position: relative;
}

.btn_ok {
	margin: 30px;
}

.btn-primary {
	margin-left: 5px;
}

.form-control {
	width: 500px;
	border: none;
	background-color: white;
	border-bottom: 1px solid #2c3e50;
	margin-bottom: 10px;
}

h3 {
	margin-bottom: 20px;
}
	.navi_admin{
	float: left;
/* 	margin-top: 50px; */
	width: 200px;
	margin-left: -50px;
	margin-right: 30px;
}
.main-content {
	display: flex;
	justify-content: center;
	align-items: center;
/* 	flex-direction: column; */
	width: 80%;
	height: 90%;
	margin-left: 20px;
}
</style>
<script type="text/javascript">
	function upload() { // 업로드 안했을경우
		if (!frm.pcimage.value) {
			alert("사진을 넣어주세요.");
			frm.pcimage.focus();
			return false;
		} else if (!frm.pcinfo.value) {
			alert("정보 입력!")
			frm.pcimage.focus();
			return false;
		}
	}
	$(document).ready(function() {
		$("input[name='info']").on("click", function(e) {
			e.preventDefault();
			fn_chkInfo($(this));

		});
	});

	function fn_chkInfo(obj) {
		if (obj.attr("class") == "_checked color") {
			obj.removeClass("_checked color");
		} else {
			obj.addClass("_checked color");
		}
	}

	function fn_selectInfo() {
		var str = "";
		var strId = "";

		$("input[name='info']").each(function(index, element) {
			if ($(this).attr("class") == "_checked color") {
				str += ((str.length > 0) ? "," : "") + $(this).val().trim();
				strId += ((strId.length > 0) ? "," : "") + $(this).attr("id");
			}
		});
		var selectContent = str;
		if (selectContent.length > 30) {
			selectContent = str.substring(0, 30) + "...";
		}
		$("#selectInfoList").text(selectContent);
		document.getElementById("pcinfo").value = str;
		/* $("#divInfoLayer").hide(); */
	}
</script>
</head>
<body>
<div class="content_center">
	<div class="total_content" align="center">
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
		<div class="main-content">
			<form action="mypcUpdate.do" name="frm" method="post" onsubmit="return upload()" enctype="multipart/form-data">
				<input type="hidden" name="pcno" value="${pc.pcno }">
				<input type="hidden" name="mno" value="${mno }">
				<input type="hidden" name="pclati" value="${pc.pclati }">
				<input type="hidden" name="pclongi" value="${pc.pclongi }">
				<div class="join_total">
					<div class="title_size">가맹점 수정</div>
					<div>사업자등록번호</div>
					<div class="join_content">
						<input type="text" name="pcbusinessnum" value="${pc.pcbusinessnum }" readonly="readonly" class="form-control">
					</div>
					<div>pc방 이름</div>
					<div class="join_content">
						<input type="text" name="pcname" value="${pc.pcname }" required="required" class="form-control">
					</div>
					<div>pc방 전화번호</div>
					<div class="join_content">
						<input type="tel" name="pcpno" value="${pc.pcpno }" required="required" pattern="010-\d{3,4}-\d{4}"
								placeholder="ex)010-1111-1111" title="전화형식 010-숫자3/4-숫자4" class="form-control">
					</div>
					<div>pc방 사진</div>
					<div class="join_content">
						<input type="file" name="pcimage" required="required" multiple="multiple" readonly="readonly" class="form-control">
					</div>
					<div>
						<div>주소</div>
						<div class="join_content content_id">
							<input type="text" name="pcaddr" id="pcaddr" required="required" value="${pc.pcaddr }" class="form-control"
								placeholder="주소" readonly="readonly">
							<input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색" class="btn btn-primary"><br>
						</div>
						<div id="map" style="width:500px; height:300px; margin-top:10px; display:block;"></div>
					</div>
					<br>
					정보(수정 전)		
					<div class="service-cont">
						<a class="service-tit" style="width:500px"> 
							<strong id="selectInfoList1">${pc.pcinfo }</strong>			
						</a>
						<br>
						정보(수정 후)
						<a class="service-tit" style="width:500px"> 
							<strong id="selectInfoList"></strong>				
						</a>
						<div id="divInfoLayer" class="layer-service">
							<p>정보 선택</p>
							<div class="a">									
								<input type="image" src="/pc/resources/images/print.png" name="info" value="프린트" title="프린트">
							<p>
							프린트
							</div>	
							<div class="a">	
								<input type="image" src="/pc/resources/images/dual.png" name="info" value="듀얼모니터" title="듀얼모니터">
							<p>
							듀얼모니터
							</div>	
							<div class="a">	
								<input type="image" src="/pc/resources/images/curve.png" name="info" value="커브모니터" title="커브모니터">
							<p>
							커브모니터
							</div>	
							<div class="b">	
								<input type="image" src="/pc/resources/images/crt.png" name="info" value="CRT모니터" title="CRT모니터">
							<p>
							CRT모니터
							</div>	
							<div class="b">	
								<input type="image" src="/pc/resources/images/atm.png" name="info" value="ATM기기" title="ATM기기">
							<p>
							ATM기기
							</div>	
							<div class="b">	
								<input type="image" src="/pc/resources/images/air.png" name="info" value="공기청정기" title="공기청정기">
							<p>
							공기청정기
							</div>	
							<div class="c">	
								<input type="image" src="/pc/resources/images/battery.png" name="info" value="스마트폰충전" title="스마트충전">
							<p>
							스마트폰충전
							</div>	
							<div class="c">	
								<input type="image" src="/pc/resources/images/game.png" name="info" value="모바일게임" title="모바일게임">
							<p>
							모바일게임
							</div>	
							<div>
								<button type="button" onclick="fn_selectInfo()" class="btn btn-primary">확인</button>
							</div>
						</div>
					</div>
					<p>
					<div class="form-group">
						<div>pc방 소개</div>
						<textarea rows="7" cols="50" name="pcintro" class="form-control" required="required">${pc.pcintro }</textarea>
					</div>
					<div>
						<input type="hidden" name="pclati" id="pclati"> 
						<input type="hidden" name="pclongi" id="pclongi"> 
						<input type="hidden" name="pcinfo" id="pcinfo">
					</div>
				</div>
				<div align="center">
					<button id="submit" type="submit" class="btn btn-primary btn_ok">수정</button>
				</div>
			</form>
		</div>
	</div>
</div>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f32d148d5a0f1b0127e3645366eccc05&libraries=services"></script>
<script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new daum.maps.LatLng('${pc.pclati }', '${pc.pclongi }'), // 지도의 중심좌표
            level: 5 // 지도의 확대 레벨
        };

    //지도를 미리 생성
    var map = new daum.maps.Map(mapContainer, mapOption);
    //주소-좌표 변환 객체를 생성
    var geocoder = new daum.maps.services.Geocoder();
    //마커를 미리 생성
    var marker = new daum.maps.Marker({
        position: new daum.maps.LatLng('${pc.pclati }', '${pc.pclongi }'),
        map: map
    });

    function sample5_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = data.address; // 최종 주소 변수

                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("pcaddr").value = addr;
                // 주소로 상세 정보를 검색
                geocoder.addressSearch(data.address, function(results, status) {
                    // 정상적으로 검색이 완료됐으면
                    if (status === daum.maps.services.Status.OK) {

                        var result = results[0]; //첫번째 결과의 값을 활용

                        // 해당 주소에 대한 좌표를 받아서
                        var coords = new daum.maps.LatLng(result.y, result.x);
                        
                        var lati = result.y;
                        var longi = result.x;
                        document.getElementById("pclati").value = lati;
                        document.getElementById("pclongi").value = longi;
                        
                        // 지도를 보여준다.
                        mapContainer.style.display = "block";
                        map.relayout();
                        // 지도 중심을 변경한다.
                        map.setCenter(coords);
                        // 마커를 결과값으로 받은 위치로 옮긴다.
                        marker.setPosition(coords)
                    }
                });
            }
        }).open();
    }
</script>
</body>
</html>