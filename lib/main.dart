import 'package:bloc_finals_exam/task_bloc/task_bloc.dart';
import 'package:bloc_finals_exam/theme_bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'app_router.dart';
import 'app_themes.dart';
import 'screens/tabs_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationSupportDirectory());

  HydratedBlocOverrides.runZoned(
    () => runApp(
      MyApp(appRouter: AppRouter()),
    ),
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(create: (context) => TaskBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'BloC Tasks App',
            theme: state.isDarkTheme
                ? AppThemes.appThemeData[AppTheme.darkMode]
                : AppThemes.appThemeData[AppTheme.lightMode],
            home: const TabsScreen(),
            onGenerateRoute: appRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
