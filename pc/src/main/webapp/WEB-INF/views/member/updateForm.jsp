<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>어데 피씹니까?</title>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" /> 
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script> 
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<style type="text/css">
/* ul {
	background-color: #d5d5d5;
	width : 150px;
	list-style-type : none;
	margin : 0;
	padding: 0;
}
li a {
	display: block;
	color: black;
	padding: 8px;
	text-align: center;
	text-decoration: none;
	font-weight: bold;
}
li.current {
	background-color: white;
}
li a:hover:not(.current) {
	background-color: #d5d5d5;
} */
/* 프로필 */
#image_container {
	width: 150px;
	height: 150px;
}

#image_container img{
	width:100%; 
	height:100%;
	border-radius: 100px;
	object-fit: cover;
}

.profile{
	display: flex;
	align-items: center;
	flex-direction: column;
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
	.btn-primary{
		margin: 0 20px;
	}
	.form_line {
		display: flex;
		justify-content: center;
	}
	.form-control {
	width: 335px;
	border: none;
	background-color: white;
	border-bottom: 1px solid #2c3e50;
	margin-bottom: 10px;
}
	h3 {
	margin-bottom: 20px;
	}
	.btn_ok {
		margin: 30px;
	}
	.navi_admin{
	float: left;
/* 	margin-top: 50px; */
	width: 200px;
	margin-left: -50px;
}
</style>
<script type="text/javascript">
function chk() {
	if (frm.nick_namechk.value == 0) {
		alert("닉네임를 확인해주세요.");
		return false;
	}
	if (frm.emailchk.value == 0) {
		alert("이메일를 확인해주세요.");
		return false;
	}
}
function pass_chk() { // 암호 확인
	if (frm.password.value != '' && frm.password2.value != '') {
		if (frm.password.value == frm.password2.value) {
			document.getElementById('same').innerHTML = '비밀번호가 일치합니다.';
			document.getElementById('same').style.color = 'blue';
		} else {
			document.getElementById('same').innerHTML = '비밀번호가 일치하지 않습니다.';
			document.getElementById('same').style.color = 'red';
			frm.password2.focus();
			frm.password2.value = "";
		}
	}
}
function chk3() { // 닉네임 중복체크
	if (!frm.nick_name.value) {
		alert("닉네임을 입력하고 중복체크 하세요.");
		frm.nick_name.focus();
		return false;
	}
	$.post('confirmNick_name2.do', "nick_name=" + frm.nick_name.value, function(data) {
		if (data == 0) {
			$('#err2').html("이미 사용중인 닉네임입니다.");
			$('#err2').css("color", "red");
			return false;
		} else {
			$('#err2').html("사용 가능한 닉네임입니다.");
			$('#err2').css("color", "blue");
			frm.nick_namechk.value = "1";
			return false;
		}
	});
}
function chk4() { // 이메일 중복체크
	if (!frm.email.value) {
		alert("이메일을 입력하고 중복체크 하세요.");
		frm.email.focus();
		return false;
	}
	$.post('confirmEmail2.do', "email=" + frm.email.value, function(data) {
		if (data == 0) {
			$('#err3').html("이미 사용중인 이메일입니다.");
			$('#err3').css("color", "red");
			return false;
		} else {
			$('#err3').html("사용 가능한 이메일입니다.");
			$('#err3').css("color", "blue");
			frm.emailchk.value = "1";
			return false;
		}
	});
}
// 프로필 미리보기
/* function setProfile(event) {
 	var reader = new FileReader();
	
	reader.onload = function(event) {
		var img = document.creatElement("img");
		img.setAttribute("src", event.target.result);
		img.setAttribute("width",200);
		img.setAttribute("height",200);
		
		$("#image_container img").remove();
		document.querySelector("div#image_container").appendChild(img);
	};
	reader.readAsDataURL(event.target.files[0]);
} */
</script>
</head>
<body>
<div class="content_center">
<div class="total_content" align="center">
<div class="navi_admin"> 
	<ul class="sidebar">
         <li><a href="updateForm.do">회원정보 수정</a></li>
         <li><a href="reserveList.do">예매내역</a></li>
         <li><a href="mybookmark.do">즐겨찾기</a></li>
            <c:if test="${member.identity == '점주' }">
            <c:if test="${pc.pcno != null }">
               <li><a href="mypcUpdateForm.do">가맹점 수정</a></li>
               <li><a href="seatForm.do?pcno=${pc.pcno}">좌석배치 수정</a></li>
               <c:if test="${f1 == null }">
               <li><a href="feeInsertForm.do?pcno=${pc.pcno}">요금 입력</a></li>
               </c:if>
               <c:if test="${f1 != null }">
               <li><a href="feeUpdateForm.do?pcno=${pc.pcno}">요금 수정</a></li>
               </c:if>
            </c:if>
            </c:if>
   </ul>
</div>
<div class="form_line">
	<form class="join_form" action="update.do" method="post" name="frm" onsubmit="return chk()"  enctype="multipart/form-data">
		<input type="hidden" name="nick_namechk" value="0"> 
		<input type="hidden" name="emailchk" value="0">
		<input type="hidden" name="mno" value="${member.mno }">
		<div class="join_total">
		<h3>회원정보 수정</h3>
			<div class="profile">
				<div id="image_container" style="border: 1px;">
					<img alt="" src="/pc/resources/upload/${member.profile}">
				</div>
				${member.profile }
				<div class="form_group">
					<input class="form-control" type="file" name="file" id="f1" onchange="setProfile(event)">
				</div>
			</div>
			<div>아이디</div>
			<div class="join_content">
				<input type="text" name="id" value="${member.id }" readonly="readonly" class="form-control">
			</div>
			<div>암호</div>
			<div class="join_content">
				<input type="password" name="password" required="required" class="form-control">
			</div>
			<div>암호확인</div>
			<div class="join_content">
				<input type="password" name="password2" required="required" onchange="pass_chk()" class="form-control">
			</div>
			<div id="same"></div>
			<div>이름</div>
			<div class="join_content">
				<input type="text" name="name" value="${member.name }" required="required" class="form-control">
			</div>
			<div>닉네임</div>
			<div class="join_content content_id">
				<input type="text" name="nick_name" value="${member.nick_name }" required="required" class="form-control">
				<input type="button" onclick="chk3()" value="중복체크" class="btn btn-primary">
			</div>
			<div id="err2"></div>
			<div>연락처</div>
			<div class="join_content">
				<input type="tel" name="phone" required="required" value="${member.phone }" pattern="010-\d{3,4}-\d{4}"
						placeholder="ex)010-1111-1111" title="전화형식 010-숫자3/4-숫자4" class="form-control">
			</div>
			<div>성별</div>
			<div>
				<input type="radio" name="gender" value="m" id="m" checked="checked"><label for="m">남자</label> 
				<input type="radio" name="gender" value="f" id="f"><label for="f">여자</label>
			</div>
			<div>생년월일</div>
			<div>
				<input type="date" name="birth" id='currentDate' required="required" value="${member.birth }">
			       <script>
			           document.getElementById('currentDate').max = new Date().toISOString().substring(0, 10);
			       </script>
			</div>
			<div>이메일</div>
			<div class="join_content content_id">
				<input type="email" name="email" value="${member.email }" required="required" class="form-control">
				<input type="button" onclick="chk4()" value="중복체크" class="btn btn-primary">
			</div>
			<div id="err3"></div>
			<div>회원식별</div>
			<div class="join_content">
				<input type="text" name="id" value="${member.identity }" readonly="readonly" class="form-control">
			</div>
			<div><input type="submit" value="수정완료" class="btn btn-primary btn_ok"></div>
		</div>
	</form>
	</div>
	</div>
	</div>
</body>
</html>