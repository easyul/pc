<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initialscale=1">
<head profile="http://www.w3.org/2005/10/profile">
<style>
caption {
	font-size: 30px;
}

.err {
	color: red;
	font-weight: bold;
}

.total img {
	width: 250px;
}

.dropdown {
	position: relative;
	display: inline-block;
	align-items: flex-end;
	bottom: 0;
 	right: 0;
	z-index: 100;
}

.dropdown-button {
	padding: 8px;
	border: none;
	width: 60px;
/* 	float: right; */
}

.dropdown-content {
	display: none;
	position: absolute;
	/* 	background-color: white; */
	min-width: 100px;
	padding: 3px;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0, 2);
	z-index: 1;
}

.dropdown-content a {
	color: white;
	padding: 5px;
	text-decoration: none;
	display: block;
	font-size: 5px;
}

.dropdown-content a:hover {
	background-color: white;
}

.dropdown:hover .dropdown-content {
	display: block;
}

.btn-secondary {
	color: black;
}

.image_container {
	width: 75px;
	height: 75px;
}

.image_container img {
	width: 100%;
	height: 100%;
	border-radius: 100px;
	object-fit: cover;
	margin-right: 15px;
	/* 	margin-right: -2px; */
}

.total {
	width: 100%;
	/* 	height: 20%; */
	display: flex;
	align-items: center;
/* 	justify-content: space-between; */
	color: white;
	padding: 15px 0;
	padding-left: 7.5%;
	background: #2c3e50;
	position: relative;
}

.welcome {
/* 	width: 40%; */
	height: 100%;
	/* 	bottom: 0; */
	/* 	vertical-align: bottom; */
/* 	display: table-cell; */
/* 	vertical-align: bottom; */
}
.logo {
	width: 300px;
	float: left;
}
.move {
	width: 67.5%;
	display: flex;
	align-items: center;
}
.btn-register {
	margin-left: 10px;
}
.dropdown-content {
	background-color: #2C3D4F;
}
.dropdown-content a{
	font-size: 15px;
}
.dropdown-position {
	margin: 10px 0;
	position: absolute;
	right: 5%;
	top: -4px;
}
</style>
</head>
<!-- pageContext.request.contextPath : 프로젝트 명 -->
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<%-- ${path }를 사용하면 패키지의 경올가 절대경로로 변경 --%>
<%-- <link rel="stylesheet" type="text/css" href="${path}/resources/bootstrap/css/bootstrap.min.css">  
<script type="text/javascript" src="${path}/resources/bootstrap/js/jquery.js"></script>
<script type="text/javascript" src="${path}/resources/bootstrap/js/bootstrap.min.js"></script>--%>
<link rel="stylesheet" type="text/css" href="${path}/resources/bootstrap/css/pc.css">
<link rel="stylesheet" type="text/css" href="${path}/resources/bootstrap/css/bootstrap(1).css">
<link rel="stylesheet" type="text/css" href="${path}/resources/bootstrap/css/bootstrap.min(1).css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css" integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc" crossorigin="anonymous">
<body>
	<nav class="total">
		<div class="logo">
			<a href="main.do"><img alt="" src="/pc/resources/images/logo.png"></a>
		</div>
			<c:if test="${sessionScope.memberSession.id == null }">
				<div class="move">
					<button class="btn btn-secondary btn-register btn-sm" onclick='location.href="loginForm.do"'>로그인</button>
					<button class="btn btn-secondary btn-register btn-sm" onclick='location.href="joinForm.do"'>회원가입</button>
				</div>
			</c:if>
		<c:if test="${sessionScope.memberSession.id != null }">
			<c:if test="${sessionScope.memberSession.id == 'admin'}">
				<div class="move">
					<button class="btn btn-secondary btn-sm" onclick='location.href="memberList.do"'>관리자 페이지</button>
				</div>
					<div class="dropdown">
						<div class="image_container">
							<img class="dropdown-button" src="/pc/resources/upload/${sessionScope.memberSession.profile}">
						</div>
						<div class="dropdown-content">
							<a href="logout.do">로그아웃</a>
						</div>
					</div>
			</c:if>
			<c:if test="${sessionScope.memberSession.id != 'admin'}">
				<div class="move">
					<div class="welcome">${sessionScope.memberSession.nick_name }님 환영합니다</div>
					<c:if test="${sessionScope.memberSession.identity == '점주'}">
						<c:if test="${sessionScope.memberSession.permitConfirm == -1}">
							<button class="btn btn-secondary btn-register btn-sm"
								onclick='location.href = "registerForm.do"'>가맹점 문의</button>
						</c:if>
						<c:if test="${sessionScope.memberSession.permitConfirm == 0}">
									<button class="btn btn-secondary btn-register btn-sm">승인대기 중..</button>
								</c:if>
						<c:if test="${sessionScope.memberSession.permitConfirm == 1}">
							<button class="btn btn-secondary btn-register btn-sm"
								onclick="location.href='mypcUpdateForm.do'">가맹점 수정</button>
						</c:if>
					</c:if>
				</div>
				<div class="dropdown-position">
					<div class="dropdown">
						<div class="image_container">
							<img class="dropdown-button"
								src="/pc/resources/upload/${sessionScope.memberSession.profile}">
						</div>
						<div class="dropdown-content">
							<a href="passChkForm.do">마이페이지</a> <a href="logout.do">로그아웃</a>
						</div>
					</div>
				</div>
			</c:if>
		</c:if>
	
	</nav>
</body>