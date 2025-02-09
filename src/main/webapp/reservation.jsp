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
<meta charset="UTF-8">
<meta name="viewport" content="width=480, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>RE:JOY - 예약하기</title>
<style>
/* 기본 스타일 */
html, body {
    height: 100%;
    margin: 0;
    padding: 0;
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
                selectTime(this.innerText, this);
            });
        });

    });
</script>
</head>
<body>

<header>
    <h1>RE:JOY</h1>
</header>

<div class="container">
    <h2>예약하기</h2>
    <form action="doReservation" method="post"> <!-- /doReservation 컨트롤러 호출 -->
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
            <button type="button" onclick="selectTime('10', this)">10</button>
            <button type="button" onclick="selectTime('11', this)">11</button>
            <button type="button" onclick="selectTime('12', this)">12</button>
            <button type="button" onclick="selectTime('13', this)">13</button>
            <button type="button" onclick="selectTime('14', this)">14</button>
            <button type="button" onclick="selectTime('15', this)">15</button>
            <button type="button" onclick="selectTime('16', this)">16</button>
            <button type="button" onclick="selectTime('17', this)">17</button>
            <button type="button" onclick="selectTime('18', this)">18</button>
            <button type="button" onclick="selectTime('19', this)">19</button>
            <button type="button" onclick="selectTime('20', this)">20</button>
            <button type="button" onclick="selectTime('21', this)">21</button>
        </div>

        <div>
            <button id="confirm-btn" type="submit" class="confirm-btn" disabled>예약하기</button>
        </div>
    </form>
</div>

</body>
</html>
