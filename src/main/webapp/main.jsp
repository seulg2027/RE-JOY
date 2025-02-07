<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=480, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>RE:JOY</title>
<style>
/* html과 body의 높이를 100%로 설정 */
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
}

body {
	font-family: Arial, sans-serif;
	background-color: #f3f4f6;
	text-align: center;
	/* 가운데 정렬: 좌우는 auto, 위 여백은 0 */
	width: 600px;
	margin: 0 auto;
	/* 화면 전체 높이를 채우도록 설정 */
	min-height: 100vh;
	border: 1px solid #ccc; /* 경계선 추가 */
	border-radius: 10px; /* 둥근 모서리 */
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
	display: flex;
	flex-direction: column;
}

header {
	background-color: #495DDD;
	color: white;
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 1rem;
	position: relative;
}

.menu-container {
	position: relative;
}

.menu-icon {
	cursor: pointer;
	font-size: 24px;
	padding: 10px;
	z-index: 1000;
}

.nav-menu {
	position: fixed;
	top: 0;
	left: -250px;
	width: 250px;
	height: 100%;
	background-color: #495DDD;
	padding-top: 60px;
	transition: left 0.3s ease-in-out;
	box-shadow: 2px 0 5px rgba(0, 0, 0, 0.2);
	z-index: 999;
}

/* 닫기 버튼 스타일 */
.close-btn {
	position: absolute;
	top: 10px;
	right: 10px;
	color: white;
	font-size: 24px;
	cursor: pointer;
	user-select: none;
}

.nav-menu a {
	display: block;
	color: white;
	padding: 15px;
	text-decoration: none;
	font-size: 16px;
	text-align: left;
}

.nav-menu a:hover {
	background-color: #637AFF;
	border-radius: 5px;
}

/* 메뉴 열릴 때 위치 조정 (원하는 위치로 수정 가능) */
.nav-menu.show-menu {
	left: 450px;
}

.container {
	margin-top: 50px;
	padding: 0 10px;
	flex: 1; /* container가 남은 공간을 채우도록 설정 */
}

.title {
	font-size: 22px;
	font-weight: bold;
}

.subtitle {
	font-size: 18px;
	color: #555;
}

.button-grid {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	gap: 10px;
	margin-top: 20px;
	max-width: 350px;
	margin-left: auto;
	margin-right: auto;
}

.button {
	background-color: #495DDD;
	color: white;
	padding: 15px;
	font-size: 14px;
	border: none;
	cursor: pointer;
	border-radius: 5px;
	width: 100%;
}

.clickable {
	cursor: pointer;
}
</style>
<script>
    function toggleMenu() {
      var menu = document.getElementById("navMenu");
      menu.classList.toggle("show-menu");
    }
  </script>
</head>
<body>
	<header>
		<div class="menu-container">
			<div class="menu-icon" onclick="toggleMenu()">&#9776;</div>
			<nav id="navMenu" class="nav-menu">
				<!-- 닫기 버튼 추가 -->
				<span class="close-btn" onclick="toggleMenu()">&#10005;</span> <a
					href="main.jsp">홈</a> <a href="reservationList.jsp">취미 정보</a> <a
					href="reservation.jsp">예약하기</a> <a href="dashboard.jsp">예약
					조회</a> <a href="popularHobbies.jsp">인기 취미 생활</a>
			</nav>
		</div>
		<h1 class="clickable"
			onclick="window.location.href='main.jsp';">RE:JOY</h1>
		<div>
		<% 
			if ((String) session.getAttribute("userId") == null) {
		%>
			<a href="login.jsp" style="color: white; text-decoration: none;">로그인</a>
		<%
			} else {
		%>
			<a href="logout" style="color: white; text-decoration: none;">로그아웃</a>
		<%
			}
		%>
		</div>
	</header>
	<div class="container">
		<p class="title">RE : JOY</p>
		<p class="subtitle">취미 생활 통합 예약 시스템</p>
		<div class="button-grid">
			<button class="button" onclick="location.href='reservationList.jsp'">취미
				정보</button>
			<button class="button" onclick="location.href='reservation.jsp'">예약하기</button>
			<button class="button" onclick="location.href='reservationCheck.jsp'">예약
				조회</button>
			<button class="button" onclick="location.href='dashboard.jsp'">인기
				취미 생활</button>
		</div>
	</div>
</body>
</html>
