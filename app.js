var express = require('express');
var app = express();

app.get('/express', function (req, res) {
  res.send('Hello World from App Service! Sample Node.js express application!');
});

app.get('/', function (req, res) {
  res.sendfile('hostingstart.html');
});

app.listen(process.env.PORT, function() {
  console.log('Example app listening on port process.env.PORT!');
});
