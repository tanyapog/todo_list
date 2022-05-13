import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_list/domain/tasks/task.dart';
import 'package:todo_list/infrastructure/tasks/task_repository.dart';

part 'task_form_state.dart';
part 'task_form_cubit.freezed.dart';

@injectable
class TaskFormCubit extends Cubit<TaskFormState> {
  final TaskRepository _repository;

  TaskFormCubit(this._repository) : super(TaskFormState.initial());

  Future<void> saveTask(Task task) async {
    try {
      emit(state.copyWith(isSaving: true));
      await _repository.create(task);
      emit(state.copyWith(
        task: task,
        isSaving: false,
        success: true
      ));
    } on Exception catch(e) {
      emit(state.copyWith(
        isSaving: false,
        success: false,
        errorMessage: "Fail to create new task: $e",
      ));
    }
  }
}
