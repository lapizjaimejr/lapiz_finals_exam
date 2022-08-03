part of 'task_bloc.dart';

class TaskState extends Equatable {
  const TaskState({this.tasksList = const <Task>[]});

  final List<Task> tasksList;

  @override
  List<Object> get props => [tasksList];

  Map<String, dynamic> toMap() {
    return {
      'tasksList': tasksList.map((el) => el.toMap()).toList(),
    };
  }

  factory TaskState.fromMap(Map<String, dynamic> map) {
    return TaskState(
        tasksList:
            List<Task>.from(map['tasksList'].map((el) => Task.fromMap(el))));
  }
}
