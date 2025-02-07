<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=480, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>RE:JOY - 예약조회</title>
<style>
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
	padding: 20px;
	flex: 1;
}

.info-box {
	background: white;
	padding: 15px;
	border-radius: 10px;
	box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
	margin-bottom: 15px;
	text-align: left;
}

.info-box h2 {
	margin: 0;
	font-size: 18px;
	font-weight: bold;
}

.info-box p {
	margin: 5px 0;
	color: #333;
}

.section-title {
	font-size: 18px;
	font-weight: bold;
	margin: 10px 0;
	display: flex;
	align-items: center;
	gap: 8px;
}

.section-title img {
	width: 20px;
	height: 20px;
}

.date-selector {
	display: flex;
	justify-content: center;
	background: white;
	padding: 10px;
	border-radius: 10px;
	box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
}

.date-selector input {
	font-size: 16px;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
	width: 100%;
	max-width: 200px;
}

.time-selector {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 10px;
	background: white;
	padding: 15px;
	border-radius: 10px;
	box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
}

.time-selector button {
	padding: 10px;
	font-size: 16px;
	border: none;
	border-radius: 5px;
	background-color: #e0e0e0;
	cursor: pointer;
}

.time-selector button.active {
	background-color: #3b4db4;
	color: white;
}

.confirm-btn {
	margin-top: 20px;
	padding: 15px;
	width: 100%;
	background-color: #495DDD;
	color: white;
	border: none;
	border-radius: 5px;
	font-size: 16px;
	cursor: pointer;
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
		<h2>예약 조회</h2>

		<!-- 예약 내역 출력 영역 -->
		<div id="reservation-list">
			<!-- 예제 예약 내역 -->
			<div class="info-box">
				<h2>
					<strong>클럽골프존</strong> / 서울 마포구
				</h2>
				<p>
					<strong>예약 날짜:</strong> 2025-02-10
				</p>
				<p>
					<strong>예약 시간:</strong> 14:00
				</p>
				<p>
					<strong>결제 금액:</strong> 50,000원
				</p>
			</div>

			<!-- 예약이 없는 경우 -->
			<div class="no-reservation">예약 내역이 없습니다.</div>
		</div>
	</div>

</body>
</html>