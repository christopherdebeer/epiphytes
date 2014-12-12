
module.exports = ( Backbone, Recorder ) ->
	class AudioRecorder extends Backbone.Model
		initialize: ->
			@requestAudio()

		requestAudio: ->
			try
				window.AudioContext = window.AudioContext || window.webkitAudioContext
				navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia
				window.URL = window.URL || window.webkitURL
				@audioContext = new AudioContext
			catch err
				@errorGettingUserAudio( err )
			navigator.getUserMedia( { audio: true }, @doneGettingUserAudio, @errorGettingUserAudio )

		isConnected: -> @recorder?
		doneGettingUserAudio: (stream) =>
			console.log 'recorder', @recorder
			@input = @audioContext.createMediaStreamSource( stream )
			@recorder = new Recorder( @input )
			@trigger 'webaudio:ok'

		errorGettingUserAudio: (err) ->
			console.error "unable to get audio input"
			@trigger "webaudio:error", err
			alert "No web audio support in this browser. :( sorry"

		startRecording: (el) =>
			@recorder and @recorder.record()
			console.log "recording...", this
			@trigger( 'webaudio:record' )

		stopRecording: (el) =>
			@recorder and @recorder.stop()
			console.log "stopping recording...", this
			@completeRecording()

		completeRecording: =>
			@recorder && @recorder.exportWAV (blob) =>
				@recorder.clear()
				url = URL.createObjectURL(blob)
				console.log "WAV blob:", blob.toString(), url
				@trigger( 'webaudio:done', { blob, url } )

