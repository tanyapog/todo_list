import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nanoid/nanoid.dart';
import 'package:todo_list/domain/tasks/status.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
class Task with _$Task{
  const factory Task({
    @JsonKey() required String id,
    required String name,
    required String body,
    @Default(Status.waiting) Status status,
  }) = _Task;

  factory Task.empty() => Task(
    id: nanoid(5),
    name: '',
    body: '',
  );

  factory Task.fromJson(Map<String, dynamic> json) =>
    // fromJson сгенерированный с помощью json_serializable хорош тем, что
    // красиво упаковывает enum'ы
    _$TaskFromJson(json);
}