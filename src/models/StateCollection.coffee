
module.exports = ( Backbone, State ) ->
	class StateCollection extends Backbone.Collection
		initialize: (options)->

		model: State
		getStart: ->
			@findWhere( id: 'start' )
		getState: (state) ->
			@findWhere( id: state )
