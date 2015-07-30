var fs = require("fs");
var pg = require('pg');
var conString = "postgres://re:re@cranberry:5432/re";
//fd = fs.openSync('commits.csv','w');

var client = new pg.Client(conString);
client.connect();
console.log('ahaaay');
console.log("connected");

client.query("drop table commit");
client.query("create table commit (name text,email text,date text,comment_count text,message text)" , function(err, result) {
    //call `done()` to release the client back to the pool
    


var commits = JSON.parse(fs.readFileSync("commits.json", "utf8"));

res = [];
Object.keys(commits).forEach(function(key) {
  // client.query("INSERT INTO commit(first, second) values('Ted',12)");
    var name=commits[key].commit.committer.name;
    var email= commits[key].commit.committer.email;
    var date= commits[key].commit.committer.date;
    var comment_count= commits[key].commit.comment_count;
    var message= 'everton';//(commits[key].commit.message).replace(/\,/g,'').replace(/\n/g,'');
    var queryText="INSERT INTO commit(name, email,date,comment_count,message) values("+name+','+email+','+date+','+comment_count+','+message+")";
    client.query(queryText);
    console.log(queryText);
});


    if(err) {
      return console.error('error running query', err);
    }
    //console.log(result.rows[0].number);
    //output: 1
    client.end();
  });


console.log("connected");


// console.log(res);
// fs.writeSync(fd, res);
// fs.closeSync(fd);
