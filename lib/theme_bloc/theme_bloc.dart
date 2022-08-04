import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
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

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return ThemeState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return state.toMap();
  }
}
