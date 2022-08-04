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

class EditTask extends TaskEvent {
  final Task oldTask;
  final Task editedTask;

  EditTask({required this.oldTask, required this.editedTask});

  @override
  List<Object> get props => [oldTask, editedTask];
}

class CompleteTask extends TaskEvent {
  final Task task;

  CompleteTask({required this.task});

  @override
  List<Object> get props => [task];
}

class UncompleteTask extends TaskEvent {
  final Task task;

  UncompleteTask({required this.task});

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

class AddToFavorites extends TaskEvent {
  final Task task;

  AddToFavorites({required this.task});

  @override
  List<Object> get props => [];
}

class RemoveFromFavorites extends TaskEvent {
  final Task task;

  RemoveFromFavorites({required this.task});

  @override
  List<Object> get props => [];
}
