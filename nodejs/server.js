var io = require('socket.io')(8080);

io.on('connection', function (socket) {
	console.log('connected');

	socket.on("from_client", function(obj){
		console.log(obj);
		// Ack送信なし
	});

	socket.on("from_client_want_ack", function(obj, ack){
		console.log(obj);
		// Ack送信あり
		ack('Hello!');
	});

	socket.on('disconnect', function (socket) {
		console.log('disconnected');
	});
});

// 定期的にサーバ時間を全クライアントへ送信
var send_servertime = function() {
	var now = new Date();
	io.emit("from_server", now.toLocaleString());
	console.log(now.toLocaleString());
	setTimeout(send_servertime, 1000)
};
send_servertime();
