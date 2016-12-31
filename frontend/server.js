"use strict"

var config = require('./config/server');
var express = require('express');

var app = express();

app.use('/', express.static(__dirname + '/' + config.releaseDirectory));

app.listen(config.port);
console.log('Server is running on port ' + config.port);
