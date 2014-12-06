
module.exports = (Marionette) ->
	class IndicatorView extends Marionette.ItemView
		tagName: 'ol'
		className: 'indicator-view'
		template: _.template """
			<li class="message">
				<div class="light"></div>
				<div class="label">Message</div>
			</li>
			<li class="recording">
				<div class="light"></div>
				<div class="label">Recording</div>
			</li>
		"""
		_toggle: (cls, force) =>
			@$( cls ).toggleClass( 'on', force )

		initialize: ({ @audioRecorder }) ->
			@listenTo @audioRecorder, 'webaudio:record', => @toggleRecording( true )
			@listenTo @audioRecorder, 'webaudio:done', => @toggleRecording( false )
			setTimeout( @tick, 500 )
		
		tick: =>
			els = @$el.find( '.on' )
			els.toggleClass( 'on' )
			setTimeout( ( =>
				els.toggleClass( 'on' )
				@tick()
			), 500 )
	
				
		toggleMessage: (force) ->
			console.log "toggle message indicator", force
			@_toggle( '.message', force )

		toggleRecording: (force) ->
			console.log "toggle recording indicator", force
			@_toggle( '.recording', force )
