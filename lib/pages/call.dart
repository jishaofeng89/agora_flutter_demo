import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';

class CallPage extends StatefulWidget {

  final String channelName;

  CallPage({Key key, this.channelName}) : super(key: key);

  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {

  static final _users = List<int>();
  final _messages = <String>[];
  bool muted = false;

  void _initAgoraRtcEngine() {
    AgoraRtcEngine.create("140e572f7a4a4bcaa359155b2a9ccec0");
    AgoraRtcEngine.enableAudio();
  }

  void _addAgoraEventHandlers() {
    // 暂时先不处理
    AgoraRtcEngine.onError = (dynamic code) {
      setState(() {
       String message = 'onError: ' + code.toString();
       _messages.add(message); 
      });
    };

    AgoraRtcEngine.onJoinChannelSuccess = (String channel, int uid, int elapsed) {
      setState(() {
       String message = 'onJoinChannel: ' + channel + ', uid: ' + uid.toString();
       _messages.add(message);
      });
    };

    AgoraRtcEngine.onLeaveChannel = () {
      setState(() {
       _messages.add('onLeaveChannel');
       _users.clear(); 
      });
    };

    AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {
      setState(() {
        String message = 'userJoined: ' + uid.toString();
        _messages.add(message);
       _users.add(uid); 
      });
    };

    AgoraRtcEngine.onUserOffline = (int uid, int reason) {
      setState(() {
        String message = 'userOffline: ' + uid.toString();
        _messages.add(message);
        _users.remove(uid); 
      });
    };

    AgoraRtcEngine.onFirstRemoteVideoFrame = (int uid, int width, int height, int elapse) {
      setState(() {
       String message = 'firstRemoteVideo: ' + 
        uid.toString() + 
        '' + 
        width.toString() + 
        'x' + 
        height.toString();
        _messages.add(message); 
      });
    };
  }

  void initAgora() {
    _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    AgoraRtcEngine.enableWebSdkInteroperability(true);
    // 参数不能少
    AgoraRtcEngine.setParameters('{\"che.video.lowBitRateStreamParameter\":{\"width\":320,\"height\":180,\"frameRate\":15,\"bitRate\":140}}');
    AgoraRtcEngine.joinChannel(null, widget.channelName, null, 0);
  }

  @override
  void initState() { 
    super.initState();
    initAgora();
  }

  List<Widget> _getRenderViews() {
    List<Widget> list = [AgoraRenderWidget(0, local: true, preview: true)];
    
    _users.forEach((int uid) {
      list.add(AgoraRenderWidget(uid));
    });

    return list;
  }

  Widget _videoView(view) {
    return Expanded(
      child: Container(
        child: view,
      ),
    );
  }

  Widget _expandedVideoRow(List<Widget> views) {
    List<Widget> wrappedViews = views.map((Widget view) {
      return _videoView(view);
    }).toList();

    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  Widget _viewRows() {
    List<Widget> views = _getRenderViews();
    switch(views.length) {
      case 1:
      return Container(
        child: Column(
          children: <Widget>[_videoView(views[0])],
        ),
      );
      case 2:
      return Container(
        child: Column(
          children: <Widget>[
            _expandedVideoRow([views[0]]),
            _expandedVideoRow([views[1]]),
          ],
        ),
      );
      case 3:
      return Container(
        child: Column(
          children: <Widget>[
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 3))
          ],
        ),
      );
      case 4:
      return Container(
        child: Column(
          children: <Widget>[
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 4))
          ],
        ),
      );
      default:
      return Container();
    }
  }

  Widget _panel() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 48),
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: 0.5,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 48),
          child: ListView.builder(
            reverse: true,
            itemCount: _messages.length,
            itemBuilder: (BuildContext context, int index) {
              if (_messages.length == 0) {
                return null;
              }
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.yellowAccent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          _messages[index],
                          style: TextStyle(color: Colors.blueGrey),
                          ),
                      ),
                    ),
                  ],
                ),
              );
            }
          ),
        ),
      ),
    );
  }

  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: () {
              _onToggleMute();
            },
            child: Icon(
              muted ? Icons.mic: Icons.mic_off,
              color: muted ? Colors.white: Colors.blueAccent,
              size: 20,
            ),
            shape: CircleBorder(),
            elevation: 2,
            fillColor: muted ? Colors.blueAccent: Colors.white,
            padding: EdgeInsets.all(12),
          ),
          RawMaterialButton(
            onPressed: () {
              _onCallEnd(context);
            },
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: EdgeInsets.all(15),
          ),
          RawMaterialButton(
            onPressed: () {
              _onSwitchCamera();
            },
            child: Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20,
            ),
            shape: CircleBorder(),
            elevation: 2,
            fillColor: Colors.white,
            padding: EdgeInsets.all(12),
          ),
        ],
      ),
    );
  }

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  void _onToggleMute() {
    setState(() {
     muted = !muted; 
    });
    AgoraRtcEngine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    AgoraRtcEngine.switchCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Stack(
          children: <Widget>[
            _viewRows(),
            _panel(),
            _toolbar(),
          ],
        ),
      ),
    );
  }
}