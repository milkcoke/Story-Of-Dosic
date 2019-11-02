<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="dao" class="board.BBS_DAO"/>
<jsp:useBean id="vo" class="board.BBS_VO"/>
<jsp:setProperty name="vo" property="*" />

<%
	if(session.getAttribute("userID")==null){
		response.sendRedirect("main.jsp");
	}
%>

<%
	int idx = Integer.parseInt(request.getParameter("idx"));
	int boardNum = Integer.parseInt(request.getParameter("boardNum"));
	String userID = (String)session.getAttribute("userID");
	
	if((dao.chkPerm(boardNum, userID, "ModifyPerm") || vo.getUserNum()==dao.IDtoNum(userID))){
		dao.modify(vo, idx); %>
		<script>
			self.window.alert("글을 수정하였습니다.");
			location.href="view.jsp?idx=<%=idx%>&boardNum=<%=boardNum%>";
		</script>
	<%
	}
	else { %>
		<script>
			self.window.alert("수정 권한이 없습니다.");
			location.href="javascript:history.back()";
		</script> <%
	}
%>
