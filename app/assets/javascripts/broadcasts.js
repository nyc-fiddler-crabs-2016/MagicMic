
function setupSocketComms() {
  var socket = io.connect('https://magic-mic-socket-server.herokuapp.com');

  // using single socket for RTCMultiConnection signaling
  var onMessageCallbacks = {};
  socket.on('message', function(data) {
     if (data.sender == connection.userid) return;
     if (onMessageCallbacks[data.channel]) {
         onMessageCallbacks[data.channel](data.message);
     };
  });

  // initializing RTCMultiConnection constructor.
  function initRTCMultiConnection(userid) {
     var connection = new RTCMultiConnection();
     connection.body = document.getElementById('videos-container');
     connection.channel = connection.sessionid = connection.userid = userid || connection.userid;
     connection.sdpConstraints.mandatory = {
         OfferToReceiveAudio: false,
         OfferToReceiveVideo: true
     };
     // using socket.io for signaling
     connection.openSignalingChannel = function(config) {
         var channel = config.channel || this.channel;
         onMessageCallbacks[channel] = config.onmessage;
         if (config.onopen) setTimeout(config.onopen, 1000);
         return {
             send: function(message) {
                 socket.emit('message', {
                     sender: connection.userid,
                     channel: channel,
                     message: message
                 });
             },
             channel: channel
         };
     };
     connection.onMediaError = function(error) {
         alert(JSON.stringify(error));
     };
     return connection;
  }

  // this RTCMultiConnection object is used to connect with existing users
  var connection = initRTCMultiConnection();

  connection.getExternalIceServers = false;

  connection.onstream = function(event) {
     connection.body.appendChild(event.mediaElement);

     if (connection.isInitiator == false && !connection.broadcastingConnection) {
         // "connection.broadcastingConnection" global-level object is used
         // instead of using a closure object, i.e. "privateConnection"
         // because sometimes out of browser-specific bugs, browser
         // can emit "onaddstream" event even if remote user didn't attach any stream.
         // such bugs happen often in chrome.
         // "connection.broadcastingConnection" prevents multiple initializations.

         // if current user is broadcast viewer
         // he should create a separate RTCMultiConnection object as well.
         // because node.js server can allot him other viewers for
         // remote-stream-broadcasting.
         connection.broadcastingConnection = initRTCMultiConnection(connection.userid);

         // to fix unexpected chrome/firefox bugs out of sendrecv/sendonly/etc. issues.
         connection.broadcastingConnection.onstream = function() {};

         connection.broadcastingConnection.session = connection.session;
         connection.broadcastingConnection.attachStreams.push(event.stream); // broadcast remote stream
         connection.broadcastingConnection.dontCaptureUserMedia = true;

         // forwarder should always use this!
         connection.broadcastingConnection.sdpConstraints.mandatory = {
             OfferToReceiveVideo: false,
             OfferToReceiveAudio: false
         };

         connection.broadcastingConnection.open({
             dontTransmit: true
         });
     }
  };



  // ask node.js server to look for a broadcast
  // if broadcast is available, simply join it. i.e. "join-broadcaster" event should be emitted.
  // if broadcast is absent, simply create it. i.e. "start-broadcasting" event should be fired.
  document.getElementById('open-or-join').onclick = function() {
      $(this).hide();
     var broadcastid = document.getElementById('open-or-join').dataset.room;
     console.log('id', broadcastid);
     if (broadcastid.replace(/^\s+|\s+$/g, '').length <= 0) {
         alert('Please enter broadcast-id');
         document.getElementById('broadcast-id').focus();
         return;
     }

     this.disabled = true;

     connection.session = {
         video: false,
         screen: false,
         audio: true,
         oneway: true
     };

     socket.emit('join-broadcast', {
         broadcastid: broadcastid,
         userid: connection.userid,
         typeOfStreams: connection.session
     });
  };

  // this event is emitted when a broadcast is already created.
  socket.on('join-broadcaster', function(broadcaster, typeOfStreams) {
     connection.session = typeOfStreams;
     connection.channel = connection.sessionid = broadcaster.userid;

     connection.sdpConstraints.mandatory = {
         OfferToReceiveVideo: !!connection.session.video,
         OfferToReceiveAudio: !!connection.session.audio
     };

     connection.join({
         sessionid: broadcaster.userid,
         userid: broadcaster.userid,
         extra: {},
         session: connection.session
     });
  });

  // this event is emitted when a broadcast is absent.
  socket.on('start-broadcasting', function(typeOfStreams) {
     // host i.e. sender should always use this!
     connection.sdpConstraints.mandatory = {
         OfferToReceiveVideo: false,
         OfferToReceiveAudio: false
     };
     connection.session = typeOfStreams;
     connection.open({
         dontTransmit: true
     });

     if (connection.broadcastingConnection) {
         // if new person is given the initiation/host/moderation control
         connection.broadcastingConnection.close();
         connection.broadcastingConnection = null;
     }
  });

  window.onbeforeunload = function() {
     // Firefox is weird!
     document.getElementById('open-or-join').disabled = false;
  };

}


$(document).ready(function(){
  var header = $('#broadcast-show-header');
  if (header.length > 0) {
    setupSocketComms();
  };
});


