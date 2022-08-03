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
        TaskState(
          tasksList: List.from(state.tasksList)..add(event.task),
          completedTasks: state.completedTasks,
          removedTasks: state.removedTasks,
          favoriteTasks: state.favoriteTasks,
        ),
      );
    });

    on<TaskProgress>((event, emit) {
      final state = this.state;
      final task = event.task;

      List<Task> pendingTasks = state.tasksList;
      List<Task> completedTasks = state.completedTasks;

      task.isDone == true
          ? {
              completedTasks = List.from(completedTasks)..remove(task),
              pendingTasks = List.from(pendingTasks)
                ..insert(0, task.copyWith(isDone: false))
            }
          : {
              pendingTasks = List.from(pendingTasks)..remove(task),
              completedTasks = List.from(completedTasks)
                ..insert(0, task.copyWith(isDone: true))
            };

      emit(TaskState(
        tasksList: pendingTasks,
        completedTasks: completedTasks,
        favoriteTasks: state.favoriteTasks,
        removedTasks: state.removedTasks,
      ));
    });

    on<RemoveTask>((event, emit) {
      final state = this.state;

      emit(TaskState(
          tasksList: state.tasksList,
          completedTasks: state.completedTasks,
          favoriteTasks: state.favoriteTasks,
          removedTasks: List.from(state.removedTasks)..remove(event.task)));
    });

    on<RemovedTasks>((event, emit) {
      final state = this.state;

      emit(TaskState(
          tasksList: List.from(state.tasksList)..remove(event.task),
          completedTasks: List.from(state.completedTasks)..remove(event.task),
          favoriteTasks: List.from(state.favoriteTasks)..remove(event.task),
          removedTasks: List.from(state.removedTasks)
            ..add(event.task.copyWith(isDeleted: true))));
    });

    on<PermDelAllTasks>((event, emit) {});
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
