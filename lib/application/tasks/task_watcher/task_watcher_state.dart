part of 'task_watcher_bloc.dart';

@freezed
class TaskWatcherState with _$TaskWatcherState {
  const factory TaskWatcherState.loading() = Loading;
  const factory TaskWatcherState.success(List<Task> tasks) = Success;
  const factory TaskWatcherState.failure(String message) = Failure;
}
