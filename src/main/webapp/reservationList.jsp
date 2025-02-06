<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=480, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>RE:JOY - 예약하기</title>
<style>
/* 기본 스타일 유지 */
html, body {
	width: 600px;
	margin: 0 auto;
	padding: 0;
	font-family: Arial, sans-serif;
	background-color: #f3f4f6;
	text-align: center;
	min-height: 100vh;
	height: auto;
	border: 1px solid #ccc;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	overflow: auto;
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
	left: 450px;
}

.container {
	margin-top: 30px;
	padding: 10px;
	flex: 1;
}

.dropdown {
	display: flex;
	gap: 10px;
	justify-content: center;
	margin-bottom: 15px;
}

select {
	padding: 10px;
	font-size: 16px;
	width: 48%;
}

/* 카테고리 버튼 4개씩 2줄 정렬 */
.category {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 10px;
	justify-content: center;
	margin-bottom: 20px;
}

.category button {
	padding: 10px 0;
	font-size: 14px;
	border: none;
	border-radius: 5px;
	background-color: #e0e0e0;
	cursor: pointer;
	width: 100%;
	text-align: center;
	transition: background-color 0.3s ease;
}

.category button.active {
	background-color: #3b4db4;
	color: white;
}

.list-container {
	flex: 1;
	display: flex;
	flex-direction: column;
	gap: 10px;
	padding-bottom: 20px;
}

.list {
	background: white;
	padding: 15px;
	margin-bottom: 10px;
	border-radius: 10px;
	box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.list h3 {
	margin: 0;
	font-size: 18px;
	font-weight: bold;
	text-align: left;
}

.list p {
	margin: 5px 0;
	color: #666;
	text-align: left;
}

.list .reserve-btn {
	padding: 10px 20px;
	background-color: #3b4db4;
	color: white;
	border: none;
	border-radius: 5px;
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

        // ✅ 카테고리 버튼 클릭 이벤트 추가
        function selectCategory(event) {
            var buttons = document.querySelectorAll(".category button");
            
            // 기존 선택된 active 클래스 제거
            buttons.forEach(button => button.classList.remove("active"));

            // 클릭된 버튼에 active 클래스 추가
            event.target.classList.add("active");

            // 선택된 카테고리 확인 (서버 요청 가능)
            console.log("선택된 카테고리:", event.target.innerText);
        }

        // 페이지 로드 후 이벤트 리스너 추가
        document.addEventListener("DOMContentLoaded", function() {
            var buttons = document.querySelectorAll(".category button");
            buttons.forEach(button => {
                button.addEventListener("click", selectCategory);
            });
        });
    </script>
</head>
<body>

	<header>
		<div class="menu-container">
			<div class="menu-icon" onclick="toggleMenu()">&#9776;</div>
			<nav id="navMenu" class="nav-menu">
				<span class="close-btn" onclick="toggleMenu()">&#10005;</span> <a
					href="index.jsp">홈</a> <a href="hobbyInfo.jsp">취미 정보</a> <a
					href="reserve.jsp">예약하기</a> <a href="reservationCheck.jsp">예약
					조회</a> <a href="popularHobbies.jsp">인기 취미 생활</a>
			</nav>
		</div>
		<h1 class="clickable"
			onclick="window.location.href='loginAction.jsp';">RE:JOY</h1>
		<div>
			<a href="login.jsp" style="color: white; text-decoration: none;">로그인</a>
		</div>
	</header>

	<div class="container">
		<h2>지역 설정</h2>
		<div class="dropdown">
			<select id="city">
				<option>서울시</option>
				<option>부산시</option>
				<option>대구시</option>
			</select> <select id="district">
				<option>마포구</option>
				<option>강남구</option>
				<option>서초구</option>
			</select>
		</div>

		<div class="category">
			<button class="active">골프</button>
			<button>수영</button>
			<button>GX</button>
			<button>필라테스</button>
			<button>테니스</button>
			<button>서예</button>
			<button>요가</button>
			<button>기타</button>
		</div>
	</div>

</body>
</html>
