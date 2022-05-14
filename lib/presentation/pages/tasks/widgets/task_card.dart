import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_list/presentation/pages/tasks/widgets/InheritedTask.dart';
import 'package:todo_list/presentation/pages/tasks/widgets/task_deleting_dialog.dart';
import 'package:todo_list/presentation/routes/router.gr.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final task = InheritedTask.of(context).task;
    return InkWell(
      onTap: () => AutoRouter.of(context).push(TaskFormRoute(task: task)),
      child: Slidable(
        endActionPane: _TaskActionPane(),
        child: Card(
          elevation: 5,
          child: ListTile(
            title: Text(task.name),
            subtitle: Text(task.body, overflow: TextOverflow.ellipsis),
            isThreeLine: (task.body.length > 50),
          ),
        ),
      ),
    );
  }
}

class _TaskActionPane extends ActionPane {
  _TaskActionPane({Key? key}) : super(
    key: key,
    motion: const DrawerMotion(),
    children: [const DeleteTaskAction()]
  );
}

class DeleteTaskAction extends StatelessWidget {
  const DeleteTaskAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final task = InheritedTask.of(context).task;
    return SlidableAction(
      onPressed: (context) => showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => TaskDeletingDialog(task: task,),
      ),
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
      icon: Icons.delete,
      label: 'Delete',
    );
  }
}

