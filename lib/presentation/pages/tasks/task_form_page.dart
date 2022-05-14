import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todo_list/application/tasks/task_form/task_form_cubit.dart';
import 'package:todo_list/domain/tasks/task.dart';
import 'package:todo_list/injection.dart';

class TaskFormPage extends StatelessWidget {
  final Task? task;
  const TaskFormPage({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((task == null) ? 'Create new task' : 'Edit the task'),
      ),
      body: _TaskFormBody(task: task,)
    );
  }
}

class _TaskFormBody extends HookWidget {
  final Task? task;
  static final _taskFormKey = GlobalKey<FormState>();
  static final _taskFormData = <String, dynamic>{};

  const _TaskFormBody({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final bodyController = useTextEditingController();

    return BlocProvider(
      create: (context) => (task == null)
        ? getIt<TaskFormCubit>()
        : getIt<TaskFormCubit>()..init(task!),
      child: BlocBuilder<TaskFormCubit, TaskFormState>(
        buildWhen: (previous, current) =>
          previous.isSaving != current.isSaving &&
          previous.isEditing != current.isEditing,
        builder: (context, state) {
          if (state.isEditing) {
            nameController.text = state.task.name;
            bodyController.text = state.task.body;
          }
          return Form(
            key: _taskFormKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField( // name field
                    controller: nameController,
                    onSaved: (value) => _taskFormData['name'] = value,
                    validator: (value) => (value == null || value.isEmpty)
                        ? "Cannot be empty"
                        : null,
                    maxLength: 70,
                    decoration: const InputDecoration(
                      hintText: 'task name',
                      counterText: '',
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: bodyController,
                    onSaved: (value) => _taskFormData['body'] = value,
                    maxLength: 1000,
                    maxLines: 5,
                    minLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'type something here...',
                      counterText: '',
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: TextButton.styleFrom(backgroundColor: Colors.blueGrey.shade50,),
                        child: const Text("CANCEL"),),
                      const SizedBox(width: 10),
                      TextButton(
                        onPressed: () async {
                          if (_taskFormKey.currentState!.validate()) {
                            _taskFormKey.currentState?.save();
                            await context.read<TaskFormCubit>().saveTask(Task(
                              id: state.task.id, // здесь автосгенерированный id
                              name: _taskFormData['name'],
                              body: _taskFormData['body'],
                            ));
                            Navigator.of(context).pop();
                          }
                        },
                        style: TextButton.styleFrom(backgroundColor: Colors.blue,),
                        child: const Text("SAVE", style: TextStyle(color: Colors.white),),),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
