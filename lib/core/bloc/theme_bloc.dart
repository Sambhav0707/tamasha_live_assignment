import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

class ToggleThemeEvent extends ThemeEvent {
  const ToggleThemeEvent();
}

// States
abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object?> get props => [];
}

class ThemeInitial extends ThemeState {
  const ThemeInitial();
}

class ThemeLoaded extends ThemeState {
  final bool isDarkMode;

  const ThemeLoaded({required this.isDarkMode});

  @override
  List<Object?> get props => [isDarkMode];

  ThemeLoaded copyWith({bool? isDarkMode}) {
    return ThemeLoaded(isDarkMode: isDarkMode ?? this.isDarkMode);
  }
}

// BLoC
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeLoaded(isDarkMode: false)) {
    on<ToggleThemeEvent>(_onToggleTheme);
  }

  void _onToggleTheme(ToggleThemeEvent event, Emitter<ThemeState> emit) {
    final currentState = state;
    if (currentState is ThemeLoaded) {
      emit(currentState.copyWith(isDarkMode: !currentState.isDarkMode));
    }
  }
}
