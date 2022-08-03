import 'package:bloc/bloc.dart';
import 'package:bloc_finals_exam/test_data.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../models/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends HydratedBloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskState()) {
    on<AddTask>((event, emit) {
      final state = this.state;
      emit(
        TaskState(tasksList: List.from(state.tasksList)..add(event.task)),
      );
    });

    on<TaskProgress>((event, emit) {
      final state = this.state;
      final task = event.task;
      final int taskPos = state.tasksList.indexOf(task);

      List<Task> tasksList = List.from(state.tasksList)..remove(task);

      task.isDone == true
          ? tasksList.insert(taskPos, task.copyWith(isDone: false))
          : tasksList.insert(taskPos, task.copyWith(isDone: true));

      emit(TaskState(tasksList: tasksList));
    });

    on<RemoveTask>((event, emit) {
      final state = this.state;

      emit(
          TaskState(tasksList: List.from(state.tasksList)..remove(event.task)));
    });
  }

  @override
  TaskState? fromJson(Map<String, dynamic> json) {
    return TaskState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TaskState state) {
    return state.toMap();
  }
}
