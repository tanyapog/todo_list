import 'package:flutter/material.dart';

class TasksOverviewPage extends StatelessWidget {
  const TasksOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todos')),
      body: const Center(
        child: Text('Tasks'),
      ),
    );
  }
}
