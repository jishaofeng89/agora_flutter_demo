import 'package:agora_flutter_demo/pages/call.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final _channelController = TextEditingController();

  onJoin() async {
    if(_channelController.text.isEmpty) {
      Fluttertoast.showToast(msg: '房间号不能为空哟');
    } else {
      await PermissionHandler().requestPermissions([
        PermissionGroup.camera,
        PermissionGroup.microphone,
      ]);

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return CallPage(channelName: _channelController.text.toString());
        }
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('agora flutter demo'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _channelController,
              decoration: InputDecoration(
                  border:
                      UnderlineInputBorder(borderSide: BorderSide(width: 1)),
                  hintText: '房间'),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child:RaisedButton(
                    onPressed: onJoin,
                    child: Text('加入'),
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                  ), 
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
