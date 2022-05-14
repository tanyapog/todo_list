import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/domain/tasks/task.dart';
import 'package:todo_list/presentation/routes/router.gr.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  const TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AutoRouter.of(context).push(TaskFormRoute(task: task)),
      child: Card(
        elevation: 5,
        child: ListTile(
          title: Text(task.name),
          subtitle: Text(task.body, overflow: TextOverflow.ellipsis),
          isThreeLine: (task.body.length > 50),
        ),
      ),
    );
  }
}
