crypto = require('crypto')
mime = require('mime')
uuid = require('node-uuid')
moment = require('moment')
config = require('./config.coffee')

mime_type = 'audio/wav'

module.exports.signed = (req, res) ->
	# JSON View for obtaining CORS policy, signature, key, redirect and mime-type
	# then signs policy as a sha1 digest
	expire = moment().utc().add('hour', 1).toJSON("YYYY-MM-DDTHH:mm:ss Z")
	file_key = uuid.v4() # Generate uuid for filename
	key = "#{ config.bucket_dir}#{ file_key }_#{ req.query.title }" 

	# Creates the JSON policy according to Amazon S3's CORS uploads specfication 
	# http://aws.amazon.com/articles/1434
	policy = JSON.stringify(
		"expiration": expire,
		  "conditions": [
		    {"bucket": config.aws_bucket},
		    ["eq", "$key", key ],
		    {"acl": "public-read"},
		    {"success_action_status": "201"},
		    ["starts-with", "$Content-Type", mime_type],
		    ["content-length-range", 0, config.max_filesize]
		  ]
		)

	# Create base64 policy
	base64policy = new Buffer(policy).toString( 'base64' )
	# Create signature
	signature = crypto.createHmac( 'sha1', config.aws_secret ).update( base64policy ).digest( 'base64' )

	# Return JSON View
	console.log 'res.json', typeof res, typeof res.json
	res.json( AWSAccessKeyId: config.aws_key, success_action_status: "200", policy: base64policy, signature: signature, key: key, contentType: mime_type )
	console.log 'res.json sent'
