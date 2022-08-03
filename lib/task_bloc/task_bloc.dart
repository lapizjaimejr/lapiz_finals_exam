import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskState()) {
    on<AddTask>(onAddTask);
    on<TaskProgress>(onTaskProgress);
    on<RemoveTask>(onRemoveTask);
  }

  void onAddTask(AddTask event, Emitter<TaskState> emit) {
    final state = this.state;

    emit(TaskState(tasksList: List.from(state.tasksList)..add(event.task)));
  }

  void onTaskProgress(TaskProgress event, Emitter<TaskState> emit) {}

  void onRemoveTask(RemoveTask event, Emitter<TaskState> emit) {}
}
