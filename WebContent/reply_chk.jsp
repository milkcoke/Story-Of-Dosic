<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.*" %>
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
	
	BBS_VO vo1 = dao.getView(idx);
	int ref = vo1.getBBSResfPost();
	int indent = vo1.getBBSIndent();
	
	if((dao.chkPerm(boardNum, userID, "WritePerm") || vo.getUserNum()==dao.IDtoNum(userID))){
		dao.insertReply(vo1, ref, indent); %>
		<script>
			self.window.alert("답글을 삽입하였습니다.");
			location.href="view.jsp?idx=<%=idx%>&boardNum=<%=boardNum%>";
		</script>
	<%
	}
	else { %>
		<script>
			self.window.alert("답글 작성 권한이 없습니다.");
			location.href="javascript:history.back()";
		</script> <%
	}
%>
