module.exports = (Backbone) ->
	class S3Uploader extends Backbone.Model
		initialize: ({ @blob, @title }) ->
			@_getSigned()

		_upload: (data, status, xhr) =>
			console.log arguments, 'uploading to s3...'
			$.ajax
				url: data.url
				type: 'PUT'
				data: @_formData( data.fields )
				processData: false
				done: ->
					console.log "upload done", arguments
	
		_getSigned: =>
			$.ajax
				url: "/signed?title=#{ @title }"
				dataType: 'json'
				type: 'GET'
				success: @_upload

		_formData: (fields) =>
			fd = new FormData()
			for fieldName, fieldValue of fields
				fd.append( fieldName, fieldValue )
			fd.append( 'file', @blob.data ? @blob )
			fd

	

