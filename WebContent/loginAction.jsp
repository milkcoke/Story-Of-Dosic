<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import = "user.UserDAO" %> <!-- user Package의 userDAO import -->
 <%@ page import = "java.io.PrintWriter" %> <!--  JavaScript 문장을 작성하기 위함. -->
 <% request.setCharacterEncoding("UTF-8") ; %> <!-- 불러온 모든 Data를 UTF-8 인코딩 방식으로 처리. -->
 <jsp:useBean id = "user" class = "user.User" scope = "page" /> <!--  현재 page 내에서 javaBeans사용 (user.java) -->
 <jsp:setProperty name = "user" property = "userID" />
 <jsp:setProperty name = "user" property = "userPassword" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv = "Content-Type" content = "text/html; charset = UTF-8">
<title>LoginAction</title>
</head>
<body>
	<%
		String userID = null;
	if(session.getAttribute("userID") != null) // 이미 로그인된 상태인 경우
	{
		userID = (String) session.getAttribute("userID");
	}
	if(userID != null)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인된 상태입니다.')");
		script.println("location.href = 'main.jsp'"); // 사용자를 이전 페이지로 돌려보냄 (login page로 back)
		script.println("</script>");
	}
	
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword()); // -2~1 result 결과 받아옴.
		
		switch(result)
		{
		case 1:
			session.setAttribute("userID", user.getUserID()); //로그인 성공시 해당 회원의 ID를 세션값으로 생성.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		break;
		
		case -1:
			PrintWriter script1 = response.getWriter();
			script1.println("<script>");
			script1.println("alert('아이디가 존재하지 않습니다.')");
			script1.println("history.back()"); // 사용자를 이전 페이지로 돌려보냄 (login page로 back)
			script1.println("</script>");
		break;
		
		case 0:
			PrintWriter script3 = response.getWriter();
			script3.println("<script>");
			script3.println("alert('비밀번호가 틀립니다.')");
			script3.println("history.back()"); 
			script3.println("</script>");
		break;
		
		case -2:
			PrintWriter script4 = response.getWriter();
			script4.println("<script>");
			script4.println("alert('데이터베이스 오류가 발생했습니다.')");
			script4.println("history.back()"); 
			script4.println("</script>");
		}
	%>
</body>
</html>
