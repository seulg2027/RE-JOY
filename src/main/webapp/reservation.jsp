<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
    // 로그인 확인
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css">

<meta charset="UTF-8">
<meta name="viewport" content="width=480, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>RE:JOY - 예약하기</title>

<style>
/* 기본 스타일 */
html, body {
    font-family: 'Pretendard', sans-serif;
    height: auto;
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

.section-title {
    font-size: 18px;
    font-weight: bold;
    margin: 10px 0;
    display: flex;
    align-items: center;
    gap: 8px;
}

/* 날짜 선택 */
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

/* 시간 선택 버튼 스타일 */
.time-selector {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
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

/* 예약하기 버튼 */
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
</style>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        var confirmBtn = document.getElementById("confirm-btn");

        // ✅ 오늘 날짜 이후만 선택 가능하도록 설정
        var today = new Date();
        var yyyy = today.getFullYear();
        var mm = String(today.getMonth() + 1).padStart(2, '0');
        var dd = String(today.getDate()).padStart(2, '0');
        var minDate = `${yyyy}-${mm}-${dd}`;

        document.getElementById("date-picker").setAttribute("min", minDate);
        document.getElementById("date-picker").setAttribute("value", minDate);

        // ✅ 시간 선택 시, hidden input 업데이트 및 버튼 활성화
        function selectTime(time, btn) {
            document.getElementById("selected-time").value = time;
            document.querySelectorAll(".time-selector button").forEach(btn => btn.classList.remove("active"));
            btn.classList.add("active");
            confirmBtn.disabled = false;
        }

        // ✅ 버튼에 이벤트 리스너 추가
        document.querySelectorAll(".time-selector button").forEach(button => {
            button.addEventListener("click", function() {
                selectTime(this.value, this);
            });
        });

    });
    
    window.onload = function() {
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('success')) {
            alert("예약이 완료되었습니다.");
        }
    }
    
</script>
</head>
<body>
	<header>
		<div class="menu-container">
			<div class="menu-icon" onclick="toggleMenu()">&#9776;</div>
			<nav id="navMenu" class="nav-menu">
				<span class="close-btn" onclick="toggleMenu()">&#10005;</span> 
					<a href="center?city=서울시&district=강남구&category=골프">홈</a>
					<a href="reservationCheck">예약조회</a>
					<a href="dashboard.jsp">통계</a>
			</nav>
		</div>
		<h1 class="clickable"
			onclick="window.location.href='center?city=서울시&district=강남구&category=골프';">RE:JOY</h1>
		<div>
			<% if ((String) session.getAttribute("userId") == null) { %>
			<a href="login.jsp" style="color: white; text-decoration: none;">로그인</a>
			<% } else { %>
			<a href="userLogout" style="color: white; text-decoration: none;">로그아웃</a>
			<% } %>
		</div>
	</header>

<div class="container">
    <h2>예약하기</h2>
	<form action="doReservation" method="post" onsubmit="return showReservationAlert();">
	    <input type="hidden" name="center_id" value="${centerInfo.center_id}">
	    <input type="hidden" id="selected-time" name="reservationTime">
	
	    <!-- ✅ 센터 정보 -->
	    <div class="info-box">
	        <c:if test="${empty centerInfo}">
	            <p style="color: red;">센터 정보를 불러올 수 없습니다.</p>
	        </c:if>
	        <p>센터 이름: ${centerInfo.center_name}</p>
	        <p>지역: ${centerInfo.city} ${centerInfo.district}</p>
	        <p>결제 금액: ${centerInfo.price}원</p>
	    </div>
	
	    <!-- ✅ 날짜 선택 -->
	    <div class="section-title">날짜 선택</div>
	    <div class="date-selector">
	        <input type="date" id="date-picker" name="reservationDate" required>
	    </div>
	
	    <!-- ✅ 시간 선택 -->
	    <div class="section-title">시간 선택</div>
	    <div class="time-selector">
	        <button type="button" onclick="selectTime('10', this)" value="10">10:00</button>
	        <button type="button" onclick="selectTime('11', this)" value="11">11:00</button>
	        <button type="button" onclick="selectTime('12', this)" value="12">12:00</button>
	        <button type="button" onclick="selectTime('13', this)" value="13">13:00</button>
	        <button type="button" onclick="selectTime('14', this)" value="14">14:00</button>
	        <button type="button" onclick="selectTime('15', this)" value="15">15:00</button>
	        <button type="button" onclick="selectTime('16', this)" value="16">16:00</button>
	        <button type="button" onclick="selectTime('17', this)" value="17">17:00</button>
	        <button type="button" onclick="selectTime('18', this)" value="18">18:00</button>
	        <button type="button" onclick="selectTime('19', this)" value="19">19:00</button>
	        <button type="button" onclick="selectTime('20', this)" value="20">20:00</button>
	        <button type="button" onclick="selectTime('21', this)" value="21">21:00</button>
	    </div>
	
	    <div>
	        <button id="confirm-btn" type="submit" class="confirm-btn" disabled>예약하기</button>
	    </div>
	</form>

<script>
    // 예약하기 버튼 클릭 시 form 제출 전에 alert를 띄우는 함수
    function showReservationAlert() {
        alert('예약이 완료되었습니다!');
        // true를 반환하면 폼 제출이 계속됩니다.
        return true;
    }
</script>

</div>

</body>
</html>
