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
//app.use(express.static('public'));

// home / index page
app.get('/', function (req, res, next) {

    res.render('index');

});

// redirect to each page
app.get('/movie', function (req, res) {

    var context = {};

    mysql.pool.query('SELECT * FROM Movie', function (err, rows, fields) {

        if (err) {

            next(err);
            return;

        }

        console.log(req.body);
        table_data = {};
        table_data.movie = [];
        for (row in rows) {

            movie = {};
            movie.id = rows[row].movieID;
            movie.title = rows[row].movieTitle;
            movie.genre = rows[row].Genre;
            movie.director = rows[row].director;
            movie.length = rows[row].run_Time;

            table_data.movie.push(movie);

        }

        context.results = JSON.stringify(rows);
        context.data = table_data;
        res.render('movie', context);

    });

});

app.get('/music', function (req, res) {

    var context = {};

    mysql.pool.query('SELECT * FROM Music', function (err, rows, fields) {

        if (err) {

            next(err);
            return;

        }

        console.log(req.body);
        table_data = {};
        table_data.music = [];
        for (row in rows) {

            music = {};
            music.id = rows[row].musicID;
            music.title = rows[row].musicName;
            music.genre = rows[row].artist;
            music.director = rows[row].musicLength;

            table_data.music.push(music);

        }

        context.results = JSON.stringify(rows);
        context.data = table_data;
        res.render('music', context);

    });

});

app.get('/tv', function (req, res) {

    var context = {};

    mysql.pool.query('SELECT * FROM TV_show', function (err, rows, fields) {

        if (err) {

            next(err);
            return;

        }

        console.log(req.body);
        table_data = {};
        table_data.tv = [];
        for (row in rows) {

            tv = {};
            tv.id = rows[row].showID;
            tv.title = rows[row].showTitle;
            tv.genre = rows[row].Genre;
            tv.producer = rows[row].producer;
            tv.episode = rows[row].episode_Count;

            table_data.tv.push(tv);

        }

        context.results = JSON.stringify(rows);
        context.data = table_data;
        res.render('tv', context);

    });

});

app.get('/game', function (req, res) {

    var context = {};

    mysql.pool.query('SELECT * FROM video_Game', function (err, rows, fields) {

        if (err) {

            next(err);
            return;

        }

        console.log(req.body);
        table_data = {};
        table_data.game = [];
        for (row in rows) {

            game = {};
            game.id = rows[row].gameID;
            game.title = rows[row].gameTitle;
            game.genre = rows[row].Genre;
            game.studio = rows[row].gameStudio;

            table_data.game.push(game);

        }

        context.results = JSON.stringify(rows);
        context.data = table_data;
        res.render('game', context);

    });

});

// Routes for adding media into database
app.post('/movie', function (req, res) {

    console.log(req.body);
    var mysql = req.app.get('mysql');
    var sql = "INSERT INTO Movie (movieTitle, genre, director, run_time) VALUES (?, ?, ?, ?)";

    var inserts = [req.body.movie_title, req.body.movie_genre, req.body.movie_director, req.body.movie_time];

    sql = mysql.pool.query(sql, inserts, function (error, results, fields) {

        if (error) {

            console.log(JSON.stringify(error))
            res.write(JSON.stringify(error));
            res.end();

        }

        else {

            res.redirect('/movie')
        }
    });

});

app.post('/music', function (req, res) {

    console.log(req.body);
    var mysql = req.app.get('mysql');
    var sql = "INSERT INTO Music (musicName, artist, musicLength) VALUES (?, ?, ?)";

    var inserts = [req.body.music_name, req.body.music_artist, req.body.music_length];

    sql = mysql.pool.query(sql, inserts, function (error, results, fields) {

        if (error) {

            console.log(JSON.stringify(error))
            res.write(JSON.stringify(error));
            res.end();

        }

        else {

            res.redirect('/music')
        }
    });

});

app.post('/tv', function (req, res) {

    console.log(req.body);
    var mysql = req.app.get('mysql');
    var sql = "INSERT INTO TV_show (showTitle, genre, producer, episode_count) VALUES (?, ?, ?, ?)";

    var inserts = [req.body.tv_title, req.body.tv_genre, req.body.tv_producer, req.body.tv_episodes];

    sql = mysql.pool.query(sql, inserts, function (error, results, fields) {

        if (error) {

            console.log(JSON.stringify(error))
            res.write(JSON.stringify(error));
            res.end();

        }

        else {

            res.redirect('/tv')
        }
    });

});

app.post('/game', function (req, res) {

    console.log(req.body);
    var mysql = req.app.get('mysql');
    var sql = "INSERT INTO video_Game (gameTitle, Genre, gameStudio) VALUES (?, ?, ?)";

    var inserts = [req.body.game_name, req.body.game_genre, req.body.game_studio];

    sql = mysql.pool.query(sql, inserts, function (error, results, fields) {

        if (error) {

            console.log(JSON.stringify(error))
            res.write(JSON.stringify(error));
            res.end();

        }

        else {

            res.redirect('game')
        }
    });

});
  
app.listen(app.get('port'), function () {
    console.log('Express started on http://localhost:' + app.get('port') + '; press Ctrl-C to terminate.');
});

