<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=480, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>에러 발생</title>
<style>
/* 기본 페이지 스타일 */
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
}

body {
	font-family: Arial, sans-serif;
	background-color: #f3f4f6;
	text-align: center;
	width: 600px;
	margin: 0 auto;
	min-height: 100vh;
	border: 1px solid #ccc;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
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

.nav-menu.show-menu {
	left: 0;
}

/* 컨테이너 스타일 */
.container {
	margin-top: 10px;
	padding: 20px;
	background-color: white;
	border-radius: 10px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	flex: 1;
}

/* 에러 박스 스타일 */
.error-box {
	padding: 20px;
	border-radius: 10px;
	background-color: white;
	box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
}

.error-box h1 {
	font-size: 24px;
	color: #dc3545;
	margin-bottom: 10px;
}

.error-box p {
	font-size: 16px;
	color: #333;
}

/* 버튼 스타일 */
.error-btn {
	display: inline-block;
	margin-top: 20px;
	padding: 10px 20px;
	font-size: 16px;
	color: white;
	background-color: #495DDD;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	text-decoration: none;
}

.error-btn:hover {
	background-color: #3742d2;
}
</style>
</head>
<body>

	<header>
		<div class="menu-container">
			<div class="menu-icon" onclick="toggleMenu()">&#9776;</div>
			<nav id="navMenu" class="nav-menu">
				<span class="close-btn" onclick="toggleMenu()">&#10005;</span> <a
					href="main.jsp">홈</a> <a href="reservationList.jsp">취미 정보</a> <a
					href="reservation.jsp">예약하기</a> <a href="dashboard.jsp">예약
					조회</a> <a href="popularHobbies.jsp">인기 취미 생활</a>
			</nav>
		</div>
		<h1>RE:JOY</h1>
		<div>
			<a href="login.jsp" style="color: white; text-decoration: none;">로그인</a>
		</div>
	</header>

	<div class="container">
		<div class="error-box">
			<h1>⚠ 에러 발생</h1>
			<p>죄송합니다. 요청을 처리하는 중 오류가 발생했습니다.</p>
			<p>잠시 후 다시 시도해 주세요.</p>

			<a href="main.jsp" class="error-btn">메인 페이지로 이동</a>
		</div>
	</div>

	<script>
        function toggleMenu() {
            var menu = document.getElementById("navMenu");
            menu.classList.toggle("show-menu");
        }
    </script>

</body>
</html>
