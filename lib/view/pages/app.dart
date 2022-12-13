import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/controller.dart';
import 'pages.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationControllerBloc,
        AuthenticationControllerState>(builder: (context, state) {
      if (state.status == AuthenticationStatus.authenticated) {
        return const HomePage();
      } else {
        return const InitialPage();
      }
    });
  }
}
