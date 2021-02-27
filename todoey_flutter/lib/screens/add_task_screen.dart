import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoeyflutter/task_data.dart';

String newTaskTitle;

class AddTaskScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF757575),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 50.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'Add Task',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 30.0,
                ),
              ),
            ),
            TextField(
              cursorColor: Colors.lightBlueAccent,
              textAlign: TextAlign.center,
              autofocus: true,
              decoration: InputDecoration(
                focusColor: Colors.lightBlueAccent,
              ),
              onChanged: (value){
                newTaskTitle = value;
              },
            ),
            SizedBox(
              height: 30.0,
            ),
            FlatButton(
              onPressed: (){
                Provider.of<TaskData>(context, listen: false).addTaskData(newTaskTitle);
                Navigator.pop(context);
              },
              color: Colors.lightBlueAccent,
              height: 50.0,
              child: Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
