import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoeyflutter/task_data.dart';
import 'package:todoeyflutter/widgets/task_tile.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child){
        return ListView.builder(
          itemBuilder: (context, index) {
            final task = taskData.tasks[index];
            return TaskTile(
                isChecked: task.isDone,
                taskTitle: task.name,
                toggleCheckedState: (checkBoxState) {
                  taskData.changeTaskState(task);
                },
            deleteTask: (){
                  taskData.deleteTaskData(task);
            },);
          },
          itemCount: taskData.tasksCount,
        );
      }
    );
  }
}
