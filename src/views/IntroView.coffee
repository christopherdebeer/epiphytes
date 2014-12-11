module.exports = (Marionette) ->
    class IntroView extends Marionette.ItemView
        className: 'intro-view'
        template: _.template """
            <h3>FeedbackLoop Terminal</h3>
            <p>Made with <span class="heart">&#10084;</span>, in celebration of the Wired.co.uk podcast's 200th episode.</p>
            <p>We recommend headphones, and allowing your browser to access your microphone.</p>
            <p>When you're ready, press the <span class="redial">R (MEM)</span> button to start.</p>
            <button class="ok">Continue</button>
            <em>* Microphone access required to continue.</em>
        """
        events:
            'click .ok': "_handleClickOk"

        initialize: ->
            @audioOk = false

        enableProceed: ->
            @$el.addClass "ok"
            @audioOk = true

        _handleClickOk: =>
            @trigger( 'close' ) if @audioOk
