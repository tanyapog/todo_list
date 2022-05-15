import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_list/application/tasks/task_watcher/filtering_strategy/task_status_filter.dart';
import 'package:todo_list/domain/tasks/task.dart';

part 'task_watcher_event.dart';
part 'task_watcher_state.dart';
part 'task_watcher_bloc.freezed.dart';

@injectable
class TaskWatcherBloc extends Bloc<TaskWatcherEvent, TaskWatcherState> {
  TaskWatcherBloc() : super(const TaskWatcherState.loading()) {
    on<TaskWatcherEvent>(
      (event, emit) async {
        emit(const TaskWatcherState.loading());
        final strategy = event.filter.strategy();
        await emit.forEach<List<Task>>(
          strategy.doFilter(),
          onData: (tasks) => TaskWatcherState.success(tasks, event.filter),
          onError: (e, stacktrace) => TaskWatcherState.failure("Fail to load tasks: $e"),
        );
      },
      transformer: restartable(),
    );
  }
}
