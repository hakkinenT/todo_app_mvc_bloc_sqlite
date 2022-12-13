import 'package:flutter/material.dart';

import '../../../model/model.dart';
import '../../../view/pages/pages.dart';
import '../../utils/constants/constants.dart';
import '../page_transitions/page_transitions.dart';

class AppRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final todo = settings.arguments as Todo?;

    switch (settings.name) {
      case appPage:
        return SlideRightRoute(
            page: const InitialPage(),
            settings: const RouteSettings(name: appPage));
      case initialPage:
        return SlideRightRoute(
            page: const InitialPage(),
            settings: const RouteSettings(name: initialPage));
      case loginPage:
        return SlideRightRoute(
            settings: const RouteSettings(name: loginPage),
            page: const LoginPage(),
            fullscreenDialog: true);
      case registerPage:
        return SlideRightRoute(
            settings: const RouteSettings(name: registerPage),
            page: const RegisterPage(),
            fullscreenDialog: true);
      case homePage:
        return SlideRightRoute(
            settings: const RouteSettings(name: homePage),
            page: const HomePage());
      case addTodoPage:
        return SlideRightRoute(
            settings: const RouteSettings(name: addTodoPage),
            page: AddTodoPage(
              todo: todo,
            ));

      default:
        return SlideRightRoute(page: const _ErrorRoute(), settings: settings);
    }
  }
}

class _ErrorRoute extends StatelessWidget {
  const _ErrorRoute();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Rota desconhecida'),
      ),
    );
  }
}
