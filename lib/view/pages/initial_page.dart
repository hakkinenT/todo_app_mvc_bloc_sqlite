import 'package:flutter/material.dart';

import '../../core/utils/utils.dart';
import '../widgets/widgets.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    final marginTop = (MediaQuery.of(context).size.height / 2) - 52;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: marginTop),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StaggerElevatedButton(
                startAnimation: 0.0,
                endAnimation: 0.5,
                onPressed: () {
                  Navigator.pushNamed(context, loginPage);
                },
                child: const Text('Fazer Login')),
            const SizedBox(
              height: 16,
            ),
            StaggerOutlinedButton(
                startAnimation: 0.3,
                endAnimation: 1.0,
                onPressed: () {
                  Navigator.pushNamed(context, registerPage);
                },
                child: const Text('Cadastrar')),
          ],
        ),
      ),
    );
  }
}
