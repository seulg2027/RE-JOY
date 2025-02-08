<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=480, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>RE:JOY - 로그인</title>
<style>
/* html과 body의 전체 높이 설정 */
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
	margin: 0 auto; /* 상단 여백 없이 좌우 중앙 정렬 */
	min-height: 100vh; /* 뷰포트 높이만큼 채움 */
	border: 1px solid #ccc; /* 경계선 */
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

/* 메뉴 열릴 때 */
.nav-menu.show-menu {
	left: 450px;
}

/* 남은 영역을 채우기 위한 flex 설정 */
.container {
	margin-top: 10px;
	padding: 20px;
	background-color: white;
	border-radius: 10px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	flex: 1;
}

h2 {
	margin-bottom: 20px;
}

form {
	display: flex;
	flex-direction: column;
	align-items: center;
}

input[type="text"], input[type="password"] {
	width: 80%;
	padding: 10px;
	margin: 10px 0;
	border: 1px solid #ccc;
	border-radius: 5px;
}

.button {
	background-color: #495DDD;
	color: white;
	padding: 10px 20px;
	font-size: 16px;
	border: none;
	cursor: pointer;
	border-radius: 5px;
	margin-top: 10px;
}

.link {
	margin-top: 15px;
}

.link a {
	color: #495DDD;
	text-decoration: none;
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
				<span class="close-btn" onclick="toggleMenu()">&#10005;</span> 
					<a href="centerList.jsp">홈</a>
					<a href="reservationCheck.jsp">예약조회</a>
					<a href="dashboard.jsp">통계</a>
			</nav>
		</div>
		<h1 class="clickable"
			onclick="window.location.href='centerList.jsp';">RE:JOY</h1>
		<div>
			<a href="login.jsp" style="color: white; text-decoration: none;">로그인</a>
		</div>
	</header>

	<div class="container">
		<h2>로그인</h2>
		<form action="userLogin" method="post">
			<input type="text" name="username" placeholder="아이디" required>
			<input type="password" name="password" placeholder="비밀번호" required>
			<button class="button" type="submit">로그인</button>
		</form>
		<div class="link">
			아직 회원이 아니신가요? <a href="signup.jsp">회원가입</a>
		</div>
	</div>
</body>
</html>
