README
======

This project is used to getting data from testing large request and large database IO.
I will use anemone to traverse whole website, and the data tree will created during spider traversing.
so like a dead loop never stop input data into database.

Mission
=======
1. web server (nginx, apache)
2. app server (unicorn, passenger)
3. mongodb, mysql, postgreSql
4. cache strategy
5. when deploying show maintaining page

Architecture
============

box 1: (Strong server)
Web server
App server
Mongo master

box 2: (Large memory server)
App server
Mongo slave
Redis or Memcached server

box 3:
App server
Mongo slave

Map Reduce Example
==================

map = function(){
  if(this.view_runtime < 100) {
    emit("less than 100ms" , {count: 1} );
  } else if(this.view_runtime > 100 && this.view_runtime < 500 ) {
    emit("100ms-500ms" , {count: 1} );
  } else {
    emit("over 500ms" , {count: 1} );
  }
}
reduce = function(key, values){
  var result = {count: 0};
  values.forEach(function(value) {
      result.count += value.count;
  });

  return result;
}

db.app_logs.mapReduce(map, reduce, {out: { inline : 1}});

// db.runCommand({"mapreduce" : "app_logs", "map" : map, "reduce" : reduce, "out": {inline:1}});

Commands to start mongodb
=========================

mongo