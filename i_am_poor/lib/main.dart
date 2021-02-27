import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text('I Am Poor'),
            ),
            backgroundColor: Colors.brown[900],
          ),
          backgroundColor: Colors.brown[300],
          body: Center(
            child: Image(
              image: AssetImage('images/poor.png'),
            ),
          ),
        ),
      ),
    );
