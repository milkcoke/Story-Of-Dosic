<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import = "user.UserDAO" %> <!-- user Package의 userDAO import -->
 <%@ page import = "java.io.PrintWriter" %> <!--  JavaScript 문장을 작성하기 위함. -->
 <% request.setCharacterEncoding("UTF-8") ; %> <!-- 불러온 모든 Data를 UTF-8 인코딩 방식으로 처리. -->
 <jsp:useBean id = "user" class = "user.User" scope = "page"/> <!--  현재 page 내에서 javaBeans사용 (user.java) -->
 <jsp:setProperty name = "user" property ="userNum" />
 <jsp:setProperty name = "user" property = "userID"/>
<jsp:setProperty name = "user" property ="userPassword" />
<jsp:setProperty name = "user" property ="userName" />
<jsp:setProperty name = "user" property ="userEmail" />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv = "Content-Type" content = "text/html; charset = UTF-8">
<title>JoinAction</title>
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
		
		if(user.getUserNum() == null || user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null || user.getUserEmail() == null)
			{ // 누락된 항목이 있을 경우 경고메시지 표시하고 회원 가입 페이지로 돌아감.
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert ('모든 항목을 입력해주세요.')");
				script.println("history.back()");
				script.println("</script>");
			}  
		else {
				UserDAO userDAO = new UserDAO();
				//각각의 학번,ID,PW, 이름, Eamil 모든 정보가 user object에 들어있음.
				int result = userDAO.join(user);
				if(result < 0) // ID 중복성검사
				{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('이미 존재하는 ID입니다. )");
					script.println("history.back()"); // 사용자를 이전 페이지로 돌려보냄 (login page로 back)
					script.println("</script>");
				}	
				else		//회원가입 성공시
				{
					session.setAttribute("userID", user.getUserID());  // 회원가입 성공시에도 자동으로 로그인되어 세션이 ID로 생성됨.
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'main.jsp'"); // 회원가입 성공시 login 처리 후 main.jsp 로 이동.
					script.println("</script>");
				}
			}
		
			
		
			/*
			switch(result)
			{
			case -1: // 이부분 지금 오류
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 ID입니다. )");
				script.println("history.back()"); // 사용자를 이전 페이지로 돌려보냄 (login page로 back)
				script.println("</script>");
			break;
			
			default:
				session.setAttribute("userID", user.getUserID());  // 회원가입 성공시에도 자동으로 로그인되어 세션이 ID로 생성됨.
				PrintWriter script0 = response.getWriter();
				script0.println("<script>");
				script0.println("location.href = 'main.jsp'"); // 회원가입 성공시 login 처리 후 main.jsp 로 이동.
				script0.println("</script>");
			break;
			}
			*/
			%>

</body>
</html>
