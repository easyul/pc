<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>어데 피씹니까?</title>
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
	}
	.btn-primary{
		margin: 0 5px;
	}
	.btn_ok {
		margin: 30px;
	}
	.form-control {
		width: 335px;
	}
	#preview {
		margin-left: 70px;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
function chk() { // 중복체크를 하지 않으면 넘어가지 않도록 설정
	if (frm.idchk.value == 0) {
		alert("아이디를 확인해주세요.");
		return false;
	}
	if (frm.nick_namechk.value == 0) {
		alert("닉네임를 확인해주세요.");
		return false;
	}
	if (frm.emailchk.value == 0) {
		alert("이메일를 확인해주세요.");
		return false;
	}
	if (!frm.file.value) {
		alert("사진을 넣어주세요.");
		return false;
	}
} 
</script>
<script type="text/javascript">
function chk2() { // 아이디 중복체크
	if (!frm.id.value) {
		alert("아이디를 입력하고 중복체크 하세요.");
		frm.id.focus();
		return false;
	}
	$.post('confirmId.do', "id=" + frm.id.value,
			function(data) { //msg
				if (data == 0) {
					$('#err').html("이미 사용중인 아이디입니다.");
					$('#err').css("color", "red");
					return false;
				} else {
					$('#err').html("사용 가능한 아이디입니다.");
					$('#err').css("color", "blue");
					frm.idchk.value = "1";
					return false;
				}
			});
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
</script>
<script type="text/javascript">
function chk3() { // 닉네임 중복체크
	if (!frm.nick_name.value) {
		alert("닉네임을 입력하고 중복체크 하세요.");
		frm.nick_name.focus();
		return false;
	}
	$.post('confirmNick_name.do', "nick_name=" + frm.nick_name.value, function(data) {
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
</script>
<script type="text/javascript">
function chk4() { // 이메일 중복체크
	if (!frm.email.value) {
		alert("이메일을 입력하고 중복체크 하세요.");
		frm.email.focus();
		return false;
	}
	$.post('confirmEmail.do', "email=" + frm.email.value, function(data) {
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

//	프로필 이미지 미리보기
var sel_flie;
var img;
$(function() {
	img = $('#preview').attr('src');
	$('#chooseFile').on('change', handleImgFileSelect);
	$('#cancel').click(function() {
		$('#preview').attr('src', img);
	});
});
function handleImgFileSelect(e) {
	var files = e.target.files;
	var filesArr = Array.prototype.slice.call(files);
	filesArr.forEach(function(f) {
		if(!f.type.match('image.*')) {
			alert('이미지 파일만 등록 가능합니다');
			return;	
		}
		sel_file = f;
		var reader = new FileReader();
		reader.onload = function(e) {
			$('#preview').attr("src", e.target.result);
			}
		reader.readAsDataURL(f);
	});
}

</script>
</head>
<body>
<div class="content_center">
	<div class="total_content">
	<form class="join_form" action="join.do" method="post" name="frm" onsubmit="return chk()" enctype="multipart/form-data">
		<input type="hidden" name="idchk" value="0"> 
		<input type="hidden" name="nick_namechk" value="0"> 
		<input type="hidden" name="emailchk" value="0">
		<div class="join_total">
		<div class="title_size">회원가입</div>
			<div style="display:block;">
			<div class="form-group">
				<label for="chooseFile">
					<img alt="" src="${path }/resources/images/image.png" id="preview"
						style="border-radius:50%; border: 1px solid black;" width="200px;" height="200px;">
				</label>
				<p>
				<p>
				<input type="file" name="file" class="form-control" style="width:340px;" id="chooseFile">
				<p>
			</div>
			</div>
			<div class="join_content content_id">
				<input type="text" name="id" required="required" autofocus="autofocus" placeholder="ID" class="form-control">
				<input class="btn btn-primary" type="button" onclick="chk2()" value="중복체크">
			</div>
			<div id="err" class="err_form"></div>
			<div class="join_content">
				<input type="password" name="password" required="required" placeholder="암호" class="form-control">
			</div>
			<div class="join_content">
				<input type="password" name="password2" required="required" onchange="pass_chk()" placeholder="암호확인" class="form-control">
			</div>
			<div id="same" class="err_form"></div>
			<div class="join_content">
				<input type="text" name="name" required="required" placeholder="이름" class="form-control">
			</div>
			<p>
			<div class="join_content content_id">
				<input type="text" name="nick_name" required="required" placeholder="닉네임" class="form-control">
				<input class="btn btn-primary" type="button" onclick="chk3()" value="중복체크">
			</div>
			<div id="err2" class="err_form"></div>
			<div class="join_content">
				<input type="tel" name="phone" required="required" pattern="010-\d{3,4}-\d{4}"
						placeholder="ex)010-1111-1111" title="전화형식 010-숫자3/4-숫자4" class="form-control">
			</div>
			<div>성별</div>
				<div class="form-check">
					<input type="radio" name="gender" value="m" id="m" checked="checked" class="form-check-input"><label for="m" class="form-check-label">남자</label> 
				</div>
				<div class="form-check">
					<input type="radio" name="gender" value="f" id="f" class="form-check-input"><label for="f" class="form-check-label">여자</label>
				</div>
			<div>생년월일</div>
			<div>
				<input type="date" name="birth" id='currentDate' required="required">
			       <script>
			           document.getElementById('currentDate').max = new Date().toISOString().substring(0, 10);
			       </script>
			</div>
			<p>
			<div class="join_content content_id">
				<input type="email" name="email" required="required" placeholder="이메일" class="form-control">
				<input type="button" onclick="chk4()" value="중복체크" class="btn btn-primary">
			</div>
			<div id="err3" class="err_form"></div>
			<div style="display:inline">
			회원식별	
				<select name="identity">
					<option>일반회원</option>
					<option>점주</option>
				</select>
			</div>
			<div><input type="submit" value="회원가입" class="btn btn-primary btn_ok"></div>
		</div>
	</form>
	</div>
	</div>
</body>
</html>