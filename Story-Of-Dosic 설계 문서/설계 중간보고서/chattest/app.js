//모듈 - 기능을 쉽게 사용하고자 메소드와 속성을 미리 정의해 모아 놓은 것

var http = require('http');//http모듈을 추출(객체를 여기에 불러온다는 의미인 듯)
var fs = require('fs');//fs모듈을 추출(fs는 file system의 약자 파일을 읽고 쓰기 위해 필요한 모듈)
var socketio = require('socket.io');//socket.io 모듈 추출(웹 채팅을 위한 소켓을 생성하는 데 필요한 모듈)

//웹 서버 생성
//http모듈에서 createServer메소드를 이용하여 웹 서버 객체 생성
var server = http.createServer(function (request, response) {//첫번째 인자 request는 클라이언트로 받은 요청에 관련된 정보가 담긴 객체, response는 클라이언트에게 줄 응답에 관한 객체
  //HTMLPage.html 파일을 읽는다
  fs.readFile('HTMLPage.html', function (error, data) {//html파일 읽어오기 error는 에러 체크 시에 사용할 수 있음
      response.writeHead(200, { 'Content-Type': 'text/html' });//응답메시지 헤더 작성
      response.end(data);//응답 본문 작성, 여기서는 data 즉 읽어온 html파일이 들어간다
  });
}).listen(52273, function (){//52273포트에서 요청을 기다림
  console.log('Server Running at http://127.0.0.1:52273');//서버가 돌고 있으면, 그러니까 서버가 떠서 요청을 기다리고 있으면 콘솔에 로그로 알려줌
});

//서버 소켓 생성 및 실행
var io = socketio.listen(server);
//io.sockets객체에 connection 이벤트 연결
io.sockets.on('connection', function(socket){//클라이언트 소켓 객체를 받아옴(아마도 이게 클라이언트와 통신하는 소켓을 생성하는 과정인듯)
  socket.on('message', function(data) {//클라이언트와 통신하는 소켓이 message라는 이벤트를 받으면
    io.sockets.emit('message', data);//서버 소켓이 이벤트와 함께 받은 data를 모든 클라이언트에게 전달
  });
});
