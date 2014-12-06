
module.exports = (Backbone, Howl) ->
	class Sound extends Backbone.Model
		initialize: ({urls, volume, sprite, repeatDelay}) ->
			@set 'clip', new Howl
				urls: urls
				sprite: sprite
				onend: @_handleOnEnd
				volume: volume
		stop: ->
			@get( 'clip' ).stop()
			this

		play: (sprite) ->
			@get( 'clip' ).play( sprite )
			this

		then: (cb) ->
			@onEndCallback = cb
			this

		_handleOnEnd: =>
			console.log "handle onend"
			if @get 'repeatDelay'
				console.log "should be repeating..."
				setTimeout ( =>
					console.log "repeating sound", this
					@play()

				), @repeatDelay
			@onEndCallback?()
