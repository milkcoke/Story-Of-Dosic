<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import = "user.UserDAO" %> <!-- user Package의 userDAO import -->
 <%@ page import = "java.io.PrintWriter" %> <!--  JavaScript 문장을 작성하기 위함. -->
 <% request.setCharacterEncoding("UTF-8") ; %> <!-- 불러온 모든 Data를 UTF-8 인코딩 방식으로 처리. -->

<!DOCTYPE html>
<html>
<head>
<meta http-equiv = "Content-Type" content = "text/html; charset = UTF-8">
<title>JoinAction</title>
</head>
<body>
	<% 
		session.invalidate(); // 로그아웃 할 경우 세션 연결 해제
	%>
	<script>
	location.href = "login.jsp"; // 로그아웃시 로그인 페이지로 이동.
	
	</script>	

</body>
</html>
