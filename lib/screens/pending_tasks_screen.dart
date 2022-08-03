import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../task_bloc/task_bloc.dart';
import '../test_data.dart';
import '../widgets/tasks_list.dart';

class PendingTasksScreen extends StatelessWidget {
  const PendingTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(
                  label: Text(
                    '${state.tasksList.length} Pending | ${TestData.completedTasks.length} Completed',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TasksList(tasksList: state.tasksList),
            ],
          );
        },
      ),
    );
  }
}
