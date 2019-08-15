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
app.use(express.static('public'));

// home / index page
app.get('/', function (req, res, next) {

    res.render('index');

});

// redirect to each page and display data
app.get('/movie', function (req, res) {

    var context = {};

    mysql.pool.query('SELECT * FROM Movie', function (err, rows, fields) {

        if (err) {
			console.log('here'); 
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
            music.artist = rows[row].artist;
            music.length = rows[row].musicLength;

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
    var sql = "INSERT INTO Movie (movieTitle, genre, director, run_Time) VALUES (?, ?, ?, ?)";

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
    var sql = "INSERT INTO TV_show (showTitle, Genre, producer, episode_Count) VALUES (?, ?, ?, ?)";

    var inserts = [req.body.tv_title, req.body.tv_genre, req.body.tv_producer, req.body.tv_episode];

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

    var inserts = [req.body.game_title, req.body.game_genre, req.body.game_studio];

    sql = mysql.pool.query(sql, inserts, function (error, results, fields) {

        if (error) {

            console.log(JSON.stringify(error))
            res.write(JSON.stringify(error));
            res.end();

        }

        else {

            res.redirect('/game')
        }
    });

});

// Search by text 
app.get('/filterMovie', function (req, res) {

    var query = "SELECT movieID, movieTitle, Genre, director, run_TIME FROM Movie WHERE movieTitle = ? OR Genre = ? OR director = ? OR run_TIME = ?";
    var inserts = [req.query.keyword,req.query.keyword, req.query.keyword, req.query.keyword];
    var context = {};
    console.log(query);
    mysql.pool.query(query, inserts, function (error, results, rows, fields) {

        if (error) {

            res.write(JSON.stringify(error));
            res.end();

        }
        console.log(results);
        context.movie = results;
        console.log(context);
        res.render('updated_movie', context);

    });

});

app.get('/filterMusic', function (req, res) {

    var query = "SELECT musicID, musicName, artist, musicLength FROM Music WHERE musicName = ? OR artist = ? OR musicLength = ?";
    var inserts = [req.query.keyword, req.query.keyword, req.query.keyword];
    var context = {};
    console.log(query);
    mysql.pool.query(query, inserts, function (error, results, rows, fields) {

        if (error) {

            res.write(JSON.stringify(error));
            res.end();

        }
        console.log(results);
        context.music = results;
        console.log(context);
        res.render('updated_music', context);

    });

});

app.get('/filterTV', function (req, res) {

    var query = "SELECT showID, showTitle, Genre, producer FROM TV_show WHERE showTitle = ? OR Genre = ? OR producer = ?";
    var inserts = [req.query.keyword, req.query.keyword, req.query.keyword];
    var context = {};
    console.log(query);
    mysql.pool.query(query, inserts, function (error, results, rows, fields) {

        if (error) {

            res.write(JSON.stringify(error));
            res.end();

        }
        console.log(results);
        context.tv = results;
        console.log(context);
        res.render('updated_tv', context);

    });

});

app.get('/filterGame', function (req, res) {

    var query = "SELECT gameID, gameTitle, Genre, gameStudio FROM video_Game WHERE gameTitle = ? OR Genre = ? OR gameStudio = ?";
    var inserts = [req.query.keyword, req.query.keyword, req.query.keyword];
    var context = {};
    console.log(query);
    mysql.pool.query(query, inserts, function (error, results, rows, fields) {

        if (error) {

            res.write(JSON.stringify(error));
            res.end();

        }
        console.log(results);
        context.game = results;
        console.log(context);
        res.render('updated_game', context);

    });

});

function getMovie(res, mysql, contex, id, complete){
	var sql = "SELECT movieID, movieTitle, Genre, director, run_Time FROM Movie WHERE movieID = ?";
	var inserts = [id]; 
	mysql.pool.query(sql, inserts, function(error, results, fields){
		if(error){
			res.write(JSON.stringify(error));
			res.end();
		}
		contex.Movie = results[0]; 
		complete();
		});
}


app.get('/movie/:id', function(req, res){
		callbackCount = 0;

		var context = {};
        context.jsscripts = ["updatemovie.js"];
        var mysql = req.app.get('mysql');
        getMovie(res, mysql, context, req.params.id, complete);
		 function complete(){
            callbackCount++;
            if(callbackCount >= 1){
                res.render('update', context);
			}
		}
});


  
app.listen(app.get('port'), function () {
    console.log('Express started on http://localhost:' + app.get('port') + '; press Ctrl-C to terminate.');
});

