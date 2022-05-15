import 'package:todo_list/application/tasks/task_watcher/filtering_strategy/i_filtering_strategy.dart';
import 'package:todo_list/application/tasks/task_watcher/filtering_strategy/task_status_filter.dart';
import 'package:todo_list/domain/tasks/status.dart';
import 'package:todo_list/domain/tasks/task.dart';

class ShowingDoneStrategy extends IFilteringStrategy {
  @override
  String get label => filter.name;

  @override
  Stream<List<Task>> doFilter() async* {
    yield* super.repository.fetchFilteredTasks(Status.done);
  }

  @override
  TaskStatusFilter get filter => TaskStatusFilter.all;
}