import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeBlocInitial(isDarkTheme: false)) {
    on<toggleOn>((event, emit) {
      emit(
        ThemeState(isDarkTheme: true),
      );
    });

    on<toggleOff>((event, emit) {
      emit(
        ThemeState(isDarkTheme: false),
      );
    });
  }
}
