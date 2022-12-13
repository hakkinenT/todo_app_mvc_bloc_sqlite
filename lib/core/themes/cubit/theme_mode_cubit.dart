import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_mode_state.dart';

class ThemeModeCubit extends Cubit<ThemeModeState> {
  ThemeModeCubit() : super(const ThemeModeState());

  void themeChanged() {
    emit(state.copyWhite(isDark: !state.isDark));
  }
}
