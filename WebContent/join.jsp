<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv= "Content-Type" content = "txt/html; charset = UTF-8">
<meta name= "viewport" content = "width=device-width", initial-scale = "1">
<link rel = "stylesheet" href = "css/Konkuk.css"> 
<!--  같은 폴더 내의 css/bootstrap.css 디자인 사용 -->
<!--  색상이름 #27823F -->

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
			<!--  <ul class = "nav navbar-nav">
				<li> <a href = "main.jsp"> 메인 </a></li>
				<li> <a href = "bbs.jsp"> 게시판 </a></li>
			</ul> -->
			<ul class = "nav navbar-nav navbar-left">
			<!--  목록 오른쪽 -->
				<li calss = "dropdown">
					<!-- #의미: 현재 가리키는 링크는 없는 상태 -->
					<a href = "#" class = "dropdown-toggle"
						data-toggle="dropdwon" role = "button" aria-haspopup = "true"
						aria-expanded="false"> Membership <span class = "caret"></span></a>
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
				<form method = "post" action = "joinAction.jsp">
				<!-- 회원가입 액션 페이지로 로그인 정보를 보내주는 라인 -->
					<h3 style = "text-align: center; "> 회원가입 </h3>
					<div class = "form-group">
						<input type = "text" class = "form-control" placeholder="학번" name = "userNum" maxlength = "9">
					</div>
					<!-- 회원가입 창 -->
					<div class = "form-group">
						<input type = "text" class = "form-control" placeholder="아이디" name = "userID" maxlength = "20">
					</div>
					<div class = "form-group">
						<input type = "password" class = "form-control" placeholder="비밀번호" name = "userPassword" maxlength = "20">
					</div>
					
					<div class = "form-group">
						<input type = "text" class = "form-control" placeholder="이름" name = "userName" maxlength = "5">
					</div>
					<div class = "form-group">
						<input type = "email" class = "form-control" placeholder="이메일" name = "userEmail" maxlength = "50">
					</div>
					<input type = "submit" class = "btn btn-primary form-control" value = "회원가입">
				
				</form>		
			</div>
	
	</div>

	<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src = "js/bootstrap.js"></script>
</body>
</html>