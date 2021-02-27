import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(XylophoneApp());

class XylophoneApp extends StatelessWidget {

  Expanded buildKeys({Color color ,int soundNumber}){
    return Expanded(
      child: FlatButton(
        color: color,
        onPressed: () {
          final player = AudioCache();
          player.play('note$soundNumber.wav');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildKeys(color: Colors.red, soundNumber: 1),
              buildKeys(color: Colors.orange, soundNumber: 2),
              buildKeys(color: Colors.yellow, soundNumber: 3),
              buildKeys(color: Colors.green, soundNumber: 4),
              buildKeys(color: Colors.blue, soundNumber: 5),
              buildKeys(color: Colors.teal, soundNumber: 6),
              buildKeys(color: Colors.purple, soundNumber: 7),
            ],
          ),
        ),
      ),
    );
  }
}
