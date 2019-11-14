import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

class Lession2Page extends StatefulWidget {

  // 我这里定义为ConversationId
  final String conversationId;

  Lession2Page({Key key, this.conversationId}) : super(key: key);

  @override
  _Lession2PageState createState() => _Lession2PageState();
}

class _Lession2PageState extends State<Lession2Page> {

  void _initAgoraRtcEngine() {
    AgoraRtcEngine.create("140e572f7a4a4bcaa359155b2a9ccec0");
    AgoraRtcEngine.enableVideo();
  }

  void _addAgoraEventHandlers() {

    AgoraRtcEngine.onError = (dynamic code) {};

    AgoraRtcEngine.onJoinChannelSuccess = (String channel, int uid, int elapsed) {};

    AgoraRtcEngine.onLeaveChannel = () {};

    AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {};

    AgoraRtcEngine.onUserOffline = (int uid, int reason) {};

    AgoraRtcEngine.onFirstRemoteVideoFrame = (int uid, int width, int height, int elapse) {};
    
  }

  void initAgora() {
    _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    // 支持web端的交互吧
    AgoraRtcEngine.enableWebSdkInteroperability(false);
    AgoraRtcEngine.setParameters('{\"che.video.lowBitRateStreamParameter\":{\"width\":320,\"height\":180,\"frameRate\":15,\"bitRate\":140}}');
    AgoraRtcEngine.joinChannel(null, widget.conversationId, null, 0);
  }

  @override
  void initState() { 
    super.initState();
    initAgora();
  }

  // 最里面的通话的视图
  Widget _viewRows() {
    return Container(
      color: Colors.green,
    );
  }

  // 右上角通话的小窗口
  Widget _smallWindow() {
    // GestureDetector跟随child大小
    return GestureDetector(
      onDoubleTap: () {},
      onTap: () {},
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          color: Colors.red,
          width: 110,
          height: 150,
          margin: EdgeInsets.only(top: 40, right: 40),
        ),
      ),
    );
  }

  // 消息列表
  Widget _panel() {
    return Container();
  }

  // 挂断，静音等工具栏
  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      // 距离底部的距离
      padding: EdgeInsets.only(bottom: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: () {},
            child: Icon(
              Icons.mic_off,
              color: Colors.blueAccent,
              size: 20,
            ),
            shape: CircleBorder(),
            elevation: 2,
            fillColor: Colors.white,
            // 在这个圆形的形状里面相当于直径
            padding: EdgeInsets.all(12),
          ),
          RawMaterialButton(
            onPressed: () {
              Navigator.of(context).pop();
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
            onPressed: () {},
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('1.布局'),
      // ),
      body: Center(
        child: Stack(
          children: <Widget>[
            _viewRows(),
            _smallWindow(),
            _toolbar(),
          ],
        ),
      ),
    );
  }
}