express = require('express')
path = require('path')
fs = require('fs')

favicon = require('serve-favicon')
logger = require('morgan')
methodOverride = require('method-override')
session = require('express-session')
bodyParser = require('body-parser')
errorHandler = require('errorhandler')
formidable = require('formidable')
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



AWS = require('aws-sdk')
AWS.config.update
    accessKeyId: 'AKIAJMBFZSOZAL4VYPWA'
    secretAccessKey: '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'

s3 = new AWS.S3()




app.post '/message/:id', (req, res) ->
    console.log "MESSAGE POST: ", req.params.id
    form = new formidable.IncomingForm()
    form.uploadDir = path.join __dirname, "../messages"
    form.keepExtensions = true;

    form.parse req, (err, fields, files) ->
        return if err or !files 
        console.log( "Uploading to s3: ", files.file )
        file = files.file

        params =
            Bucket: 'wired200'
            Key: req.params.id
            ACL: 'public-read'
            Body: fs.createReadStream( file.path )
            ContentLength: file.size

        s3.putObject params, (err, data) ->
            if err
                console.log "ERROR uploading to s3 <<<"
                console.log( err, err.stack )
            else 
                console.log( "upload to s3 done: ", data )


# error handling middleware should be loaded after the loading the routes
if 'development' == app.get('env')
    app.use( errorHandler() )

app.listen app.get( 'port' ), ->
    console.log "__dirname: ", __dirname
    console.log('Express server listening on port ' + app.get('port'))
