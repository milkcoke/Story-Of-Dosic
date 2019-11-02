<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="dao" class="board.BBS_DAO"/>
<jsp:useBean id="vo" class="board.BBS_VO"/>
<jsp:setProperty name="vo" property="*" />

<%	
	String userID = (String)session.getAttribute("userID");
	request.setCharacterEncoding("UTF-8");
	int boardNum = Integer.parseInt(request.getParameter("boardNum"));
	int pg = Integer.parseInt(request.getParameter("pg"));
	int max = dao.getMax(boardNum);
	if(dao.chkPerm(boardNum, userID, "WritePerm")){
		dao.insertWrite(vo, max);%>
		<script>
			// console.log("<%= vo.getBBSTitle() %>");
			self.window.alert("입력한 글을 저장하였습니다.");
		    location.href="list.jsp?pg=<%=pg%>&boardNum=<%=boardNum%>";
		</script><%
	}
	else{%>
		<script>
			self.window.alert("게시글 작성 권한이 없습니다.");
		    location.href="list.jsp?pg=<%=pg%>&boardNum=<%=boardNum%>";
		</script><%
	}
%>