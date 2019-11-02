//var express = require('express');//
//var app = express();
//var router = require('./router/main')(app);//근데 왜 굳이 라우터에서 받아오지 이해할 수 없다.....
//var path = require('path');
//var http = require('http');//http모듈을 추출(객체를 여기에 불러온다는 의미인 듯)
//var fs = require('fs');//fs모듈을 추출(fs는 file system의 약자 파일을 읽고 쓰기 위해 필요한 모듈)
var socketio = require('socket.io');//socket.io 모듈 추출(웹 채팅을 위한 소켓을 생성하는 데 필요한 모듈)
var port = 5003;
//app.set('views', __dirname + '/views');
//app.set('view engine', 'ejs');
//app.engine('html', require('ejs').renderFile);

//var server = http.createServer();
//server.listen(port);

//app.use('/js', express.static(__dirname + '/js'));
//app.use('/css', express.static(__dirname + '/css'));

//app.use(express.static(path.join(__dirname, 'public')));

var io = socketio.listen(port);
//io.sockets객체에 connection 이벤트 연결
io.sockets.on('connection', function(socket){//클라이언트 소켓 객체를 받아옴(아마도 이게 클라이언트와 통신하는 소켓을 생성하는 과정인듯)
  socket.on('message', function(data) {//클라이언트와 통신하는 소켓이 message라는 이벤트를 받으면
    io.sockets.emit('message', data);//서버 소켓이 이벤트와 함께 받은 data를 모든 클라이언트에게 전달
  });
});
