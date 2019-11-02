import 'package:agora_flutter_demo/pages/lesson1.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List lessons = [Lession1Page()];

  final List lessonsTitle = ['1.布局'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('在你的应用中实现视频通话系列课程'),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(lessonsTitle[index]),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) {
                  return lessons[index];
                }
              ));
            },
          );
        },
        itemCount: lessons.length,
      ),
    );
  }
}