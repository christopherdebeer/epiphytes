(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);throw new Error("Cannot find module '"+o+"'")}var f=n[o]={exports:{}};t[o][0].call(f.exports,function(e){var n=t[o][1][e];return s(n?n:e)},f,f.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var AppView, AudioRecorder, IndicatorView, InputController, IntroView, NumpadView, Player, Recorder, Sound, State, StateCollection, appRegion, appView, states,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

InputController = (function(_super) {
  __extends(InputController, _super);

  function InputController() {
    return InputController.__super__.constructor.apply(this, arguments);
  }

  InputController.prototype.initialize = function(_arg) {
    this.player = _arg.player;
  };

  InputController.prototype.handleInput = function(value) {
    var actions, state, _ref;
    state = this.player.get('state');
    actions = state.get('actions');
    this.player.stop();
    if (((_ref = actions[value]) != null ? _ref[0] : void 0) === '#') {
      console.log("state event triggered: " + actions[value]);
      return this.trigger("state:" + (actions[value].substring(1)), state);
    } else {
      console.log("non function action");
      return this.player.setState(actions[value]);
    }
  };

  return InputController;

})(Backbone.Model);

AppView = (function(_super) {
  __extends(AppView, _super);

  function AppView() {
    return AppView.__super__.constructor.apply(this, arguments);
  }

  AppView.prototype.className = 'app-view';

  AppView.prototype.template = _.template("<div class=\"overlay-region\"></div>\n<div class=\"indicator-region\"></div>\n<div class=\"numpad-region\"></div>\n<p class=\"reg\">&copy; Wierd 200. RT023</p>");

  AppView.prototype.regions = {
    overlayRegion: '.overlay-region',
    indicatorRegion: '.indicator-region',
    numpadRegion: '.numpad-region'
  };

  AppView.prototype.initialize = function(_arg) {
    var states;
    states = _arg.states;
    this.player = new Player({
      states: states
    });
    this.audioRecorder = new AudioRecorder();
    this.inputController = new InputController({
      player: this.player
    });
    this.introView = new IntroView();
    this.indicatorView = new IndicatorView({
      audioRecorder: this.audioRecorder
    });
    this.numpadView = new NumpadView();
    this.listenTo(this.audioRecorder, 'webaudio:ok', (function(_this) {
      return function() {
        console.log("web audio gotten!!!");
        return _this.introView.enableProceed();
      };
    })(this));
    this.listenTo(this.introView, 'close', function() {
      return this.introView.destroy();
    });
    this.listenTo(this.numpadView, 'end', (function(_this) {
      return function() {
        return _this.player.setState('');
      };
    })(this));
    this.listenTo(this.numpadView, 'press', (function(_this) {
      return function(value) {
        return _this.inputController.handleInput(value);
      };
    })(this));
    this.listenTo(this.numpadView, 'done:ring', (function(_this) {
      return function() {
        return _this.player.setState('start');
      };
    })(this));
    this.listenTo(this.inputController, 'state:startRecordingAudio', (function(_this) {
      return function(state) {
        console.log("processing audio record event for state: ", state);
        return _this.audioRecorder.startRecording();
      };
    })(this));
    return this.listenTo(this.inputController, 'state:submitRecordedAudio', (function(_this) {
      return function(state) {
        console.log("processing submit audio event for state: ", state);
        _this.listenToOnce(_this.audioRecorder, 'webaudio:done', function(_arg1) {
          var blob, url;
          blob = _arg1.blob, url = _arg1.url;
          console.log("recording done: ", blob, url);
          return _this.player.next();
        });
        return _this.audioRecorder.stopRecording();
      };
    })(this));
  };

  AppView.prototype.onShow = function() {
    this.overlayRegion.show(this.introView);
    this.numpadRegion.show(this.numpadView);
    return this.indicatorRegion.show(this.indicatorView);
  };

  AppView.prototype.onClose = function() {
    return this.player.stop();
  };

  return AppView;

})(Marionette.LayoutView);

Recorder = require('./recorder.js');

AudioRecorder = require('./models/AudioRecorder.coffee')(Backbone, Recorder);

Player = require('./models/Player.coffee')(Backbone);

Sound = require('./models/Sound.coffee')(Backbone, Howl);

State = require('./models/State.coffee')(Backbone, Sound);

StateCollection = require('./models/StateCollection.coffee')(Backbone, State);

IntroView = require('./views/IntroView.coffee')(Marionette);

IndicatorView = require('./views/IndicatorView.coffee')(Marionette);

NumpadView = require('./views/NumpadView.coffee')(Marionette, Sound);

states = new StateCollection(_.values(window.RT023_ASSETS));

appRegion = new Marionette.Region({
  el: $('body')[0]
});

window.appView = appView = new AppView({
  states: states
});

window.RT023_term_override = {
  setState: function(state) {
    return appView.player.setState(state);
  },
  getStates: function() {
    return states;
  }
};

$(function() {
  return appRegion.show(appView);
});


},{"./models/AudioRecorder.coffee":2,"./models/Player.coffee":3,"./models/Sound.coffee":4,"./models/State.coffee":5,"./models/StateCollection.coffee":6,"./recorder.js":7,"./views/IndicatorView.coffee":8,"./views/IntroView.coffee":9,"./views/NumpadView.coffee":10}],2:[function(require,module,exports){
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

module.exports = function(Backbone, Recorder) {
  var AudioRecorder;
  return AudioRecorder = (function(_super) {
    __extends(AudioRecorder, _super);

    function AudioRecorder() {
      this.completeRecording = __bind(this.completeRecording, this);
      this.stopRecording = __bind(this.stopRecording, this);
      this.startRecording = __bind(this.startRecording, this);
      this.doneGettingUserAudio = __bind(this.doneGettingUserAudio, this);
      return AudioRecorder.__super__.constructor.apply(this, arguments);
    }

    AudioRecorder.prototype.initialize = function() {
      var err;
      try {
        window.AudioContext = window.AudioContext || window.webkitAudioContext;
        navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia;
        window.URL = window.URL || window.webkitURL;
        this.audioContext = new AudioContext;
      } catch (_error) {
        err = _error;
        this.errorGettingUserAudio(err);
      }
      return navigator.getUserMedia({
        audio: true
      }, this.doneGettingUserAudio, this.errorGettingUserAudio);
    };

    AudioRecorder.prototype.doneGettingUserAudio = function(stream) {
      this.input = this.audioContext.createMediaStreamSource(stream);
      this.recorder = new Recorder(this.input);
      return this.trigger('webaudio:ok');
    };

    AudioRecorder.prototype.errorGettingUserAudio = function(err) {
      console.error("unable to get audio input");
      this.trigger("webaudio:error", err);
      return alert("No web audio support in this browser. :( sorry");
    };

    AudioRecorder.prototype.startRecording = function(el) {
      this.recorder && this.recorder.record();
      console.log("recording...", this);
      return this.trigger('webaudio:record');
    };

    AudioRecorder.prototype.stopRecording = function(el) {
      this.recorder && this.recorder.stop();
      console.log("stopping recording...", this);
      return this.completeRecording();
    };

    AudioRecorder.prototype.completeRecording = function() {
      return this.recorder && this.recorder.exportWAV((function(_this) {
        return function(blob) {
          var data, url;
          _this.recorder.clear();
          url = URL.createObjectURL(blob);
          console.log("WAV blob:", blob.toString(), url);
          data = new FormData();
          data.append('file', blob);
          _this.trigger('webaudio:done', {
            blob: blob,
            url: url
          });
          return jQuery.ajax({
            type: "POST",
            url: '/message/test',
            success: function() {
              return console.log("upload success");
            },
            data: data,
            contentType: false,
            processData: false
          });
        };
      })(this));
    };

    return AudioRecorder;

  })(Backbone.Model);
};


},{}],3:[function(require,module,exports){
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

module.exports = function(Backbone) {
  var Player;
  return Player = (function(_super) {
    __extends(Player, _super);

    function Player() {
      return Player.__super__.constructor.apply(this, arguments);
    }

    Player.prototype.defaults = {
      state: null,
      states: null
    };

    Player.prototype.initialize = function(_arg) {
      this.states = _arg.states;
      this.set('state', null);
      this.on('change:state', this._handleChangeState);
      return this.set('state', this.states.getStart());
    };

    Player.prototype.play = function() {
      var state, _ref;
      state = this.get('state');
      console.log("playing state: ", state.get('id'));
      console.log("available actions: ", state.get('actions'));
      return (_ref = state.get('sound')) != null ? _ref.play() : void 0;
    };

    Player.prototype.stop = function() {
      var _ref, _ref1;
      return (_ref = this.get('state')) != null ? (_ref1 = _ref.get('sound')) != null ? _ref1.stop() : void 0 : void 0;
    };

    Player.prototype.next = function() {
      var nextState, _ref;
      nextState = (_ref = this.get('state')) != null ? _ref.getNext() : void 0;
      if (nextState) {
        return this.setState(nextState);
      }
    };

    Player.prototype.setState = function(state) {
      if (this.states.getState(state)) {
        this.stop();
        this.set('state', this.states.getState(state));
      } else {
        this.set('state', this.states.getState('nosuchstateasset'));
      }
      return this.play();
    };

    Player.prototype._handleChangeState = function() {
      return console.log("handle change state?", arguments);
    };

    return Player;

  })(Backbone.Model);
};


},{}],4:[function(require,module,exports){
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

module.exports = function(Backbone, Howl) {
  var Sound;
  return Sound = (function(_super) {
    __extends(Sound, _super);

    function Sound() {
      this._handleOnEnd = __bind(this._handleOnEnd, this);
      return Sound.__super__.constructor.apply(this, arguments);
    }

    Sound.prototype.initialize = function(_arg) {
      var repeatDelay, sprite, urls, volume;
      urls = _arg.urls, volume = _arg.volume, sprite = _arg.sprite, repeatDelay = _arg.repeatDelay;
      return this.set('clip', new Howl({
        urls: urls,
        sprite: sprite,
        onend: this._handleOnEnd,
        volume: volume
      }));
    };

    Sound.prototype.stop = function() {
      this.get('clip').stop();
      return this;
    };

    Sound.prototype.play = function(sprite) {
      this.get('clip').play(sprite);
      return this;
    };

    Sound.prototype.then = function(cb) {
      this.onEndCallback = cb;
      return this;
    };

    Sound.prototype._handleOnEnd = function() {
      console.log("handle onend");
      if (this.get('repeatDelay')) {
        console.log("should be repeating...");
        setTimeout(((function(_this) {
          return function() {
            console.log("repeating sound", _this);
            return _this.play();
          };
        })(this)), this.repeatDelay);
      }
      return typeof this.onEndCallback === "function" ? this.onEndCallback() : void 0;
    };

    return Sound;

  })(Backbone.Model);
};


},{}],5:[function(require,module,exports){
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

module.exports = function(Backbone, Sound) {
  var State;
  return State = (function(_super) {
    __extends(State, _super);

    function State() {
      this._createSound = __bind(this._createSound, this);
      return State.__super__.constructor.apply(this, arguments);
    }

    State.prototype.initialize = function(_arg) {
      var actions, text, url;
      url = _arg.url, text = _arg.text, actions = _arg.actions;
      this.set('url', url);
      this.set('text', text);
      this.set('actions', actions);
      return this._createSound(this.url);
    };

    State.prototype.getNext = function() {
      return this.get('actions')['next'];
    };

    State.prototype._createSound = function() {
      return this.set('sound', new Sound({
        urls: [this.get('url')],
        volume: 1
      }));
    };

    return State;

  })(Backbone.Model);
};


},{}],6:[function(require,module,exports){
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

module.exports = function(Backbone, State) {
  var StateCollection;
  return StateCollection = (function(_super) {
    __extends(StateCollection, _super);

    function StateCollection() {
      return StateCollection.__super__.constructor.apply(this, arguments);
    }

    StateCollection.prototype.initialize = function(options) {};

    StateCollection.prototype.model = State;

    StateCollection.prototype.getStart = function() {
      return this.findWhere({
        id: 'start'
      });
    };

    StateCollection.prototype.getState = function(state) {
      return this.findWhere({
        id: state
      });
    };

    return StateCollection;

  })(Backbone.Collection);
};


},{}],7:[function(require,module,exports){

  var WORKER_PATH = '/recorderWorker.js';

  var Recorder = function(source, cfg){
    var config = cfg || {};
    var bufferLen = config.bufferLen || 4096;
    this.context = source.context;
    this.node = (this.context.createScriptProcessor ||
                 this.context.createJavaScriptNode).call(this.context,
                                                         bufferLen, 2, 2);
    var worker = new Worker(config.workerPath || WORKER_PATH);
    worker.postMessage({
      command: 'init',
      config: {
        sampleRate: this.context.sampleRate
      }
    });
    var recording = false,
      currCallback;

    this.node.onaudioprocess = function(e){
      if (!recording) return;
      worker.postMessage({
        command: 'record',
        buffer: [
          e.inputBuffer.getChannelData(0),
          e.inputBuffer.getChannelData(1)
        ]
      });
    }

    this.configure = function(cfg){
      for (var prop in cfg){
        if (cfg.hasOwnProperty(prop)){
          config[prop] = cfg[prop];
        }
      }
    }

    this.record = function(){
      recording = true;
    }

    this.stop = function(){
      recording = false;
    }

    this.clear = function(){
      worker.postMessage({ command: 'clear' });
    }

    this.getBuffer = function(cb) {
      currCallback = cb || config.callback;
      worker.postMessage({ command: 'getBuffer' })
    }

    this.exportWAV = function(cb, type){
      currCallback = cb || config.callback;
      type = type || config.type || 'audio/wav';
      if (!currCallback) throw new Error('Callback not set');
      worker.postMessage({
        command: 'exportWAV',
        type: type
      });
    }

    worker.onmessage = function(e){
      var blob = e.data;
      currCallback(blob);
    }

    source.connect(this.node);
    this.node.connect(this.context.destination);    //this should not be necessary
  };

  Recorder.forceDownload = function(blob, filename){
    var url = (window.URL || window.webkitURL).createObjectURL(blob);
    var link = window.document.createElement('a');
    link.href = url;
    link.download = filename || 'output.wav';
    var click = document.createEvent("Event");
    click.initEvent("click", true, true);
    link.dispatchEvent(click);
  }

  module.exports = Recorder;

},{}],8:[function(require,module,exports){
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

module.exports = function(Marionette) {
  var IndicatorView;
  return IndicatorView = (function(_super) {
    __extends(IndicatorView, _super);

    function IndicatorView() {
      this._toggle = __bind(this._toggle, this);
      return IndicatorView.__super__.constructor.apply(this, arguments);
    }

    IndicatorView.prototype.tagName = 'ol';

    IndicatorView.prototype.className = 'indicator-view';

    IndicatorView.prototype.template = _.template("<li class=\"message\">\n	<div class=\"light\"></div>\n	<div class=\"label\">Message</div>\n</li>\n<li class=\"recording\">\n	<div class=\"light\"></div>\n	<div class=\"label\">Recording</div>\n</li>");

    IndicatorView.prototype._toggle = function(cls, force) {
      return this.$(cls).toggleClass('on', force);
    };

    IndicatorView.prototype.initialize = function(_arg) {
      this.audioRecorder = _arg.audioRecorder;
      this.listenTo(this.audioRecorder, 'webaudio:record', (function(_this) {
        return function() {
          return _this.toggleRecording(true);
        };
      })(this));
      return this.listenTo(this.audioRecorder, 'webaudio:done', (function(_this) {
        return function() {
          return _this.toggleRecording(false);
        };
      })(this));
    };

    IndicatorView.prototype.toggleMessage = function(force) {
      console.log("toggle message indicator", force);
      return this._toggle('.message', force);
    };

    IndicatorView.prototype.toggleRecording = function(force) {
      console.log("toggle recording indicator", force);
      return this._toggle('.recording', force);
    };

    return IndicatorView;

  })(Marionette.ItemView);
};


},{}],9:[function(require,module,exports){
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

module.exports = function(Marionette) {
  var IntroView;
  return IntroView = (function(_super) {
    __extends(IntroView, _super);

    function IntroView() {
      this._handleClickOk = __bind(this._handleClickOk, this);
      return IntroView.__super__.constructor.apply(this, arguments);
    }

    IntroView.prototype.className = 'intro-view';

    IntroView.prototype.template = _.template("<h3>FeedbackLoop Terminal</h3>\n<p>Made with <span class=\"heart\">&#10084;</span>, in celebration of the Wired.co.uk podcast's 200th episode.</p>\n<p>We recommend headphones, and allowing your browser to access your microphone.</p>\n<p>When you're ready, press the <span class=\"redial\">R (MEM)</span> button to start.</p>\n<button class=\"ok\">Continue</button>\n<em>* Microphone access required to continue.</em>");

    IntroView.prototype.events = {
      'click .ok': "_handleClickOk"
    };

    IntroView.prototype.initialize = function() {
      return this.audioOk = false;
    };

    IntroView.prototype.enableProceed = function() {
      this.$el.addClass("ok");
      return this.audioOk = true;
    };

    IntroView.prototype._handleClickOk = function() {
      if (this.audioOk) {
        return this.trigger('close');
      }
    };

    return IntroView;

  })(Marionette.ItemView);
};


},{}],10:[function(require,module,exports){
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

module.exports = function(Marionette, Sound) {
  var NumpadView;
  return NumpadView = (function(_super) {
    __extends(NumpadView, _super);

    function NumpadView() {
      this._startCall = __bind(this._startCall, this);
      return NumpadView.__super__.constructor.apply(this, arguments);
    }

    NumpadView.prototype.tagName = 'ol';

    NumpadView.prototype.className = 'numpad-view';

    NumpadView.prototype.initialize = function() {
      this.longBeepSound = new Sound({
        urls: ['sfx/beep.mp3'],
        volume: 1
      });
      this.beepSound = new Sound({
        urls: ['sfx/beep2.mp3'],
        sprite: {
          short: [0, 100],
          medium: [0, 1500],
          long: [0, 3000]
        },
        volume: 1
      });
      this.ringSound = new Sound({
        urls: ['sfx/ringing.mp3'],
        volume: 1,
        sprite: {
          short: [0, 5000],
          medium: [0, 10000],
          long: [0, 30000]
        }
      });
      return this.clickSound = new Sound({
        urls: ['sfx/click.mp3'],
        volume: 0.5
      });
    };

    NumpadView.prototype.events = {
      'click li': '_handlePressButton',
      'click li.hang-up': '_handleHangUp'
    };

    NumpadView.prototype._handleHangUp = function() {
      this.running = false;
      return window.location.reload();
    };

    NumpadView.prototype._startCall = function() {
      console.log("startcall");
      return this.longBeepSound.play().then((function(_this) {
        return function() {
          console.log("ring");
          return _this.ringSound.play('short').then(function() {
            _this.running = true;
            return _this.trigger('done:ring');
          });
        };
      })(this));
    };

    NumpadView.prototype._handlePressButton = function(ev) {
      var $item, val;
      this.beepSound.stop();
      this.ringSound.stop();
      console.log(this.clickSound.play());
      this.beepSound.play('short');
      $item = $(ev.target);
      $item.addClass('active');
      setTimeout((function() {
        return $item.removeClass('active');
      }), 100);
      val = $item.find('.number').html();
      if (val === 'R') {
        return this._startCall();
      } else {
        if (this.running) {
          return this.trigger("press", val);
        }
      }
    };

    NumpadView.prototype.onShow = function() {};

    NumpadView.prototype.template = _.template("<li>\n	<a href=\"#\">\n		<span class=\"alpha\"></span>\n		<span class=\"number\">1</span>\n	</a>\n</li>\n<li>\n	<a href=\"#\">\n		<span class=\"alpha\">ABC</span>\n		<span class=\"number\">2</span>\n	</a>\n</li>\n<li>\n	<a href=\"#\">\n		<span class=\"alpha\">DEF</span>\n		<span class=\"number\">3</span>\n	</a>\n</li>\n<li>\n	<a href=\"#\">\n		<span class=\"alpha\">GHI</span>\n		<span class=\"number\">4</span>\n	</a>\n</li>\n<li>\n	<a href=\"#\">\n		<span class=\"alpha\">JFK</span>\n		<span class=\"number\">5</span>\n	</a>\n</li>\n<li>\n	<a href=\"#\">\n		<span class=\"alpha\">MNO</span>\n		<span class=\"number\">6</span>\n	</a>\n</li>\n<li>\n	<a href=\"#\">\n		<span class=\"alpha\">PQRS</span>\n		<span class=\"number\">7</span>\n	</a>\n</li>\n<li>\n	<a href=\"#\">\n		<span class=\"alpha\">TUV</span>\n		<span class=\"number\">8</span>\n	</a>\n</li>\n<li>\n	<a href=\"#\">\n		<span class=\"alpha\">WXYZ</span>\n		<span class=\"number\">9</span>\n	</a>\n</li>\n<li>\n	<a href=\"#\">\n		<span class=\"alpha\"></span>\n		<span class=\"number\">*</span>\n	</a>\n</li>\n<li>\n	<a href=\"#\">\n		<span class=\"alpha\">OPER</span>\n		<span class=\"number\">0</span>\n	</a>\n</li>\n<li>\n	<a href=\"#\">\n		<span class=\"alpha\"></span>\n		<span class=\"number\">#</span>\n	</a>\n</li>\n<li class=\"mem special\">\n	<a href=\"#\">\n		<span class=\"alpha\">MEM</span>\n		<span class=\"number\">R</span>\n	</a>\n</li>\n<li class=\"hang-up special\">\n	<a href=\"#\">\n		<span>Hang Up</span>\n	</a>\n</li>");

    return NumpadView;

  })(Marionette.ItemView);
};


},{}]},{},[1])