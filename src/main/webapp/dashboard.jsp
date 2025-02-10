<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css">

<meta charset="UTF-8">
<meta name="viewport" content="width=480, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>RE:JOY - 인기 취미 목록</title>
<style>
html, body {
	font-family: 'Pretendard', sans-serif;
	height: auto%;
	margin: 0;
	padding: 0;
	
}

body {
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
	left: 0;
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
					<a href="center?city=서울시&district=강남구&category=골프">홈</a>
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
		<h2 style ="text-align : left; margin-left : 30px">  인기 취미생활</h2>

		<!-- 대시보드 출력 영역 -->
		
		<div class="dashboard">
			
				<p>
					<iframe class="info-box" src="http://localhost:5601/app/dashboards#/view/477e9060-e478-11ef-a84c-0fe63e4fd213?embed=true&_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:now-15m,to:now))&_a=(description:'',filters:!(),fullScreenMode:!f,options:(hidePanelTitles:!f,syncColors:!f,useMargins:!t),panels:!((embeddableConfig:(enhancements:(),hidePanelTitles:!f,savedVis:(data:(aggs:!(),searchSource:(filter:!(),query:(language:kuery,query:''))),description:'',id:'',params:(fontSize:12,markdown:'%20%EC%B7%A8%EB%AF%B8%20%EC%B9%B4%ED%85%8C%EA%B3%A0%EB%A6%AC%20%EB%B3%84%20%EC%84%A0%ED%98%B8%EB%8F%84%EB%A5%BC%20%EC%8B%9C%EA%B0%81%ED%99%94%ED%95%9C%20%EB%8C%80%EC%8B%9C%EB%B3%B4%EB%93%9C%EC%9E%85%EB%8B%88%EB%8B%A4!!%20%F0%9F%98%8A',openLinksInNewTab:!f),title:'',type:markdown,uiState:())),gridData:(h:4,i:'7f5ae121-abf1-4ab3-98da-8078c9d52f5a',w:48,x:0,y:0),panelIndex:'7f5ae121-abf1-4ab3-98da-8078c9d52f5a',title:'welcome!!',type:visualization,version:'7.17.10'),(embeddableConfig:(enhancements:()),gridData:(h:15,i:'0c255e8c-9220-440a-9672-cd06eaa8daa2',w:24,x:0,y:4),id:'45b9abb0-e474-11ef-a84c-0fe63e4fd213',panelIndex:'0c255e8c-9220-440a-9672-cd06eaa8daa2',type:lens,version:'7.17.10'),(embeddableConfig:(enhancements:()),gridData:(h:15,i:e56e7db2-9e4a-460f-a548-5b88c1f2e0c9,w:24,x:24,y:4),id:dcffac50-e473-11ef-a84c-0fe63e4fd213,panelIndex:e56e7db2-9e4a-460f-a548-5b88c1f2e0c9,type:lens,version:'7.17.10'),(embeddableConfig:(enhancements:()),gridData:(h:15,i:'55d299d0-bb96-490f-9784-45a73e9365f8',w:24,x:0,y:19),id:b28ebc20-e475-11ef-a84c-0fe63e4fd213,panelIndex:'55d299d0-bb96-490f-9784-45a73e9365f8',type:lens,version:'7.17.10'),(embeddableConfig:(enhancements:()),gridData:(h:15,i:'15ee83db-651b-407e-b5c8-23a97feea0a1',w:24,x:24,y:19),id:'788f52a0-e475-11ef-a84c-0fe63e4fd213',panelIndex:'15ee83db-651b-407e-b5c8-23a97feea0a1',type:lens,version:'7.17.10')),query:(language:kuery,query:''),tags:!(),timeRestore:!f,title:REJOY,viewMode:view)" height="1890px" width="500px"></iframe>
				</p>
			
		</div>
		
	</div>

</body>
</html>