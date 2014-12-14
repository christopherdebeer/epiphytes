path = require('path')
logger = require('morgan')
express = require('express')
session = require('express-session')
favicon = require('serve-favicon')
bodyParser = require('body-parser')
errorHandler = require('errorhandler')

multipart = require('connect-multiparty')
methodOverride = require('method-override')
s3Signer = require( './s3-signer.coffee' )
uploader = require('express-fileuploader')
S3Strategy = require('express-fileuploader-s3')
AWS = require( 'aws-sdk' )
s3  = new AWS.S3()
config = require( './config.coffee' )

app = express()

# all environments
app.set( 'port', process.env.PORT || 3001 )
app.set( 'views', path.join(__dirname, 'views') )
app.set( 'view engine', 'jade' )
#app.use( favicon(__dirname + '../public/favicon.ico') )
app.use( logger('dev') )

# app.use( bodyParser.json({limit: '50mb'}) )
# app.use( bodyParser.urlencoded({limit: '50mb', extended: true}) )

dir =  path.join( __dirname, '../public') 

app.get '/', (req, res) ->
    res.sendFile(  path.join dir, 'index.html' )

app.get( '/signed', s3Signer.signed )

app.use('/upload', multipart())
app.use( express.static( dir ) )

uploader.use new S3Strategy(
    uploadPath: '/uploads'
    headers:
        'x-amz-acl': 'public-read'
    options:
        key: config.aws_key
        secret: config.aws_secret
        bucket: config.aws_bucket
)

app.post '/upload', (req, res, next) ->
    console.log req
    uploader.upload 's3', req.files['blob'], (err, files) ->
        return next( err ) if err 
        res.send( JSON.stringify(files) )

# error handling middleware should be loaded after the loading the routes
if 'development' == app.get('env')
    app.use( errorHandler() )

app.listen app.get( 'port' ), ->
    console.log "__dirname: ", __dirname
    console.log('Express server listening on port ' + app.get('port'))
