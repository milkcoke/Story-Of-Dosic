<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.*" %>

<jsp:useBean id="dao" class="board.BBS_DAO"/>

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
	BBS_VO vo = dao.getView(idx);	
	dao.UpdateHit(idx);
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" type="text/css" href="./css/layout.css">
</head>

<body>

<%
	if(!(dao.chkPerm(boardNum, userID, "ReadPerm") || vo.getUserNum()==dao.IDtoNum(userID))){%>
		<script>
			alert('게시물을 읽을 권한이 없습니다.');
			window.history.back();
		</script> <%
	}
%>

	<div id="page-wrapper">
        <header id="main-header">
            <h1 class="master-title">STORY OF DOSIC</h1>
        </header>

        <nav id="main-navigation">
            <div class="pull-left">
                <ul class="outer-menu">
                    <li class="outer-menu-item"><a href="list.jsp?boardNum=0">자유게시판</a></li>
                    <li class="outer-menu-item"><a href="list.jsp?boardNum=1">상담게시판</a></li>
                    <li class="outer-menu-item"><a href="list.jsp?boardNum=2">강의평가</a></li>
                    <li class="outer-menu-item"><a href="list.jsp?boardNum=3">장터</a></li>
                    <li class="outer-menu-item"><a href="list.jsp?boardNum=4">사진첩</a></li>
                </ul>
            </div>
        </nav>
        
        <div id="content">
            <span class="left">
                <div class="profile">프로필이다</div>
                <div class="chatting">채팅자리다 </div>
            </span>
			
            <span class="middle">
                <table>
                	<tr>
                		<td>
                			<table width="100%" cellpadding="0" cellspacing="0" border="0">
	                			<tr style="background:url('img/table_mid.gif') repeat-x; text-align:center;">
	                				<td width="5"><img src="img/table_left.gif" width="5" height="30" /></td>
								    <td>내 용</td>
								    <td width="5"><img src="img/table_right.gif" width="5" height="30" /></td>
	                			</tr>
	                		</table>
	                		
	                		<table width="413">
	                			<tr>
      								<td width="0">&nbsp;</td>
      								<td align="center" width="76">글번호</td>
      								<td width="319"><%=idx%></td>
      								<td width="0">&nbsp;</td>
     							</tr>
     							<tr height="1" bgcolor="#dddddd">
     								<td colspan="4" width="407"></td>
     							</tr>
     							<tr>
      								<td width="0">&nbsp;</td>
      								<td align="center" width="76">조회수</td>
      								<td width="319"><%=vo.getBBSHit()%></td>
      								<td width="0">&nbsp;</td>
     							</tr>
     							<tr height="1" bgcolor="#dddddd">
     								<td colspan="4" width="407"></td>
     							</tr>
    							<tr>
							    	<td width="0">&nbsp;</td>
									<td align="center" width="76">작성자</td>
									<td width="319"><%=dao.IDtoNum(vo.getUserNum())%></td>
									<td width="0">&nbsp;</td>
								</tr>
								<tr height="1" bgcolor="#dddddd">
									<td colspan="4" width="407"></td>
								</tr>
								<tr>
      								<td width="0">&nbsp;</td>
  								    <td align="center" width="76">작성일</td>
     								<td width="319"><%=vo.getBBSDate()%></td>
      								<td width="0">&nbsp;</td>
     							</tr>
     							<tr height="1" bgcolor="#dddddd">
     								<td colspan="4" width="407"></td>
     							</tr>
    							<tr>
      								<td width="0">&nbsp;</td>
      								<td align="center" width="76">제목</td>
      								<td width="319"><%=vo.getBBSTitle()%></td>
      								<td width="0">&nbsp;</td>
     							</tr>
     							<tr height="1" bgcolor="#dddddd">
     								<td colspan="4" width="407"></td>
     							</tr>
                				<tr>
      								<td width="0"></td>
                   					<td width="399" colspan="2" height="200"><%=vo.getBBSContent() %>
                				</tr>
     							<tr height="1" bgcolor="#dddddd">
     								<td colspan="4" width="407"></td>
     							</tr>
     							<tr height="1" bgcolor="#82B5DF">
     								<td colspan="4" width="407"></td>
     							</tr>
     							<tr align="center">
      								<td width="0">&nbsp;</td>
      								<td colspan="2" width="399">
										<input type=button value="답글" OnClick="window.location='reply.jsp?idx=<%=idx%>&boardNum=<%=boardNum%>'">
										<input type=button value="목록" OnClick="window.location='list.jsp?pg=<%=pg%>&boardNum=<%=boardNum%>'">
										<input type=button value="수정" OnClick="window.location='modify.jsp?idx=<%=idx%>&boardNum=<%=boardNum%>'">
										<input type=button value="삭제" OnClick="window.location='delete.jsp?idx=<%=idx%>&pg=<%=pg%>&boardNum=<%=boardNum%>'">
      								<td width="0">&nbsp;</td>
      							</tr>
	                		</table>
                		</td>
                	</tr>
                </table>
            </span>
        </div>
        <footer id="main-footer">
            <a href="#">Created By dosic</a>
        </footer>
    </div>
    
	<script>
		document.write ( '<p>' + document.title + '</p>' );	<%
		String title = dao.getBoardName(boardNum); %>
		document.title = "SOD - " + <%=title%>;
	</script>
</body>
</html>