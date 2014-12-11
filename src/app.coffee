class InputController extends Backbone.Model
    initialize: ({ @player }) ->
    handleInput: (value) ->
        state = @player.get( 'state' )
        actions = state.get( 'actions' )
        @player.stop()

        if actions[value]?[0] is '#'
                  console.log "state event triggered: #{ actions[value] }"
                  @trigger( "state:#{ actions[value].substring(1) }", state )
                else
                  console.log "non function action"
                  @player.setState( actions[value] )

class AppView extends Marionette.LayoutView
    className: 'app-view'
    template: _.template """
        <div class="overlay-region"></div>
        <div class="indicator-region"></div>
        <div class="numpad-region"></div>
        <p class="reg">&copy; Wierd 200. RT023</p>
    """
    regions:
        overlayRegion: '.overlay-region'
        indicatorRegion: '.indicator-region'
        numpadRegion: '.numpad-region'

    initialize: ({ states }) ->
        @player = new Player( { states } )
        @audioRecorder = new AudioRecorder()
        @inputController = new InputController( player: @player )

        @introView = new IntroView()
        @indicatorView = new IndicatorView( audioRecorder: @audioRecorder )
        @numpadView = new NumpadView()



        @listenTo @audioRecorder, 'webaudio:ok', =>
            console.log "web audio gotten!!!"
            @introView.enableProceed()

        @listenTo @introView, 'close', ->
            @introView.destroy()

        @listenTo @numpadView, 'end', => @player.setState( '' )
        @listenTo @numpadView, 'press', (value) => @inputController.handleInput( value )
        @listenTo @numpadView, 'done:ring', => @player.setState( 'start' )

        @listenTo @inputController, 'state:startRecordingAudio', (state) =>
            console.log "processing audio record event for state: ", state
            @audioRecorder.startRecording()

        @listenTo @inputController, 'state:submitRecordedAudio', (state) =>
            console.log "processing submit audio event for state: ", state
            @listenToOnce @audioRecorder, 'webaudio:done', ({blob, url}) =>
                console.log "recording done: ", blob, url
                @player.next()
            @audioRecorder.stopRecording()

    onShow: ->
        @overlayRegion.show( @introView )
        @numpadRegion.show( @numpadView )
        @indicatorRegion.show( @indicatorView )
    
    onClose: ->
        @player.stop()




Recorder = require( './recorder.js' )

AudioRecorder = require( './models/AudioRecorder.coffee' )( Backbone, Recorder )
Player = require( './models/Player.coffee' )( Backbone )
Sound = require( './models/Sound.coffee' )( Backbone, Howl )
State = require( './models/State.coffee' )( Backbone, Sound )
StateCollection = require( './models/StateCollection.coffee' )( Backbone, State )

IntroView = require( './views/IntroView.coffee' )( Marionette )
IndicatorView = require( './views/IndicatorView.coffee' )( Marionette )
NumpadView = require( './views/NumpadView.coffee' )( Marionette, Sound )

states = new StateCollection( _.values( window.RT023_ASSETS ) )

appRegion = new Marionette.Region( el: $('body')[0] )
window.appView = appView = new AppView( states: states )

window.RT023_term_override =
    setState: (state) -> appView.player.setState( state )
    getStates: -> states

$ -> appRegion.show( appView )





