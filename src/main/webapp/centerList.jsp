<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css">

<meta charset="UTF-8">
<meta name="viewport" content="width=480, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>RE:JOY - 센터 목록</title>
<style>

html, body {
	font-family: 'Pretendard', sans-serif;
	width: 600px;
	margin: 0 auto;
	padding: 0;
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

/* 카테고리 버튼 4개씩 2줄 정렬 */
.category {
    font-family: 'Pretendard', sans-serif;  /* 🚀 폰트 적용 */
    font-weight: 500;  /* Medium (더 선명한 가독성) */
    font-size: 16px;  /* 글자 크기 */
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 10px;
	justify-content: center;
	margin-bottom: 20px;
}

.category button {
    font-family: 'Pretendard', sans-serif;  /* 🚀 폰트 적용 */
    font-size: 16px;  /* 글자 크기 */
	padding: 10px 0;
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
    font-family: 'Pretendard', sans-serif;  /* 🚀 폰트 적용 */
    font-size: 16px;  /* 글자 크기 */
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
.spot {
    color: #666; /* 색상 변경 (연한 회색) */
    font-size: 0.9em; /* 살짝 작은 글자 크기 */
}

select {
    font-family: 'Pretendard', sans-serif !important;  /* 🚀 폰트 적용 */
    font-weight: 500;  /* Medium (더 선명한 가독성) */
    font-size: 16px;  /* 글자 크기 */
    padding: 10px;
    width: 48%;
    border: 2px solid #ccc;  
    border-radius: 8px;  
    background-color: white;  
    color: #333;  
    outline: none;
    transition: all 0.3s ease-in-out;  
    cursor: pointer;
}

select:focus {
    border-color: #495DDD;  /* 포커스 시 테두리 색 변경 */
    box-shadow: 0 0 5px rgba(73, 93, 221, 0.5);  /* 은은한 그림자 효과 */
}

select option {
    font-family: 'Pretendard', sans-serif !important;  /* 🚀 폰트 적용 */
    font-weight: 400;  /* Regular */
    font-size: 16px;
    padding: 10px;
    background-color: white;
    color: #333;
}

</style>
</head>
<script>
    function toggleMenu() {
        var menu = document.getElementById("navMenu");
        menu.classList.toggle("show-menu");
    }

    document.addEventListener("DOMContentLoaded", function() {
        updateDistricts();
        updateCategories();
    });

    const districtMap = {
        "서울시": ["강남구", "서초구"],
        "부산시": ["해운대구", "사상구"]
    };

    const categoryMap = {
        "강남구": ["골프", "테니스", "헬스", "요가", "배드민턴", "댄스스포츠", "볼링", "수영"],
        "서초구": ["골프", "테니스", "헬스", "요가", "배드민턴", "댄스스포츠", "볼링", "수영"],
        "해운대구": ["골프", "테니스", "헬스", "요가", "배드민턴", "댄스스포츠", "볼링", "수영"],
        "사상구": ["골프", "테니스", "헬스", "요가", "배드민턴", "댄스스포츠", "볼링", "수영"]
    };

    function updateDistricts() {
        const city = document.getElementById("city").value;
        const districtSelect = document.getElementById("district");
        const previousDistrict = districtSelect.value;
        districtSelect.innerHTML = "";

        if (districtMap[city]) {
            districtMap[city].forEach(district => {
                const option = document.createElement("option");
                option.value = district;
                option.text = district;
                if (district === previousDistrict) {
                    option.selected = true;
                }
                districtSelect.appendChild(option);
            });
        }

        updateCategories();
    }

    function updateCategories() {
        const district = document.getElementById("district").value;
        const selectedCategory = document.getElementById("selectedCategory").value;

        const buttons = document.querySelectorAll(".category-button");
        buttons.forEach(button => {
            const category = button.getAttribute("data-category");
            if (categoryMap[district] && categoryMap[district].includes(category)) {
                button.disabled = false;
                button.style.opacity = "1";
            } else {
                button.disabled = true;
                button.style.opacity = "0.5";
            }

            if (category === selectedCategory) {
                button.classList.add("active");
            } else {
                button.classList.remove("active");
            }

            button.onclick = function() {
                if (!button.disabled) {
                    document.getElementById("selectedCategory").value = category;
                    buttons.forEach(btn => btn.classList.remove("active"));
                    button.classList.add("active");
                }
            };
        });
    }
</script>

<body>
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
		<h1 class="clickable" onclick="window.location.href='center?city=서울시&district=강남구&category=골프';">RE:JOY</h1>
		<div>
			<% if ((String) session.getAttribute("userId") == null) { %>
			<a href="login.jsp" style="color: white; text-decoration: none;">로그인</a>
			<% } else { %>
			<a href="userLogout" style="color: white; text-decoration: none;">로그아웃</a>
			<% } %>
		</div>
	</header>

	<div class="container">
		<h2 style="text-align: left; font-size:22px; margin-left: 20px; margin-bottom: 35px;">예약할 센터 선택하기</h2>
		<form action="center" method="get">
		    <div class="dropdown">
		        <select name="city" id="city" onchange="updateDistricts()">
		            <option value="서울시" ${selectedCity == '서울시' ? 'selected' : ''}>서울시</option>
		            <option value="부산시" ${selectedCity == '부산시' ? 'selected' : ''}>부산시</option>
		        </select>
		
		        <select name="district" id="district" onchange="updateCategories()">
		            <option value="강남구" ${selectedDistrict == '강남구' ? 'selected' : ''}>강남구</option>
		            <option value="서초구" ${selectedDistrict == '서초구' ? 'selected' : ''}>서초구</option>
		            <option value="해운대구" ${selectedDistrict == '해운대구' ? 'selected' : ''}>해운대구</option>
		            <option value="사상구" ${selectedDistrict == '사상구' ? 'selected' : ''}>사상구</option>
		        </select>
		    </div>
		
			<div class="category" id="category-buttons">
			    <button class="category-button" data-category="골프">골프</button>
			    <button class="category-button" data-category="테니스">테니스</button>
			    <button class="category-button" data-category="헬스">헬스</button>
			    <button class="category-button" data-category="요가">요가</button>
			    <button class="category-button" data-category="배드민턴">배드민턴</button>
			    <button class="category-button" data-category="댄스스포츠">댄스스포츠</button>
			    <button class="category-button" data-category="볼링">볼링</button>
			    <button class="category-button" data-category="수영">수영</button>
			</div>
			<input type="hidden" id="selectedCategory" name="category" value="${selectedCategory}">

		</form>

		<div class="list-container">
		    <c:choose>
		        <c:when test="${empty centerList}">
		            <p style="text-align:center; font-size:18px; color: #666; font-weight: bold;">
		                <strong>존재하지 않는 센터입니다.</strong>
		            </p>		        
		        </c:when>
		        <c:otherwise>
		            <c:forEach var="center" items="${centerList}">
		                <div class="list">
		                    <div style="text-align: left;">
		                        <h3>${center.center_name} <span class="spot">${center.spot}</span></h3>
		                        <p>${center.center_address}</p> ${center.phone}
		                    </div>
		                    <button class="reserve-btn"
		                        onclick="window.location.href='reservation.jsp?id=${center.center_id}'">
		                        예약하기
		                    </button>
		                </div>
		            </c:forEach>
		        </c:otherwise>
		    </c:choose>
		</div>
	</div>
</body>
</html>
