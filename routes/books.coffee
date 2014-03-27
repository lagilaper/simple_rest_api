mongo = require 'mongoskin'
db = mongo.db 'mongodb://127.0.0.1:27017/test?auto_reconnect'
 
db.bind 'books'
 
db.books.find().toArray (err, items) ->
  if err
    console.log 'db error. no books collections exists'
  else
    console.log 'db connected with items : ', items
 
exports.findById = (req, res) ->
  id = req.params.id
  db.books.findOne {_id : id.toString}, (err, item) ->
    if err
      console.log 'db error : ', err
      res.send err
    else
      console.log 'book found : ', item
      res.send(item)
 
exports.findAll = (req, res) ->
  db.books.find().toArray (err, items) ->
    if err
      console.log 'db error : ', err
      res.send err
    else
      res.send(items)
 
exports.addBook = (req, res) ->
  book = req.body
  console.log 'add book : ', book
  db.books.insert book, (err, result) ->
    if err
      console.log 'db error : ', err
      res.send err
    else
      console.log 'success : ', result[0]
      res.send result[0]
 
exports.delBook = (req, res) ->
  id = req.params.id
  db.books.removeById id, (err,result) ->
    if err
      res.send 'error deleting : ' + err
    else
      res.send ' ' + result + 'removed'
 
exports.updateBook = (req, res) ->
  id = req.params.id
  book = req.body
  db.books.update {_id : id.toString}, book, (err, result) ->
    if err
      console.log 'db error : ', err
      res.send err
    else
      console.log ' ' + result + 'updated'
      res.send ' ' + result + 'updated'