import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_list/domain/tasks/task.dart';
import 'package:todo_list/infrastructure/tasks/task_repository.dart';

part 'task_watcher_event.dart';
part 'task_watcher_state.dart';
part 'task_watcher_bloc.freezed.dart';

@injectable
class TaskWatcherBloc extends Bloc<TaskWatcherEvent, TaskWatcherState> {
  final TaskRepository _repository;

  TaskWatcherBloc(this._repository) : super(const TaskWatcherState.loading()) {
    on<TaskWatcherEvent>(
      (event, emit) async {
        emit(const TaskWatcherState.loading());
        await emit.forEach<List<Task>>(
          _repository.fetchTasks(),
          onData: (tasks) => TaskWatcherState.success(tasks),
          onError: (e, stacktrace) => TaskWatcherState.failure("Fail to load tasks: $e"),
        );
      }
    );
  }
}
