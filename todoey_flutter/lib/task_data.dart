import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'tasks.dart';
import 'dart:collection';

class TaskData extends ChangeNotifier{

  List<Tasks> _taskList = [
    Tasks(name: "Buy Milk"),
    Tasks(name: "Buy Jam"),
    Tasks(name: "Buy Eggs"),
  ];

  int get tasksCount{
    return _taskList.length;
  }

  UnmodifiableListView<Tasks> get tasks{
    return UnmodifiableListView(_taskList);
  }

  void addTaskData(String newTaskName){
    _taskList.add(Tasks(name: newTaskName));
    notifyListeners();
  }
  void deleteTaskData(Tasks tasks){
    _taskList.remove(tasks);
    notifyListeners();
  }
  void changeTaskState(Tasks tasks){
    tasks.toggleDone();
    notifyListeners();
  }
}