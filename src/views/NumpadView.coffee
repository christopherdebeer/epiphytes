
module.exports = (Marionette, Sound) ->
	class NumpadView extends Marionette.ItemView
		tagName: 'ol'
		className: 'numpad-view'

		initialize: ->

			@longBeepSound = new Sound
				urls: ['sfx/beep.mp3']
				volume: 1

			@beepSound = new Sound
				urls: ['sfx/beep2.mp3']
				sprite:
					short: [0, 100]
					medium: [0, 1500]
					long: [0, 3000]
				volume: 1

			@ringSound = new Sound
				urls: ['sfx/ringing.mp3']
				volume: 1
				sprite:
					short: [0, 5000]
					medium: [0, 10000]
					long: [0, 30000]
				
			@clickSound = new Sound
				urls: ['sfx/click.mp3']
				volume: 0.5

		events:
			'click li': '_handlePressButton'
			'click li.hang-up': '_handleHangUp'

		_handleHangUp: ->
			@running = false
			window.location.reload()

		_startCall: =>
			console.log "startcall"
			@longBeepSound.play().then =>
				console.log "ring"
				@ringSound.play( 'short' ).then =>
					@running = true
					@trigger( 'done:ring' )

		_handlePressButton: (ev) ->
			@beepSound.stop()
			@ringSound.stop()

			console.log @clickSound.play()
			@beepSound.play( 'short' )

			$item = $( ev.target )
			$item.addClass( 'active' )
			setTimeout ( -> $item.removeClass( 'active' ) ), 100
			val = $item.find('.number').html()
			if val is 'R'
				@_startCall()
			else
				@trigger(  "press", val ) if @running

		onShow: ->

		template: _.template """
			<li>
				<a href="#">
					<span class="alpha"></span>
					<span class="number">1</span>
				</a>
			</li>
			<li>
				<a href="#">
					<span class="alpha">ABC</span>
					<span class="number">2</span>
				</a>
			</li>
			<li>
				<a href="#">
					<span class="alpha">DEF</span>
					<span class="number">3</span>
				</a>
			</li>
			<li>
				<a href="#">
					<span class="alpha">GHI</span>
					<span class="number">4</span>
				</a>
			</li>
			<li>
				<a href="#">
					<span class="alpha">JFK</span>
					<span class="number">5</span>
				</a>
			</li>
			<li>
				<a href="#">
					<span class="alpha">MNO</span>
					<span class="number">6</span>
				</a>
			</li>
			<li>
				<a href="#">
					<span class="alpha">PQRS</span>
					<span class="number">7</span>
				</a>
			</li>
			<li>
				<a href="#">
					<span class="alpha">TUV</span>
					<span class="number">8</span>
				</a>
			</li>
			<li>
				<a href="#">
					<span class="alpha">WXYZ</span>
					<span class="number">9</span>
				</a>
			</li>
			<li>
				<a href="#">
					<span class="alpha"></span>
					<span class="number">*</span>
				</a>
			</li>
			<li>
				<a href="#">
					<span class="alpha">OPER</span>
					<span class="number">0</span>
				</a>
			</li>
			<li>
				<a href="#">
					<span class="alpha"></span>
					<span class="number">#</span>
				</a>
			</li>
			<li class="mem special">
				<a href="#">
					<span class="alpha">MEM</span>
					<span class="number">R</span>
				</a>
			</li>
			<li class="hang-up special">
				<a href="#">
					<span>Hang Up</span>
				</a>
			</li>
		"""

