import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:todo_list/domain/tasks/status.dart';
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

  Stream<List<Task>> fetchFilteredTasks(Status status) async* {
    yield* fetchTasks()
      .map((tasks) => tasks
      .map((task) => task)
      .where((task) => task.status == status)
      .toList());
  }

  Stream<List<Task>> fetchSearchedTasks(String search) async* {
    yield* fetchTasks()
        .map((tasks) => tasks
        .map((task) => task)
        .where((task) =>
          (task.name.contains(search) || task.body.contains(search)))
        .toList());
  }

  Future<void> create(Task task) async {
    final currentTasksJson = await _prefs.getStringList(tasksKey);
    await _prefs.setStringList(tasksKey, [...?currentTasksJson, jsonEncode(task.toJson())]);
  }

  Future<void> update(Task task) async {
    var tasks = _convertToTasks(await _prefs.getStringList(tasksKey));
    tasks[tasks.indexWhere((element) => element.id == task.id)] = task;
    await _prefs.setStringList(tasksKey, _convertToListOfJson(tasks));
  }
  
  Future<void> delete(Task task) async {
    var tasks = _convertToTasks(await _prefs.getStringList(tasksKey));
    tasks.remove(task);
    await _prefs.setStringList(tasksKey, _convertToListOfJson(tasks));
  }
}

List<Task> _convertToTasks(List<String>? listJson) =>
  (listJson ?? []).map((taskData) =>
    Task.fromJson(jsonDecode(taskData))).toList();

List<String> _convertToListOfJson(List<Task> tasks) =>
    tasks.map((task) => jsonEncode(task.toJson())).toList();