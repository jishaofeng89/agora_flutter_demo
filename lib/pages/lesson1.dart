import 'package:flutter/material.dart';

class Lession1Page extends StatefulWidget {
  Lession1Page({Key key}) : super(key: key);

  @override
  _Lession1PageState createState() => _Lession1PageState();
}

class _Lession1PageState extends State<Lession1Page> {

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