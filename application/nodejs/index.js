var http = require('http');

http.createServer(function (req, res) {
  if((process.env.DEMO_USERNAME) && (process.env.DEMO_PASSWORD)){
    res.writeHead(200, {'Content-Type': 'text/plain'});
    res.end('Welcome ' + process.env.DEMO_USERNAME);
  }
  else{
    res.writeHead(500, {'Content-Type': 'text/plain'});
    res.end('not all variables are set');
  }
}).listen(8080);
