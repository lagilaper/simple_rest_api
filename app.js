
/**
 * Module dependencies.
 */

var express = require('express');
require('coffee-script/register');
var routes = require('./routes');
var books = require('./routes/books');
var http = require('http');

var app = express();

// all environments
app.set('port', process.env.PORT || 3000);
app.use(express.logger('dev'));
app.use(express.json());
app.use(app.router);
// development only
if ('development' == app.get('env')) {
  app.use(express.errorHandler());
}

app.get('/', routes.index);

app.get('/books', books.findAll);
app.get('/books/:id', books.findById);
app.post('/books', books.addBook);
app.put('/books/:id', books.updateBook);
app.delete('/books/:id', books.delBook);

http.createServer(app).listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port') + ' in ' + app.settings.env + ' environments');
});
