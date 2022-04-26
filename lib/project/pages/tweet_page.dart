import 'package:flutter/material.dart';

class TweetPage extends StatefulWidget {
  @override
  _TweetPageState createState() => _TweetPageState();
}

class _TweetPageState extends State<TweetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动弹'),
      ),
    );
  }
}
