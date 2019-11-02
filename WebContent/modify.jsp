
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.*" %>
<%@ page import="java.util.*" %>

<jsp:useBean id="dao" class="board.BBS_DAO"/>

<%
	if(session.getAttribute("userID")==null){
		response.sendRedirect("main.jsp");
	}
%>

<%
	String userID = (String)session.getAttribute("userID");
	int boardNum = Integer.parseInt(request.getParameter("boardNum"));
	int idx = Integer.parseInt(request.getParameter("idx"));
	BBS_VO vo = dao.getView(idx);
%>

<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="utf-8">
	<title>Insert title here</title>
	<link rel="stylesheet" type="text/css" href="./css/layout.css">
</head>

<body>
	<div id="page-wrapper">
        <header id="main-header">
            <h1 class="master-title">STORY OF DOSIC</h1>
        </header>

        <nav id="main-navigation">
            <div class="pull-left">
                <ul class="outer-menu">
                    <li class="outer-menu-item"><a href="list.jsp?boardNum=1">자유게시판</a></li>
                    <li class="outer-menu-item"><a href="list.jsp?boardNum=2">상담게시판</a></li>
                    <li class="outer-menu-item"><a href="list.jsp?boardNum=3">강의평가</a></li>
                    <li class="outer-menu-item"><a href="list.jsp?boardNum=4">장터</a></li>
                    <li class="outer-menu-item"><a href="list.jsp?boardNum=5">사진첩</a></li>
                </ul>
            </div>
        </nav>
        
        <div id="content">
            <span class="left">
                <div class="profile">
                	<li>ID  <%=userID%></li>
                </div>
                <div class="chatting">채팅자리다 </div>
            </span>
			
            <span class="middle">
				<div class="modify">
					<table>
						<form name=modifyform method=post action="modify_chk.jsp?idx=<%=idx%>&boardNum=<%=boardNum%>">
							<tr>
								<td>
	                				<table width="100%" cellpadding="0" cellspacing="0" border="0">
	                					<tr style="background:url('img/table_mid.gif') repeat-x; text-align:center;">
	                						<td width="5">
	                							<img src="img/table_left.gif" width="5" height="30" />
	                						</td>
      										<td>수정</td>
      										<td width="5">
      											<img src="img/table_right.gif" width="5" height="30" />
      										</td>
	                					</tr>
	                				</table>
	                				
	                				<table>
	                					<tr>
	                						<td>&nbsp;</td>
      										<td align="center">제목</td>
      										<td>
      											<input type=text name=BBSTitle size=50  maxlength=50 value="<%=vo.getBBSTitle()%>">
      											<input name="BoardNum" value="<%=boardNum%>" type="hidden">
      										</td>
      										<td>&nbsp;</td>
	                					</tr>
	                					<tr height="1" bgcolor="#dddddd">
	                						<td colspan="4"></td>
	                					</tr>
	                					<tr>
      										<td>&nbsp;</td>
      										<td align="center">작성자</td>
      										<td><%=vo.getUserNum()%>
      											<input type=hidden name=userNum size=50  maxlength=50 value="<%=vo.getUserNum()%>">
      										</td>
										    <td>&nbsp;</td>
     									</tr>
      									<tr height="1" bgcolor="#dddddd">
      										<td colspan="4"></td>
      									</tr>
    									<tr>
    										<td>&nbsp;</td>
      										<td align="center">내용</td>
      										<td>
      											<textarea name=BBSContent cols=50 rows=13><%=vo.getBBSContent()%></textarea>
      										</td>
      										<td>&nbsp;</td>
    									</tr>
    									<tr height="1" bgcolor="#dddddd">
    										<td colspan="4"></td>
    									</tr>
     									<tr height="1" bgcolor="#82B5DF">
     										<td colspan="4"></td>
     									</tr>
     									<tr align="center">
     										<td>&nbsp;</td>
      										<td colspan="2">
      											<input type="button" value="수정" OnClick="javascript:modifyCheck();">
      											<input type=button value="취소" OnClick="javascript:history.back(-1)">
      										</td>
      										<td>&nbsp;</td>
     									</tr>
	                				</table>
	                			</td>
	                		</tr>
	                	</form>
	                </table>
	            </div>
            </span>
        </div>
        <footer id="main-footer">
            <a href="#">Created By dosic</a>
        </footer>
    </div>
    
	<script>
		document.write ( '<p>' + document.title + '</p>' );
		document.title = "<SoD 게시물 수정> " + <%=vo.getBBSTitle()%>;
	</script>
	
	<script>
		function modifyCheck(){
			var form = document.modifyform;
			
			if(!form.BBSTitle.value){
				alert( "제목을 적어주세요" );
			    form.BBSTitle.focus();
			    return;
			}
			
			if(!form.BBSContent.value){
				alert( "내용을 적어주세요" );
			    form.BBSContent.focus();
			    return;
			}
			form.submit();
		}
	</script>

</body>

</html>