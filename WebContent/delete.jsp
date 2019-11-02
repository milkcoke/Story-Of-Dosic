<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.*" %>

<jsp:useBean id="dao" class="board.BBS_DAO"/>
<jsp:useBean id="vo" class="board.BBS_VO"/>

<%
	if(session.getAttribute("userID")==null){
		response.sendRedirect("main.jsp");
	}
%>

<%
	int idx = Integer.parseInt(request.getParameter("idx"));
	int pg = Integer.parseInt(request.getParameter("pg"));
	int boardNum = Integer.parseInt(request.getParameter("boardNum"));
	String userID = (String)session.getAttribute("userID");
	
	if((dao.chkPerm(boardNum, userID, "DeletePerm") || vo.getUserNum()==dao.IDtoNum(userID))){
		dao.delete(idx); %>
		<script>
			self.window.alert("글을 삭제하였습니다.");
			location.href="list.jsp?pg=<%=pg%>&boardNum=<%=boardNum%>";
		</script>
	<%
	}
	else { %>
		<script>
			self.window.alert("삭제 권한이 없습니다.");
			location.href="javascript:history.back()";
		</script> <%
	}
%>
