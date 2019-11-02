<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.*" %>
<%@ page import="java.util.*" %>

<jsp:useBean id="dao" class="board.BBS_DAO"/>

<%
	if(session.getAttribute("userID")==null){
		System.out.println("Now testing");
		//response.sendRedirect("main.jsp");
	}
%>

<%
	String userID = (String)session.getAttribute("userID");
	//String userID = "123";
	int boardNum = 1;
	if(request.getParameter("boardNum")!=null){
		boardNum = Integer.parseInt(request.getParameter("boardNum"));
	}
	int total = dao.count(boardNum);
	
	ArrayList<BBS_VO> alist = dao.getMemberList(boardNum);
	
	int size = alist.size();
	int size2 = size;
	
	final int ROWSIZE = 4;
	final int BLOCK = 5;
	int indent = 0;
	
	int pg = 1;
	
	if(request.getParameter("pg")!=null){
		pg = Integer.parseInt(request.getParameter("pg"));
	}
	
	int end = (pg*ROWSIZE);
	
	int allPage = (int)Math.ceil(total/(double)ROWSIZE);
	int startPage = ((pg-1)/BLOCK * BLOCK)+1;
	int endPage = ((pg-1)/BLOCK * BLOCK)+BLOCK;
	
	if(endPage > allPage){
		endPage = allPage;
	}
	
	size2 -= end;
	
	if(size2 < 0){
		end = size;
	}
	String userNum = dao.IDtoNum(userID);
	String userName = dao.IDtoName(userID);
%>

<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="utf-8">
	<title>Insert title here</title>
	<!-- <link rel="stylesheet" type="text/css" href="./css/bootstrap.css"> -->
	<script src="http://localhost:5003/socket.io/socket.io.js"></script>
	<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
	<script src="./js/chatPage.js"></script>
	<link rel="stylesheet" type="text/css" href="./css/Newlayout.css">
</head>

<body>
	<div id="page-wrapper">
        <header id="main-header">
            <a href="main.jsp">
            	<h1 class="master-title">STORY OF DOSIC</h1>
            </a>
        </header>

        <nav id="main-navigation">
            <div class="pull-left">
                <ul class="outer-menu">
                    <li class="outer-menu-item"><a href="list.jsp?boardNum=1" title="자유게시판">자유게시판</a></li>
                    <li class="outer-menu-item"><a href="list.jsp?boardNum=2" title="상담게시판">상담게시판</a></li>
                    <li class="outer-menu-item"><a href="list.jsp?boardNum=3" title="강의평가">강의평가</a></li>
                    <li class="outer-menu-item"><a href="list.jsp?boardNum=4" title="장터">장터</a></li>
                    <li class="outer-menu-item"><a href="list.jsp?boardNum=5" title="사진첩">사진첩</a></li>
                </ul>
            </div>
        </nav>
        
        <div id="content">
            <span class="left">
                <div class="profile">
                	<img src="./image/Default-profile.jpg" width = "100"  height: "100" alt ="">
                	<li>학번	<%=userNum%></li>
                	<li>이름   <%=userName %></li>
                	<li>ID	<%=userID%></li>
                  	<form method = "post" action = "logoutAction.jsp">
                	<input type = "submit" class = "btn btn-primary form-control" value = "로그아웃">
                	</form>
                </div>
                <div class="chatting">
                	<h2>Chat</h2>
                	<ul id= "chatcontent" style="height:85%;width:100%;overflow:auto;">
               			
            		</ul>

            		<input type = "hidden" id = "userName" value = "<%=dao.IDtoName(userID) %>" disabled style="width:35px;"/>
            		<input id= "message" style="width:160px;"/>
            		<button id = "myBtn" style="width:35px;">전송</button>
                </div>
            </span>
			
			<span class="main"><%
				if(dao.chkPerm(boardNum, userID, "WritePerm")){ %>
				<div class="write">
					<form name = writeform method=post action="write.jsp?pg=<%=pg%>&boardNum=<%=boardNum%>">
                		<p>
                			<input name="BBSTitle" style="border:0;margin:0;padding:0" maxlength="100" placeholder="글 제목">
                			<input name="BoardNum" value="<%=boardNum%>" type="hidden">
                			<input name="userNum" value="<%=dao.IDtoNum(userID)%>" type="hidden">
						</p>
						<p>
							<textarea name="BBSContent" style="border:0;margin:0;padding:0" rows="10" placeholder="내용을 입력하세요."></textarea>
						</p>
						<ul>
							<input type=button value="등록" OnClick="javascript:writeCheck();">
						</ul>
                	</form>
				</div><%
				} %>
				<div class="list"><%
					if(total==0){%>
					<article>
						<p align="center" bgcolor="#FFFFFF" height="30">등록된 글이 없습니다.</p>
					</article> <%
					}
					else {%>
					<table><%
						for(int i=ROWSIZE*(pg-1); i<end; i++){
							BBS_VO vo = alist.get(i);
							indent = vo.getBBSIndent();
							int idx = vo.getBBSNum();%>
						<tr>
							<th><%
							for(int j=0; j<indent; j++){%>
								&nbsp;&nbsp;&nbsp;<%
							}
							if(indent!=0){ %>
								<img src='img/reply_icon.gif' /> <%
							} %>
							</th>
							<th>
								<article>
									<a href="view.jsp?idx=<%=idx%>&pg=<%=pg%>">
										<p><%=vo.getBBSTitle()%></p>
									</a>
								</article>
							</th>
						</tr><%
						} %>
					</table><%
					} %>
	                <!-- 
	                <table cellpadding="0" cellspacing="0" border="0">
						<tr height="5"><td width="5"></td></tr>
						<tr style="background:url('img/table_mid.gif') repeat-x; text-align:center;">
							<td width="5"><img src="img/table_left.gif" width="5" height="30" /></td>
							<td width="73">번호</td>
							<td width="379">제목</td>
							<td width="73">작성자</td>
							<td width="164">작성일</td>
							<td width="58">조회수</td>
							<td width="7"><img src="img/table_right.gif" width="5" height="30" /></td>
						</tr>
						<%
						if(total==0){
						%>
						<tr align="center" bgcolor="#FFFFFF" height="30">
							<td colspan="6">등록된 글이 없습니다.</td>
						</tr>
						<%
						}
						else{
							for(int i=ROWSIZE*(pg-1); i<end; i++){
								BBS_VO vo = alist.get(i);
								indent = vo.getBBSIndent();
								int idx = vo.getBBSNum();
						%>
						<tr height="25" align="center">
							<td align="center">&nbsp;</td>
							<td align="center"><%=idx%></td>
							<td align="left"> <%
								for(int j=0;j<indent;j++){ %>
									&nbsp;&nbsp;&nbsp; <%
								}
								if(indent!=0){ %>
									<img src='img/reply_icon.gif' /> <%
								} %>
								<a href="view.jsp?idx=<%=idx%>&pg=<%=pg%>"><%=vo.getBBSTitle()%></a>
							</td>
							<td align="center"><%=vo.getUserNum()%></td>
							<td align="center"><%=vo.getBBSDate()%></td>
							<td align="center"><%=vo.getBBSHit()%></td>
							<td align="center">&nbsp;</td>
						</tr>
						<tr height="1" bgcolor="#D2D2D2">
							<td colspan="6"></td>
						</tr> <%
							}
						}%>
						<tr height="1" bgcolor="#82B5DF">
							<td colspan="6" width="752"></td>
						</tr>
					</table>

					<table width="100%" cellpadding="0" cellspacting="0" border="0">
						<tr>
							<td colspan="4" height="5"></td>
						</tr>
						<tr>
							<td align="center"> <%
							if(pg>BLOCK){ %>
								[<a href="list.jsp?pg=1">◀◀</a>]
								[<a href="list.jsp?pg=<%=startPage-1%>">◀</a>]<%
							} %> <%
							for(int i=startPage; i <=endPage; i++){
								if(i==pg){%>
									<u><b>[<%=i %>]</b></u> <%
								}
								else{%>
								[<a href="list.jsp?pg=<%=i %>"><%=i %></a>]<%
								}
							}%> <%
							if(endPage<allPage){ %>
								[<a href="list.jsp?pg=<%=endPage+1%>">▶</a>]
								[<a href="list.jsp?pg=<%=allPage%>">▶▶</a>]<%
							}%>
							</td>	
						</tr>
					</table> -->
                </div>
			</span>
			<!-- 
            <span class="middle">
                <div class="list">
	                <table width="100%" cellpadding="0" cellspacing="0" border="0">
						<tr height="5"><td width="5"></td></tr>
						<tr style="background:url('img/table_mid.gif') repeat-x; text-align:center;">
							<td width="5"><img src="img/table_left.gif" width="5" height="30" /></td>
							<td width="73">번호</td>
							<td width="379">제목</td>
							<td width="73">작성자</td>
							<td width="164">작성일</td>
							<td width="58">조회수</td>
							<td width="7"><img src="img/table_right.gif" width="5" height="30" /></td>
						</tr>
						<%
						if(total==0){
						%>
						<tr align="center" bgcolor="#FFFFFF" height="30">
							<td colspan="6">등록된 글이 없습니다.</td>
						</tr>
						<%
						}
						else{
							for(int i=ROWSIZE*(pg-1); i<end; i++){
								BBS_VO vo = alist.get(i);
								indent = vo.getBBSIndent();
								int idx = vo.getBBSNum();
						%>
						<tr height="25" align="center">
							<td align="center">&nbsp;</td>
							<td align="center"><%=idx%></td>
							<td align="left"> <%
								for(int j=0;j<indent;j++){ %>
									&nbsp;&nbsp;&nbsp; <%
								}
								if(indent!=0){ %>
									<img src='img/reply_icon.gif' /> <%
								} %>
								<a href="view.jsp?idx=<%=idx%>&pg=<%=pg%>"><%=vo.getBBSTitle()%></a>
							</td>
							<td align="center"><%=vo.getUserNum()%></td>
							<td align="center"><%=vo.getBBSDate()%></td>
							<td align="center"><%=vo.getBBSHit()%></td>
							<td align="center">&nbsp;</td>
						</tr>
						<tr height="1" bgcolor="#D2D2D2">
							<td colspan="6"></td>
						</tr> <%
							}
						}%>
						<tr height="1" bgcolor="#82B5DF">
							<td colspan="6" width="752"></td>
						</tr>
					</table>

					<table width="100%" cellpadding="0" cellspacting="0" border="0">
						<tr>
							<td colspan="4" height="5"></td>
						</tr>
						<tr>
							<td align="center"> <%
							if(pg>BLOCK){ %>
								[<a href="list.jsp?pg=1">◀◀</a>]
								[<a href="list.jsp?pg=<%=startPage-1%>">◀</a>]<%
							} %> <%
							for(int i=startPage; i <=endPage; i++){
								if(i==pg){%>
									<u><b>[<%=i %>]</b></u> <%
								}
								else{%>
								[<a href="list.jsp?pg=<%=i %>"><%=i %></a>]<%
								}
							}%> <%
							if(endPage<allPage){ %>
								[<a href="list.jsp?pg=<%=endPage+1%>">▶</a>]
								[<a href="list.jsp?pg=<%=allPage%>">▶▶</a>]<%
							}%>
							</td>	
						</tr>
					</table>
                </div>
            </span>  -->
        </div>
        <footer id="main-footer">
            <a href="#">Created By dosic</a>
        </footer>
    </div>
    
	<script><%
		String title = dao.getBoardName(boardNum); %>
		document.title = "SoD - " + "<%=title%>";
	</script>
	<%
	if(dao.chkPerm(boardNum, userID, "WritePerm")){
	%>
	<script>
		function writeCheck(){
			var form = document.writeform;
			if(!form.BBSTitle.value){
				alert("제목을 적어주세요");
			    form.BBSTitle.focus();
			    return;
			}
			if(!form.BBSContent.value){
				alert("내용을 적어주세요");
				form.BBSContent.focus();
				return;
			}
			form.submit();
		}
	</script><%
	} %>
</body>

</html>