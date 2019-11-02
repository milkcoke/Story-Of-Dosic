<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv= "Content-Type" content = "txt/html; charset = UTF-8">
<meta name= "viewport" content = "width=device-width", initial-scale = "1">
<link rel = "stylesheet" href = "css/Konkuk.css">
<!--  같은 폴더 내의 css/bootstrap.css 디자인 사용 -->
<style>
.chatbot
{
   background: white;
   text-align: center;
   color: green;
   padding: 10px;
   border:1px solid black;
   margin-top: 10px;
   width: 210px;
   height: 50px;
}
.chatbot:hover
{
   background: #E6E6E6;

}

a{color: green;}
</style>

<title>Story Of Dosic</title>
</head>
<body>
	<nav class = "navbar navbar-defualt">
		<div class = "navbar-header">
			<button type = "button" class = "navbar-toggle collapsed"
			data-toggle = "collapse" data-target = "#bs-example-navbar-collapse-1"
			aria-expanded = "false">
			<span class= "icon-bar"></span>
			<span class= "icon-bar"></span>
			</button>
			<a class = "navbar-brand" href = "main.jsp"> Story Of Dosic </a>
			<!--  메인로고 Story Of Dosic -->
		</div>
		
		<div class = "collapse navbar-collapse" id = "bs-example-navbar -collapse-1">

			<ul class = "nav navbar-nav navbar-left">	
			<!--  목록 왼쪽 -->
				<li calss = "dropdown">
					<!-- #의미: 현재 가리키는 링크는 없는 상태 -->
					<a href = "#" class = "dropdown-toggle"
						data-toggle="dropdwon" role = "button" aria-haspopup = "true"
						aria-expanded="false"> Membership  <span class = "caret"></span></a>
						<!-- 일종의 Icon역할, 아래로 주루룩 메뉴가 나오게함 -->
						<ul class = dropdown-menu">
							<li class = "active"><a href = "login.jsp">로그인</a></li>
							<li><a href = "join.jsp">회원가입</a></li>
						</ul>
					</li>
			</ul>
		</div>
	</nav>
	<div class = "container">
		<div class = "col-lg-4"></div>
		<div class = "col-lg-4">
				<div class = "jumbotron" style = "padding-top : 20px;">
				<form method = "post" action = "loginAction.jsp">
				<!-- 로그인 액션 페이지로 로그인 정보를 보내주는 라인 -->
					<h3 style = "text-align: center; "> 로그인</h3>
					
					<!-- 로그인 창 -->
					<div class = "form-group">
						<input type = "text" class = "form-control" placeholder="아이디" name = "userID" maxlength = "20">
					</div>
					<div class = "form-group">
						<input type = "password" class = "form-control" placeholder="비밀번호" name = "userPassword" maxlength = "20">
					</div>
					<input type = "submit" class = "btn btn-primary form-control" value = "로그인">
				
				</form>		
			</div>
	
	</div>
	

	<div class = "jumbotron" style = "padding-top : 20px;">
		<button class = "btn btn-primary form-control"  onclick="location.href='http://m.me/2340555582668194'" >
		챗봇을 이용해 보세요!
		</button>
    </form>
	</div>

		<!-- <div class="chatbot">
            <a href="http://m.me/2340555582668194">챗봇을 이용해 보세요!</div>	-->

	<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src = "js/bootstrap.js"></script>
</body>
</html>