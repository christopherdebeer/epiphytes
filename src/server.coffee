path = require('path')
logger = require('morgan')
express = require('express')
session = require('express-session')
favicon = require('serve-favicon')
bodyParser = require('body-parser')
errorHandler = require('errorhandler')

methodOverride = require('method-override')
s3Signer = require( './s3-signer.coffee' )

app = express()

# all environments
app.set( 'port', process.env.PORT || 3001 )
app.set( 'views', path.join(__dirname, 'views') )
app.set( 'view engine', 'jade' )
#app.use( favicon(__dirname + '../public/favicon.ico') )
app.use( logger('dev') )
app.use( methodOverride() )
app.use( session( resave: true, saveUninitialized: true, secret: 'asdfghj34*_-!@sadfg' ) )
app.use( bodyParser.json() )
app.use( bodyParser.urlencoded( { extended: true }) )


dir =  path.join( __dirname, '../public') 
app.use( express.static( dir ) )


app.get '/', (req, res) ->
	res.sendFile(  path.join dir, 'index.html' )

app.get( '/signed', s3Signer.signed )
	

# error handling middleware should be loaded after the loading the routes
if 'development' == app.get('env')
    app.use( errorHandler() )

app.listen app.get( 'port' ), ->
    console.log "__dirname: ", __dirname
    console.log('Express server listening on port ' + app.get('port'))
