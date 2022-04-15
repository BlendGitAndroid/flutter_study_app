import 'package:flutter/material.dart';

void main() => runApp(IconButtonApp());

class IconButtonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Icon and Button'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.person),
              SizedBox(
                height: 10.0,
              ),
              IconButton(icon: Icon(Icons.error), onPressed: () {}),
              Container(
                height: 10.0,
                color: Colors.blue,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('ElevatedButton'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
