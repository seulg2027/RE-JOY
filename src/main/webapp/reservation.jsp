<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=480, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>RE:JOY - 예약하기</title>
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

/* 메뉴 열릴 때 */
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

.timeslot-container {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 10px;
	margin-top: 20px;
}

.timeslot-btn {
	padding: 10px;
	background-color: #e0e0e0;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.timeslot-btn.disabled {
	background-color: #cccccc;
	cursor: not-allowed;
}

.time-selector button.disabled {
	background-color: #ccc;
	pointer-events: none;
}
</style>
<script>
		function toggleMenu() {
    		var menu = document.getElementById("navMenu");
    		menu.classList.toggle("show-menu");
		}

        document.addEventListener("DOMContentLoaded", function() {
            var timeButtons = document.querySelectorAll(".time-selector button");
            var selectedDate = "";
            var selectedTime = "";

            // ✅ 오늘 날짜 이후만 선택 가능하도록 설정
            var today = new Date();
            var yyyy = today.getFullYear();
            var mm = String(today.getMonth() + 1).padStart(2, '0');
            var dd = String(today.getDate()).padStart(2, '0');
            var minDate = `${yyyy}-${mm}-${dd}`;

            var datePicker = document.getElementById("date-picker");
            datePicker.setAttribute("min", minDate);
            datePicker.setAttribute("value", minDate); // 기본값을 오늘 날짜로 설정
			
            function selectTime(time) {
                
            	const selectedTimeInput = document.getElementById("selected-time");
                
                selectedTimeInput.value = time;

                const buttons = document.querySelectorAll(".time-selector button");
                buttons.forEach(btn => btn.classList.remove("active"));

                event.target.classList.add("active");
                document.getElementById("confirm-btn").disabled = false;
            }
            
            // ✅ 날짜 선택
            datePicker.addEventListener("change", function() {
                selectedDate = this.value;
                console.log("선택된 날짜:", selectedDate);
            });

            // ✅ 시간 선택
            timeButtons.forEach(button => {
                button.addEventListener("click", function() {
                    timeButtons.forEach(btn => btn.classList.remove("active"));
                    this.classList.add("active");
                    selectedTime = this.innerText;
                    console.log("선택된 시간:", selectedTime);
                });
            });

            // ✅ 예약 버튼 클릭 시 확인 메시지
            document.getElementById("confirm-btn").addEventListener("click", function() {
                if (selectedDate && selectedTime) {
                    alert(`예약 완료: ${selectedDate}일 ${selectedTime}`);
                } else {
                    alert("날짜와 시간을 선택해주세요.");
                }
            });
        });
        
        // ✅ 시간 선택
        <%--
        function selectTime(time) {
            document.getElementById("selected-time").value = time; // 시간 값을 hidden input에 설정
            const buttons = document.querySelectorAll(".time-selector button");
            buttons.forEach(btn => btn.classList.remove("active"));
            event.target.classList.add("active");
            document.getElementById("confirm-btn").disabled = false; // 예약 버튼 활성화
        }
        --%>
        function selectTime(time) {
            
        	const selectedTimeInput = document.getElementById("selected-time");
            
            selectedTimeInput.value = time;

            const buttons = document.querySelectorAll(".time-selector button");
            buttons.forEach(btn => btn.classList.remove("active"));

            event.target.classList.add("active");
            document.getElementById("confirm-btn").disabled = false;
        }


    </script>
</head>
<body>

	<header>
		<div class="menu-container">
			<div class="menu-icon" onclick="toggleMenu()">&#9776;</div>
			<nav id="navMenu" class="nav-menu">
				<span class="close-btn" onclick="toggleMenu()">&#10005;</span> <a
					href="centerList.jsp">홈</a> <a href="reservationCheck">예약조회</a> <a
					href="dashboard.jsp">통계</a>
			</nav>
		</div>
		<h1 class="clickable" onclick="window.location.href='centerList.jsp';">RE:JOY</h1>
		<div>
			<%
			if ((String) session.getAttribute("userId") == null) {
			%>
			<a href="login.jsp" style="color: white; text-decoration: none;">로그인</a>
			<%
			} else {
			%>
			<a href="userLogout" style="color: white; text-decoration: none;">로그아웃</a>
			<%
			}
			%>
		</div>
	</header>
	<div class="container">
		<h2>예약 하기</h2>
		<form action="reservation" method="post">
			<input type="hidden" name="center_id" value="${centerInfo.center_id}">
    		<input type="hidden" id="selected-time" name="reservationTime">
			<%
			String centerIdStr = request.getParameter("id");
			System.out.println("center_id: " + centerIdStr); // 로그 확인
			int centerId = Integer.parseInt(centerIdStr);
			%>
			<!-- ✅ 가게 정보 -->
			<div class="info-box">
    <c:if test="${empty centerInfo}">
        <p style="color: red;">센터 정보를 불러올 수 없습니다.</p>
    </c:if>
    <p>디버깅: ${centerInfo}</p>
				<p>센터 이름: ${requestScope.centerInfo.center_name}</p>
				<p>지역: ${requestScope.centerInfo.city} ${centerInfo.district}</p>
				<p>결제 금액: ${requestScope.centerInfo.price}원</p>
			</div>
			<!-- ✅ 날짜 선택 (캘린더) -->
			<div class="section-title">
				<img src="https://cdn-icons-png.flaticon.com/128/3176/3176367.png"
					alt="달력 아이콘"> 날짜 선택
			</div>
			<div class="date-selector">
				<input type="date" id="date" name="reservationDate" required>
			</div>
			
			<!-- ✅ 시간 선택 -->
			<div class="section-title">
				<img src="https://cdn-icons-png.flaticon.com/128/3064/3064197.png"
					alt="시계 아이콘"> 시간 선택
			</div>
			
			 <div class="time-selector">
				<button type="button" onclick="selectTime(10)" name="time"
					value="10">10:00</button>
				<button type="button" onclick="selectTime(11)" name="time"
					value="11">11:00</button>
				<button type="button" onclick="selectTime(12)" name="time"
					value="12">12:00</button>
				<button type="button" onclick="selectTime(13)" name="time"
					value="13">13:00</button>
				<button type="button" onclick="selectTime(14)" name="time"
					value="14">14:00</button>
				<button type="button" onclick="selectTime(15)" name="time"
					value="15">15:00</button>
				<button type="button" onclick="selectTime(16)" name="time"
					value="16">16:00</button>
				<button type="button" onclick="selectTime(17)" name="time"
					value="17">17:00</button>
				<button type="button" onclick="selectTime(18)" name="time"
					value="18">18:00</button>
				<button type="button" onclick="selectTime(19)" name="time"
					value="19">19:00</button>
				<button type="button" onclick="selectTime(20)" name="time"
					value="20">20:00</button>
				<button type="button" onclick="selectTime(21)" name="time"
					value="21">21:00</button>
			</div> 
			
			
			
			<%-- <div class="time-selector">
				<c:forEach var="timeSlot" items="${timeSlots}">
					<button type="button"
						class="${timeSlot.reserved ? 'disabled' : ''}"
						onclick="selectTime(this, '${timeSlot.time}')">
						${timeSlot.time}:00 ${timeSlot.reserved ? '예약정원 1/1' : ''}</button>
				</c:forEach>
			</div>  --%>
			
		
			
			<div>
				<button id="confirm-btn" type="submit" class="confirm-btn" disabled>예약하기</button>
			</div>
		</form>
	</div>

</body>
</html>
