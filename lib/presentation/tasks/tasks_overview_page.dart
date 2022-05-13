import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/application/auth/auth_bloc.dart';
import 'package:todo_list/injection.dart';
import 'package:todo_list/presentation/tasks/widgets/sign_out_button.dart';

class TasksOverviewPage extends StatelessWidget {
  const TasksOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
        actions: const [SignOutButton(),],
      ),
      body: const Center(
        child: Text('Tasks'),
      ),
    );
  }
}
