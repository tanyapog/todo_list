import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/application/tasks/task_watcher/filtering_strategy/task_status_filter.dart';
import 'package:todo_list/application/tasks/task_watcher/task_watcher_bloc.dart';
import 'package:todo_list/injection.dart';
import 'package:todo_list/presentation/pages/tasks/widgets/InheritedTask.dart';
import 'package:todo_list/presentation/pages/tasks/widgets/filter_button.dart';
import 'package:todo_list/presentation/pages/tasks/widgets/sign_out_button.dart';
import 'package:todo_list/presentation/pages/tasks/widgets/task_card.dart';
import 'package:todo_list/presentation/routes/router.gr.dart';

class TasksOverviewPage extends StatelessWidget {
  const TasksOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TaskWatcherBloc>()
        ..add(const TaskWatcherEvent.watch(TaskStatusFilter.all)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todos'),
          actions: const [FilterButton(), SignOutButton(),],
        ),
        body: const _TasksOverview(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => AutoRouter.of(context).push(TaskFormRoute()),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class _TasksOverview extends StatelessWidget {
  const _TasksOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskWatcherBloc, TaskWatcherState>(
      builder: (context, state) {
        return state.map(
          loading: (_) => const Center(child: CircularProgressIndicator()),
          success: (state) => Padding(
            padding: const EdgeInsets.all(3.0),
            child: ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, i) => InheritedTask(
                task: state.tasks[i],
                child: const TaskCard(),
              ),
            ),
          ),
          failure: (state) => Center(child: Text(state.message)),
        );
      },
    );
  }
}
