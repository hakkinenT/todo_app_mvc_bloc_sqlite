import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'controller/controller.dart';
import 'core/navigation/navigation.dart';
import 'core/themes/app_theme.dart';
import 'core/themes/cubit/theme_mode_cubit.dart';
import 'injection_container.dart' as di;

import 'view/pages/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<ThemeModeCubit>()),
        BlocProvider(create: (_) => di.sl<AuthenticationControllerBloc>()),
        BlocProvider(
            create: (_) => di.sl<TodoControllerBloc>()
              ..add(const TodoControllerSubscriptionRequested()))
      ],
      child: BlocBuilder<ThemeModeCubit, ThemeModeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: state.isDark
                ? TodoThemeData.darkTheme
                : TodoThemeData.lightTheme,
            themeMode: state.isDark ? ThemeMode.dark : ThemeMode.light,
            onGenerateRoute: AppRoute.generateRoute,
            home: const App(),
          );
        },
      ),
    );
  }
}
