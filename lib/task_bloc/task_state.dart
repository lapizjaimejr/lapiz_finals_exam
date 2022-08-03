part of 'task_bloc.dart';

class TaskState extends Equatable {
  const TaskState({
    this.tasksList = const <Task>[],
    this.completedTasks = const <Task>[],
    this.removedTasks = const <Task>[],
    this.favoriteTasks = const <Task>[],
  });

  final List<Task> tasksList;
  final List<Task> completedTasks;
  final List<Task> removedTasks;
  final List<Task> favoriteTasks;

  @override
  List<Object> get props => [
        tasksList,
        completedTasks,
        removedTasks,
        favoriteTasks,
      ];

  Map<String, dynamic> toMap() {
    return {
      'tasksList': tasksList.map((el) => el.toMap()).toList(),
      'completedTasks': completedTasks.map((el) => el.toMap()).toList(),
      'removedTasks': removedTasks.map((el) => el.toMap()).toList(),
      'favoriteTasks': favoriteTasks.map((el) => el.toMap()).toList(),
    };
  }

  factory TaskState.fromMap(Map<String, dynamic> map) {
    return TaskState(
      tasksList:
          List<Task>.from(map['tasksList'].map((el) => Task.fromMap(el))),
      completedTasks:
          List<Task>.from(map['completedTasks'].map((el) => Task.fromMap(el))),
      removedTasks:
          List<Task>.from(map['removedTasks'].map((el) => Task.fromMap(el))),
      favoriteTasks:
          List<Task>.from(map['favoriteTasks'].map((el) => Task.fromMap(el))),
    );
  }
}
