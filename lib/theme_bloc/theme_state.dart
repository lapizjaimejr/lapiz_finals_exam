part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final bool isDarkTheme;

  const ThemeState({required this.isDarkTheme});

  @override
  List<Object> get props => [isDarkTheme];
}

class ThemeBlocInitial extends ThemeState {
  const ThemeBlocInitial({required bool isDarkTheme})
      : super(isDarkTheme: isDarkTheme);
}
