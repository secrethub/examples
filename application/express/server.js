'use strict';

const express = require('express');

// Constants
const PORT = 8080;
const HOST = '0.0.0.0';

// App
const app = express();
app.get('/', (req, res) => {
  if((process.env.DEMO_USERNAME) && (process.env.DEMO_PASSWORD)){
    res.statusCode = 200;
    res.send('Welcome ' + process.env.DEMO_USERNAME);
  }
  else{
    res.statusCode = 500;
    res.send('not all variables are set');
  }
});

app.listen(PORT, HOST);
