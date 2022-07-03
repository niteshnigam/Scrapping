const express = require('express');
const app = express();

const bodyParser = require('body-parser');
const cors = require('cors');

var appRoutes = require("./routes/routes");

app.use(cors());
app.use(bodyParser.json({limit: '50mb'}))

app.use('/', appRoutes);

module.exports = app;
