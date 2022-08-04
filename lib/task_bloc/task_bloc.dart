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

    on<EditTask>((event, emit) {
      final state = this.state;

      if (event.oldTask.isFavorite == true) {
        state.favoriteTasks
          ..remove(event.oldTask)
          ..insert(0, event.editedTask);
      }

      emit(TaskState(
          tasksList: List.from(state.tasksList)
            ..remove(event.oldTask)
            ..insert(0, event.editedTask),
          completedTasks: state.completedTasks..remove(event.oldTask),
          removedTasks: state.removedTasks,
          favoriteTasks: state.favoriteTasks));
    });

    on<CompleteTask>((event, emit) {
      final state = this.state;

      List<Task> pendingTasks = state.tasksList;
      List<Task> completedTasks = state.completedTasks;
      List<Task> favoriteTasks = state.favoriteTasks;

      final favPos = favoriteTasks.indexOf(event.task);

      if (event.task.isFavorite == false) {
        pendingTasks = List.from(pendingTasks)..remove(event.task);
        completedTasks.insert(0, event.task.copyWith(isDone: true));
      } else {
        pendingTasks = List.from(pendingTasks)..remove(event.task);
        completedTasks.insert(0, event.task.copyWith(isDone: true));
        favoriteTasks = List.from(favoriteTasks)
          ..remove(event.task)
          ..insert(favPos, event.task.copyWith(isDone: true));
      }

      emit(TaskState(
        tasksList: pendingTasks,
        completedTasks: completedTasks,
        favoriteTasks: favoriteTasks,
        removedTasks: state.removedTasks,
      ));
    });

    on<UncompleteTask>((event, emit) {
      final state = this.state;

      List<Task> pendingTasks = state.tasksList;
      List<Task> completedTasks = state.completedTasks;
      List<Task> favoriteTasks = state.favoriteTasks;

      final favPos = favoriteTasks.indexOf(event.task);

      if (event.task.isFavorite == false) {
        completedTasks = List.from(completedTasks)..remove(event.task);
        pendingTasks = List.from(pendingTasks)
          ..insert(0, event.task.copyWith(isDone: false));
      } else {
        completedTasks = List.from(completedTasks)..remove(event.task);
        pendingTasks = List.from(pendingTasks)
          ..insert(0, event.task.copyWith(isDone: false));
        favoriteTasks = List.from(favoriteTasks)
          ..remove(event.task)
          ..insert(favPos, event.task.copyWith(isDone: false));
      }

      emit(TaskState(
        tasksList: pendingTasks,
        completedTasks: completedTasks,
        favoriteTasks: favoriteTasks,
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

    on<PermDelAllTasks>((event, emit) {
      final state = this.state;

      emit(TaskState(
        tasksList: state.tasksList,
        completedTasks: state.completedTasks,
        removedTasks: List.from(state.removedTasks)..clear(),
        favoriteTasks: state.favoriteTasks,
      ));
    });

    on<RestoreTask>((event, emit) {
      final state = this.state;

      emit(TaskState(
        tasksList: List.from(state.tasksList)
          ..insert(
              0,
              event.task.copyWith(
                  isDeleted: false, isDone: false, isFavorite: false)),
        completedTasks: state.completedTasks,
        removedTasks: List.from(state.removedTasks)..remove(event.task),
        favoriteTasks: state.favoriteTasks,
      ));
    });

    on<AddToFavorites>((event, emit) {
      final state = this.state;

      List<Task> pendingTasks = state.tasksList;
      List<Task> completedTasks = state.completedTasks;
      List<Task> favoriteTasks = state.favoriteTasks;

      final pendTaskPos = pendingTasks.indexOf(event.task);
      final compTaskPos = completedTasks.indexOf(event.task);

      if (event.task.isDone == false) {
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(pendTaskPos, event.task.copyWith(isFavorite: true));
        favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
      } else {
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(compTaskPos, event.task.copyWith(isFavorite: true));
        favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
      }

      emit(TaskState(
        tasksList: pendingTasks,
        completedTasks: completedTasks,
        favoriteTasks: favoriteTasks,
        removedTasks: state.removedTasks,
      ));
    });

    on<RemoveFromFavorites>((event, emit) {
      final state = this.state;

      List<Task> pendingTasks = state.tasksList;
      List<Task> completedTasks = state.completedTasks;
      List<Task> favoriteTasks = state.favoriteTasks;

      final pendTaskPos = pendingTasks.indexOf(event.task);
      final compTaskPos = completedTasks.indexOf(event.task);

      if (event.task.isDone == false) {
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(pendTaskPos, event.task.copyWith(isFavorite: false));
        favoriteTasks.remove(event.task);
      } else {
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(compTaskPos, event.task.copyWith(isFavorite: false));
        favoriteTasks.remove(event.task);
      }

      emit(TaskState(
        tasksList: pendingTasks,
        completedTasks: completedTasks,
        favoriteTasks: favoriteTasks,
        removedTasks: state.removedTasks,
      ));
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
