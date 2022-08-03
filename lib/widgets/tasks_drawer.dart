import 'package:bloc_finals_exam/theme_bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/theme_cubit.dart';
import '../screens/recycle_bin_screen.dart';
import '../screens/tabs_screen.dart';
import '../task_bloc/task_bloc.dart';
import '../test_data.dart';

class TasksDrawer extends StatelessWidget {
  const TasksDrawer({Key? key}) : super(key: key);

  _switchToDarkTheme(BuildContext context, bool isDarkTheme) {
    if (isDarkTheme) {
      context.read<ThemeBloc>().add(toggleOn());
    } else {
      context.read<ThemeBloc>().add(toggleOff());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              child: Text(
                'Task Drawer',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.folder_special),
              title: const Text('My Tasks'),
              trailing: Text(
                '${TestData.pendingTasks.length} | ${TestData.completedTasks.length}',
              ),
              onTap: () => Navigator.pushReplacementNamed(
                context,
                TabsScreen.path,
              ),
            ),
            const Divider(),
            BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                return ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('Recycle Bin'),
                  trailing: Text('${state.removedTasks.length}'),
                  onTap: () => Navigator.pushReplacementNamed(
                    context,
                    RecycleBinScreen.path,
                  ),
                );
              },
            ),
            const Divider(),
            const Expanded(child: SizedBox()),
            BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return ListTile(
                  leading: Switch(
                    value: state.isDarkTheme,
                    onChanged: (newValue) =>
                        _switchToDarkTheme(context, newValue),
                  ),
                  title: Text(
                    state.isDarkTheme
                        ? 'Switch to Light Theme'
                        : 'Switch to Dark Theme',
                  ),
                  onTap: () => _switchToDarkTheme(context, !state.isDarkTheme),
                );
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
