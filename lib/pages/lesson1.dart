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
    return Container();
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
          ],
        ),
      ),
    );
  }
}