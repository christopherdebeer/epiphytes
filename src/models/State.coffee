
module.exports = (Backbone, Sound) ->
	class State extends Backbone.Model
		initialize: ({url, text, actions }) ->
			@set( 'url', url )
			@set( 'text', text )
			@set( 'actions', actions )
			@_createSound( @url )	

		getNext: ->
			@get( 'actions' )['next']

		_createSound: =>
			@set 'sound', new Sound
				urls: [ @get( 'url' ) ]
				volume: 1
