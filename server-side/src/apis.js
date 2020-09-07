const express = require('express');
const bodyParser = require('body-parser');

var app = express();

// parse body formatted in JSON
app.use(bodyParser.json());

app.get('/', (req, res) => {
    res.send('Hello Express');
});

app.get('/welcome', (req, res) => {
    res.send('Welcome to FintechSG');
});

app.get('/squared', (req, res) => {
    // JSON format
    // { "number": 2}
    number = req.body.number;
    squared = number * number;

    res.send(`Squared : ${squared}`);

    // from POSTMAN.. set Body raw content as JSON data
    // { "number": 3 }
});
app.listen(process.env.PORT || 3000);