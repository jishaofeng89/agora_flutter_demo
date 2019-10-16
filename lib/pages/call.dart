import 'package:flutter/material.dart';

class CallPage extends StatefulWidget {

  final String channelName;

  CallPage({Key key, this.channelName}) : super(key: key);

  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('通话界面'),
      ),
    );
  }
}