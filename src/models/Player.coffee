
module.exports = (Backbone) ->
	class Player extends Backbone.Model
		defaults:
			state: null
			states: null
		initialize: ({@states}) ->						
			@set( 'state', null )
			@on 'change:state', @_handleChangeState
			@set( 'state', @states.getStart() )

		play: ->
			state = @get( 'state' )
			console.log "playing state: ", state.get( 'id' )
			console.log "available actions: ", state.get( 'actions' )
			state.get( 'sound' )?.play()

		stop: ->
			@get( 'state' )?.get( 'sound' )?.stop()

		next: ->
			nextState = @get( 'state' )?.getNext()
			@setState( nextState ) if nextState
			
		setState: (state) ->
			if @states.getState( state )
				@stop()
				@set( 'state', @states.getState( state ) )
			else
				@set( 'state', @states.getState( 'nosuchstateasset' ) )
			@play()

		_handleChangeState: ->
			console.log "handle change state?", arguments
