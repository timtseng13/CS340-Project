var express = require('express');
var mysql = require('./dbcon.js');
var bodyParser = require('body-parser');
var app = express();
var handlebars = require('express-handlebars').create({ defaultLayout: 'main' });

app.engine('handlebars', handlebars.engine);
app.use(bodyParser.urlencoded({ extended: true }));
app.set('view engine', 'handlebars');
app.set('port', process.argv[2]);
app.set('mysql', mysql);
app.use('/', express.static('public'));

app.get('/', function (req, res, next) {
    res.render('index');
});


app.use(function (req, res) {
    res.status(404);
    res.render('404');
});

app.use(function (err, req, res, next) {
    console.error(err.stack);
    res.status(500);
    res.render('500');
});

app.listen(app.get('port'), function () {
    console.log('Express started on http://localhost:' + app.get('port') + '; press Ctrl-C to terminate.');
});

app.post('/create_user', function (req, res) {

    //get data from post request
    var new_user = req.body.username

    //insert new user into database
    var mysql = req.app.get('mysql');
    var sql = "INSERT INTO users (user_id) VALUES (?)";
    var inserts = [new_user];
    sql = mysql.pool.query(sql, inserts, function (error, results, fields) {

        if (error) {

            console.log(error);

        }

    });

    alert("user added!");
    res.redirect('/create_user');

});