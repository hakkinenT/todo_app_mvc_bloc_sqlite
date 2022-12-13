import 'package:flutter/material.dart';

SnackBar snackbar(BuildContext context, String message) => SnackBar(
    behavior: SnackBarBehavior.floating,
    dismissDirection: DismissDirection.startToEnd,
    padding: const EdgeInsets.all(16),
    backgroundColor: Theme.of(context).errorColor,
    action: SnackBarAction(
        label: 'OK',
        textColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }),
    content: Text(
      message,
      style: TextStyle(color: Theme.of(context).colorScheme.primary),
    ));
