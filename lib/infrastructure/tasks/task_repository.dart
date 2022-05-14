import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:todo_list/domain/tasks/task.dart';

@LazySingleton()
class TaskRepository {
  final RxSharedPreferences _prefs;
  static const tasksKey = "tasks";

  TaskRepository(this._prefs);

  Stream<List<Task>> fetchTasks() async* {
    yield* (_prefs.getStringListStream(tasksKey))
      .map((jsonTasks) => (jsonTasks ?? [])
      .map((taskData) => Task.fromJson(jsonDecode(taskData)))
      .toList());
  }

  Future<void> create(Task task) async {
    final currentTasksJson = await _prefs.getStringList(tasksKey);
    await _prefs.setStringList(tasksKey, [...?currentTasksJson, jsonEncode(task.toJson())]);
  }

  Future<void> update(Task task) async {
    final currentTasksJson = await _prefs.getStringList(tasksKey);

    List<Task> tasks = (currentTasksJson ?? []).map((taskData) =>
      Task.fromJson(jsonDecode(taskData))).toList();
    tasks[tasks.indexWhere((element) => element.id == task.id)] = task;

    List<String> updatedTasks = tasks.map((task) => jsonEncode(task.toJson())).toList();
    await _prefs.setStringList(tasksKey, updatedTasks);
  }
}