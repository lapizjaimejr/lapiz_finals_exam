part of 'task_bloc.dart';

class TaskState extends Equatable {
  const TaskState({this.tasksList = const <Task>[]});

  final List<Task> tasksList;

  @override
  List<Object> get props => [tasksList];
}
