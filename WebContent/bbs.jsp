<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import = "java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv= "Content-Type" content = "txt/html; charset = UTF-8">
<meta name= "viewport" content = "width=device-width", initial-scale = "1">
<link rel = "stylesheet" href = "css/bootstrap.css">
<!--  같은 폴더 내의 css/bootstrap.css 디자인 사용 -->

<title>Story Of Dosic</title>
</head>
<body>
	<%
		String userID = "msh";
		if(session.getAttribute("userID") != null)
		{
			userID = (String) session.getAttribute("userID"); // 로그인 세션값을 ID로 담음.
		}
	%>
	<nav class = "navbar navbar-defualt">
		<div class = "navbar-header">
			<button type = "button" class = "navbar-toggle collapsed"
			data-toggle = "collapse" data-target = "#bs-example-navbar-collapse-1"
			aria-expanded = "false">
			<span class= "icon-bar"></span>
			<span class= "icon-bar"></span>
			</button>
			<a class = "navbar-brand" href = "main.jsp"> Story Of Dosic </a>

			
		</div>
		<div class = "collapse navbar-collapse" id = "bs-example-navbar -collapse-1">
			<ul class = "nav navbar-nav">
				<li> <a href = "main.jsp"> 메인 </a></li>
				<li  class = "active"> <a href = "bbs.jsp"> 게시판 </a></li>
			</ul>
			
			<%
				if(userID == null) {
					
			%>
			<ul class = "nav navbar-nav navbar-left">
			<!--  목록 왼쪽 -->
				<li calss = "dropdown">
					<a href = "#" class = "dropdown-toggle"
						data-toggle="dropdwon" role = "button" aria-haspopup = "true"
						aria-expanded="false"> Login  <span class = "caret"></span></a>
						<ul class = dropdown-menu">
							<li><a href = "login.jsp">로그인</a></li>
							<li><a href = "join.jsp">회원가입</a></li>
						</ul>
					</li>
			</ul>
			<%
				} 
				else
				{
			%>
				<ul class = "nav navbar-nav navbar-left">
				<li calss = "dropdown">
					<a href = "#" class = "dropdown-toggle"
						data-toggle="dropdwon" role = "button" aria-haspopup = "true"
						aria-expanded="false"> 회원관리 <span class = "caret"></span></a>
						<ul class = dropdown-menu">
							<!-- 이미 로그인 된 유저는 로그아웃 버튼만 보이도록 함. -->
							<li><a href = "logoutAction.jsp">로그아웃</a></li> 
						</ul>
					</li>
			</ul>
			<%			
				}
			%>		
		</div>
	</nav>
	<div class = "container">
		<div class = "row">
		<!-- 짝 홀수 게시물 번호마다 디자인 색 입히는 코드 -->
			<table class = "table table-striped" style = "text-align: center; border: 1px solid #ddddd">
				<thead> <!-- 테이블의 제목과 속성을 명시 -->
				<tr> <!--  tr는 하나의 행을 뜻함 -->
					<th style = "background-color: #ffffff; text-align : center;">게시물 번호</th>
					<th style = "background-color: #ffffff; text-align : center;">제목</th>
					<th style = "background-color: #ffffff; text-align : center;">작성자</th>
					<th style = "background-color: #ffffff; text-align : center;">작성일</th>
				</tr>
				</thead> 
				<tbody> <!--  예시 데이터 -->
					<td>1</td>
					<td>안녕 </td>
					<td>문승훈 </td>
					<td> 2019-06-02</td>
				</tbody>
				</table>
				<a href="write.jsp" class = "btn btn-primary pull-left">Write</a>
			</div>
	</div>
	<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src = "js/bootstrap.js"></script>
</body>
</html>