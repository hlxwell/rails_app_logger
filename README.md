README
======

This project is used to getting data from testing large request and large database IO.
I will use anemone to traverse whole website, and the data tree will created during spider traversing.
so like a dead loop never stop input data into database.


Missiong
========
Test with different:
1. web server
2. app server
3. database
4. cache strategy

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