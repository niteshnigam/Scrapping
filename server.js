var http = require('http');
var app = require('./app');

var port = process.env.PORT || 5000;

var server = http.createServer(app);

server.listen(port);

server.on('listening', () => {
    console.log(`Listening to port ${port}`);
})

server.on('error', err => {
    console.error(err)
})