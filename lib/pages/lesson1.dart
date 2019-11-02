import 'package:flutter/material.dart';

class Lession1Page extends StatefulWidget {
  Lession1Page({Key key}) : super(key: key);

  @override
  _Lession1PageState createState() => _Lession1PageState();
}

class _Lession1PageState extends State<Lession1Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('1.布局'),
      ),
      body: Center(
        child: Text('第一课'),
      ),
    );
  }
}