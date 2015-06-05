var app = require('express')();
var server = require('http').Server(app);
var io = require('socket.io')(server);

server.listen(1337);
console.log("==GroupInput Live Update Server==");
console.log("By Andrew Arpasi");
console.log("Running on port 1337.");


app.get('/', function (req, res) {
  res.send("Y()u 4r3 4 1337 h4xx06");
});

io.on('connection', function (socket) {
  io.sockets.emit('news', { hello: 'world' });
  socket.on('ping', function (data) {
    //console.log("Recieved Question: " + data);
    /*var json = data.substring(8);
    var code = data.substring(0,8);
    console.log("Code: " + code);*/
    console.log("Pinging clients of " + data + ".");
    io.sockets.emit(data, 'ping');
  });
  socket.on('message', function (data) {
    console.log(data);
  });
  socket.on('disconnect', function () {
    io.emit('disconnected');
  });
});