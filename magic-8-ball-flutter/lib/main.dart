import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MaterialApp(
      home: BallPage(),
    ));

class BallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Center(
          child: Text('Ask Me Anything'),
        ),
      ),
      backgroundColor: Colors.blue,
      body: Ball(),
    );
  }
}

class Ball extends StatefulWidget {
  @override
  _BallState createState() => _BallState();
}

class _BallState extends State<Ball> {
  int ballNumber = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: FlatButton(
            onPressed: (){
              changeBallFace();
            },
            child: Image.asset('images/ball$ballNumber.png'),
          ),
        ),
      ],
    );
  }
  void changeBallFace(){
    setState(() {
      ballNumber = Random().nextInt(4) + 1;
    });
  }

}
