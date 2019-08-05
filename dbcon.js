var mysql = require('mysql');
var pool = mysql.createPool({
  connectionLimit : 10,
  host            : 'classmysql.engr.oregonstate.edu',
  user            : 'cs340_tsengt',
  password        : '8512',
  database        : 'cs340_tsengt'
});

module.exports.pool = pool;
