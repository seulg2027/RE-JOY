<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css">

<meta charset="UTF-8">
<meta name="viewport" content="width=480, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>RE:JOY - 회원가입</title>

<style>
/* ✅ 기본 스타일 */
html, body {
    font-family: 'Pretendard', sans-serif;
    height: 100%;
    margin: 0;
    padding: 0;
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

/* ✅ 헤더 */
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

/* ✅ 회원가입 컨테이너 */
.container {
    margin-top: 10px;
    padding: 20px;
    background-color: white;
    border-radius: 10px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    flex: 1;
}

h2 {
    text-align: left;
    font-size: 22px;
    margin-left: 20px;
    margin-bottom: 55px;
}

/* ✅ 폼 스타일 */
form {
    display: flex;
    flex-direction: column;
    align-items: center;
}

/* ✅ 입력 필드 스타일 */
.form-group {
    width: 80%;
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    margin-bottom: 15px;
}

/* ✅ 라벨 스타일 */
.form-group label {
    font-size: 15px;
    font-weight: bold;
    color: #333;
    margin-bottom: 5px;
}

/* ✅ 입력 필드 - 밑줄 스타일 */
input[type="text"], input[type="password"], input[type="number"] {
    width: 100%;
    padding: 8px 0;
    border: none;
    border-bottom: 2px solid #ccc;
    outline: none;
    font-size: 16px;
    background-color: transparent;
}

/* ✅ 포커스 시 강조 */
input[type="text"]:focus, input[type="password"]:focus, input[type="number"]:focus {
    border-bottom: 2px solid #495DDD;
}

/* ✅ 성별 선택 (한 줄 정렬) */
.gender-options {
    width: 80%;
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    margin-bottom: 15px;
}

.radio-group {
    display: flex;
    gap: 50px;
}

.radio-group label {
    font-weight: normal;
}

/* ✅ 버튼 스타일 */
.button {
    width: 80%;
    background-color: #495DDD;
    color: white;
    padding: 12px;
    font-size: 16px;
    font-weight: bold;
    border: none;
    cursor: pointer;
    border-radius: 5px;
    margin-top: 15px;
}

/* ✅ 링크 스타일 */
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

    window.onload = function() {
        var message = "<%= request.getAttribute("message") %>";
        var redirect = "<%= request.getAttribute("redirect") %>";

        if (message !== "null") {
            alert(message);
            if (redirect !== "null") {
                window.location.href = redirect;
            }
        }
    }
</script>
</head>
<body>
<<<<<<< Updated upstream
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
        <h1 class="clickable" onclick="window.location.href='center?city=서울시&district=강남구&category=골프';">RE:JOY</h1>
        <div>
            <a href="login.jsp" style="color: white; text-decoration: none;">로그인</a>
        </div>
    </header>
=======
	<header>
		<div class="menu-container">
			<div class="menu-icon" onclick="toggleMenu()">&#9776;</div>
			<nav id="navMenu" class="nav-menu">
				<span class="close-btn" onclick="toggleMenu()">&#10005;</span> 
					<a href="centerList.jsp">홈</a>
					<a href="reservationCheck">예약조회</a>
					<a href="dashboard.jsp">통계</a>
			</nav>
		</div>
		<h1 class="clickable"
			onclick="window.location.href='centerList.jsp';">RE:JOY</h1>
		<div>
			<a href="login.jsp" style="color: white; text-decoration: none;">로그인</a>
		</div>
	</header>
>>>>>>> Stashed changes

    <div class="container">
        <h2>회원 가입</h2>
        <form action="userSignup" method="post">
            <div class="form-group">
                <label for="name">이름</label>
                <input type="text" id="name" name="name" required>
            </div>

            <div class="form-group">
                <label for="age">나이</label>
                <input type="number" id="age" name="age" required>
            </div>
			<br>
            <div class="gender-options">
                <label>성별</label>
                <br>
                <div class="radio-group">
                    <label><input type="radio" name="gender" value="M" required> 남성</label>
                    <label><input type="radio" name="gender" value="F" required> 여성</label>
                </div>
             
            <br>
            </div>

            <div class="form-group">
                <label for="username">아이디</label>
                <input type="text" id="username" name="username" required>
            </div>

            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" required>
            </div>

            <div class="form-group">
                <label for="passwordConfirm">비밀번호 확인</label>
                <input type="password" id="passwordConfirm" name="passwordConfirm" required>
            </div>

            <button class="button" type="submit">회원가입</button>
        </form>

        <div class="link">
            이미 계정이 있으신가요? <a href="login.jsp">로그인</a>
        </div>
    </div>
</body>
</html>
