$(document). ready(function (){//자바스크립트의 onload와 동일 모든 html페이지가 화면에 뿌려지고 나서 ready안에 서술된 이벤트가 동작을 준비함
  var socket = io.connect('192.168.21.241:5003');//클라이언트 소켓이 서버 소켓에게 연결 요청
  
  socket.on('connect', function () {
	  console.log("connection");
	});
  socket.on('message', function(data){//클라이언트 소켓이 서버로 부터 message이벤트를 받으면
    var output = '';//output이라는 변수에
    output += '<div>';//리스트 형태로
    output += '<h5>' +'<strong>' + data.name + '</strong>'+'&nbsp&nbsp&nbsp&nbsp' + data.message +'</h5>';
    output += '<h6>'+ data.date +'<h6>';
    output += '</div>';
    //prependTo는 새로 들어오는 애가 위로가고 appendTo는 밑으로 감
    $(output).appendTo('#chatcontent');//밑에 content위치에 메시지 내용이 들어감
    $("#chatcontent").scrollTop($("#chatcontent")[0].scrollHeight);//새로 채팅이 오면 스크롤을 아래로
  });



  $('#myBtn').click(function(){//버튼을 클릭하면
	  function addZero(i){
		  if (i < 10){
			  i = "0" + i;
		  }
		  return i;
	  }
	
	 if($('#message').val() != ""){
		 socket.emit('message', {//클라이언트 소켓이 메시지 이벤트를 서버 소켓에 전공
			 name: $('#userName').val(),// #이 ID를 의미
			 message: $('#message').val(),//채팅 내용
			 date: addZero(new Date().getHours()).toString() + ' : ' + addZero(new Date().getMinutes()).toString()//날짜를 보냄 >> Data 객체
		 });
		 $('#message').val('');
	 }
    //console.log("log");
  });

  $('#message').on('keypress', function(e) {//대화입력창에서 키입력받기
      if(e.keyCode === 13) {//받은 키입력이 엔터이면
        e.preventDefault();//디폴트로 실행되는 이벤트를 막고
        $('#myBtn').click();//버튼을 클릭했을 때 실행되는 이벤트 똑같이 실행
        $('#message').val('');//val은 반환하거나 설정한다 여기서는 공백으로 초기화
      }
  });

});
