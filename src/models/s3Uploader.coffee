
AWS = require( 'aws-sdk' )

window.AWS = AWS
s3  = new AWS.S3()


module.exports = (Backbone) ->
	class S3Uploader extends Backbone.Model
		initialize: ({ @blob, @title }) ->
			console.log arguments, 'uploading to server...'
			$.ajax
				url: '/upload'
				type: 'POST'
				data: @_formData()
				processData: false
				done: ->
					console.log "upload done", arguments

		_formData: (fields) =>
			fd = new FormData()
			fd.append( 'file', @blob.data ? @blob )
			fd

	

