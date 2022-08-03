part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class AddTask extends TaskEvent {
  final Task task;

  AddTask({required this.task});

  @override
  List<Object> get props => [task];
}

class TaskProgress extends TaskEvent {
  final Task task;

  TaskProgress({required this.task});

  @override
  List<Object> get props => [task];
}

class RemoveTask extends TaskEvent {
  final Task task;

  RemoveTask({required this.task});

  @override
  List<Object> get props => [task];
}

class RemovedTasks extends TaskEvent {
  final Task task;

  RemovedTasks({required this.task});

  @override
  List<Object> get props => [task];
}

class PermDelAllTasks extends TaskEvent {}

class RestoreTask extends TaskEvent {
  final Task task;

  RestoreTask({required this.task});

  @override
  List<Object> get props => [];
}
