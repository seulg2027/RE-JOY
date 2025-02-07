<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=480, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>RE:JOY - 센터 목록</title>
    <style>
        /* 기존 스타일 그대로 적용 */
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
        .menu-container { position: relative; }
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
        .nav-menu.show-menu { left: 450px; }
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
        .clickable { cursor: pointer; }
    </style>
    <script>
        function toggleMenu() {
            var menu = document.getElementById("navMenu");
            menu.classList.toggle("show-menu");
        }

        // 카테고리 버튼 클릭 이벤트 처리 (필요시)
        function selectCategory(event) {
            var buttons = document.querySelectorAll(".category button");
            buttons.forEach(button => button.classList.remove("active"));
            event.target.classList.add("active");
            console.log("선택된 카테고리:", event.target.innerText);
        }

        document.addEventListener("DOMContentLoaded", function() {
            var buttons = document.querySelectorAll(".category button");
            buttons.forEach(button => {
                button.addEventListener("click", selectCategory);
            });

            // 도시 선택에 따라 구 드롭다운 옵션 변경
            var citySelect = document.getElementById("city");
            var districtSelect = document.getElementById("district");
            citySelect.addEventListener("change", function(){
                // 기존 옵션 초기화
                districtSelect.innerHTML = "";
                if(citySelect.value === "서울"){
                    var opt1 = document.createElement("option");
                    opt1.value = "강남구";
                    opt1.text = "강남구";
                    districtSelect.appendChild(opt1);
                    var opt2 = document.createElement("option");
                    opt2.value = "서초구";
                    opt2.text = "서초구";
                    districtSelect.appendChild(opt2);
                } else if(citySelect.value === "부산"){
                    var opt1 = document.createElement("option");
                    opt1.value = "사상구";
                    opt1.text = "사상구";
                    districtSelect.appendChild(opt1);
                    var opt2 = document.createElement("option");
                    opt2.value = "해운대구";
                    opt2.text = "해운대구";
                    districtSelect.appendChild(opt2);
                }
            });
            // 페이지 로드시 초기 옵션 설정
            citySelect.dispatchEvent(new Event("change"));
        });
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
        <h1 class="clickable" onclick="window.location.href='centerList.jsp';">RE:JOY</h1>
        <div>
            <% if ((String) session.getAttribute("userId") == null) { %>
                <a href="login.jsp" style="color: white; text-decoration: none;">로그인</a>
            <% } else { %>
                <a href="logout" style="color: white; text-decoration: none;">로그아웃</a>
            <% } %>
        </div>
    </header>

    <div class="container">
        <h2>지역 설정</h2>
        <!-- 컨텍스트 경로 포함한 폼 액션 -->
		<form id="searchForm" action="/RE-JOY/center" method="get">
            <div class="dropdown">
                <select id="city" name="city">
                    <option value="서울">서울</option>
                    <option value="부산">부산</option>
                </select>
                <select id="district" name="district">
                    <!-- 옵션은 JavaScript로 업데이트 됩니다 -->
                </select>
            </div>
            <input type="submit" value="검색">
        </form>

        <div class="category">
            <button class="active">골프</button>
            <button>볼링</button>
            <button>수영</button>
            <button>댄스스포츠</button>
            <button>테니스</button>
            <button>헬스</button>
            <button>배드민턴</button>
            <button>요가</button>
        </div>

        <!-- 센터 리스트 출력 영역 -->
        <div class="list-container">
            <c:forEach var="center" items="${centerList}">
                <div class="list">
                    <div style="text-align: left;">
                        <h3>${center.name}</h3>
                        <p>${center.address}</p>
                    </div>
                    <button class="reserve-btn" onclick="window.location.href='reservation.jsp?id=${center.centerId}'">
                        예약하기
                    </button>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>
