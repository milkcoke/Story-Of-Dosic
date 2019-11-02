<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import = "java.io.PrintWriter" %>
 <%@ page import = "board.*" %>

 <jsp:useBean id="dao" class="board.BBS_DAO"/>
 

<!DOCTYPE html>
<html>
<head>
<!--  <meta http-equiv= "Content-Type" content = "txt/html; charset = UTF-8">-->
<!-- <meta name= "viewport" content = "width=device-width", initial-scale = "1"> -->
<!--<link rel = "stylesheet" href = "css/bootstrap.css">-->
<!-- <link rel="stylesheet" type="text/css" href="./css/layout.css"> -->

<title>Story Of Dosic</title>
<meta charset="utf-8">
<!-- <link rel="stylesheet" type="text/css" href="./css/bootstrap.css"> -->
<script src="http://localhost:5003/socket.io/socket.io.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<script src="./js/chatPage.js"></script>
<script src="./js/layout.js"></script>  
<link rel="stylesheet" type="text/css" href="./css/Newlayout.css">

</head>


<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null)
		{
			userID = (String) session.getAttribute("userID"); // 로그인 세션값을 ID로 담음.
		}
	%>
	
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
                	<li>학번	<%=dao.IDtoNum(userID)%></li> <!-- 이거 메소드 안먹힘 버그 수정 필요 -->
                	<li>이름   <%=dao.IDtoName(userID) %></li>
                	<li>ID	<%=userID %></li>
                	<form method = "post" action = "logoutAction.jsp">
                	<input type = "submit" class = "btn btn-primary form-control" value = "로그아웃">
                	</form>
                </div>
                <div class="chatting">
                	<h2>Chat</h2>
                	<ul id= "chatcontent" style="height:85%;width:100%;overflow:auto;">
               			
            		</ul>
					<!--  이부분도 수정했음 userName이 아니라 dao.IDOt -->
					<input type = "hidden" id = "userName" value = "<%=dao.IDtoName(userID) %>" disabled style="width:35px;"/>
            		<!--  <input type = "hidden" id = "userID" value = "<//%=userID %>" disabled style="width:35px;"/> --> 
            		<input id= "message" style="width:160px;"/>
            		<button id = "myBtn" style="width:35px;">전송</button>
                </div>
            </span>
            
            
            <span class="left">
       <div class="link">
    <dl class="accordion">
     <dt>건국대학교 홈페이지</dt>
     <dd><a href="http://www.konkuk.ac.kr">건국대학교 홈페이지</a></dd>
     <dt>건국대학교 이캠퍼스</dt>
     <dd><a href="http://ecampus.konkuk.ac.kr">이러닝과 과제 체출하러 GOGO~</a></dd>
     <dt>건국대학교 상허기념 도서관</dt>
     <dd><a href="https://library.konkuk.ac.kr/#/">도서관 자료찾기, 시설물 예약하러 GOGO</a></dd>
     <dt>스마트ICT융합공학과 홈페이지</dt>
     <dd><a href="http://sicte.konkuk.ac.kr/main.do">우리과의 홈페이지</a></dd>
     <dt>스마트ICT융합공학과 페이스북</dt>
     <dd><a href="https://www.facebook.com/KU융합과학기술원-스마트ICT융합공학과-319038848489994/">스융공의 공식 페이스북 페이지 GOGO~</a></dd>
    </dl>
   </div> 
   
   <div class="photos">
    
    <div class="slideshow">
     <img src="./image/logo.jpg" alt=""/> 
     <img src="./image/coverpic.jpg" alt="" class="alt">
     <img src="./image/green.jpg" alt="" class="alt">
     <img src="./image/seoul.jpg" alt="" class="alt">
    </div>
   </div>
   </span>
   
   <span class="left">
   <div class="news">
    <div id="schedule_header">
   <h2>스케쥴 노트</h2>
   </div>
  
  <div id="note_form">
   <table>
    <tr>
     <td>제목</td><td><input type=text id="note_title"></td>
    </tr>

    <tr>
     <td>날짜</td><td><input type=date id="note_date"></td>
    </tr>

    <tr>
     <td>내용</td><td><textarea id="note_content" row=20 cols=20></textarea></td>
    </tr>

    <tr>
     <td colspan="2" align="center"><button id="add_note">확인</button></td>
    </tr>
   </table>
   
   <div id="note"></div>
  </div>
  </div>
<div class="chatbot">
    <a href="http://m.me/2340555582668194">챗봇을 이용해 보세요!</div>
  </span>
    
   
   
   
   
    
           

	<!--  <nav class = "navbar navbar-defualt">
		<div class = "navbar-header">
			<button type = "button" class = "navbar-toggle collapsed"
			data-toggle = "collapse" data-target = "#bs-example-navbar-collapse-1"
			aria-expanded = "false">
			<span class= "icon-bar"></span>
			<span class= "icon-bar"></span>
			</button>
			<a class = "navbar-brand" href = "main.jsp"> Story Of Dosic </a>
			<!--  메인로고 Story Of Dosic -->
			
		<!-- </div>
		<div class = "collapse navbar-collapse" id = "bs-example-navbar -collapse-1">
			<ul class = "nav navbar-nav">
				<li class = "active"> <a href = "main.jsp"> 메인 </a></li>
				<li> <a href = "bbs.jsp"> 게시판 </a></li>
			</ul>-->
			
			<%
				//if(userID != null) { // dlwp 필요 X
			%>
				<!-- <ul class = "nav navbar-nav navbar-left">
				<li calss = "dropdown">
					<a href = "#" class = "dropdown-toggle"
						data-toggle="dropdwon" role = "button" aria-haspopup = "true"
						aria-expanded="false"> 회원관리 <span class = "caret"></span></a>
						<ul class = dropdown-menu">
							<!-- 이미 로그인 된 유저는 로그아웃 버튼만 보이도록 함. -->
							<!-- <li><a href = "logoutAction.jsp">로그아웃</a></li> 
						</ul>
					</li>
			</ul> -->

		<!-- </div>
	</nav>-->
	
	<!--  <script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>-->
	<!-- <script src = "js/bootstrap.js"></script>-->
</body>
</html>