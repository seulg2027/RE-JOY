<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
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
</body>
<script type="text/javascript">
	function deptAll() {
		const xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				document.getElementById("deptDataView").innerHTML = this.responseText;
			}
		};
		xhttp.open("GET", "company?command=deptAll");
		xhttp.send();
	}
</script>
</html>