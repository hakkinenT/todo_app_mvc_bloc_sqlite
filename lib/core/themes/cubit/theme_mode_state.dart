part of 'theme_mode_cubit.dart';

class ThemeModeState extends Equatable {
  final bool isDark;
  const ThemeModeState({this.isDark = false});

  ThemeModeState copyWhite({bool? isDark}) {
    return ThemeModeState(isDark: isDark ?? this.isDark);
  }

  @override
  List<Object> get props => [isDark];
}
