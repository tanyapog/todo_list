import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/application/tasks/task_watcher/task_watcher_bloc.dart';
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
      body: BlocProvider(
        create: (context) => getIt<TaskWatcherBloc>()
          ..add(const TaskWatcherEvent.watchAll()),
        child: const _TasksOverview(),
      ),
    );
  }
}

class _TasksOverview extends StatelessWidget {
  const _TasksOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TaskWatcherBloc>().state;
    return state.map(
      loading: (_) => const Center(child: CircularProgressIndicator()),
      success: (state) => ListView.builder(
        itemCount: state.tasks.length,
        itemBuilder: (context, i) {
          final task = state.tasks[i];
          return ListTile(
            title: Text(task.name),
            subtitle: Text(task.body, overflow: TextOverflow.ellipsis),
            isThreeLine: true,
          );
        }
      ),
      failure: (state) => Center(child: Text(state.message)),
    );
  }
}
