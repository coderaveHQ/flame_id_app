import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

Future<bool> showSignOutButtonAlert(BuildContext context) async {
  final bool? shouldSignOut = await showAdaptiveDialog<bool>(
    context: context,
    builder: (BuildContext context) => const SignOutButtonAlert()
  );
  return shouldSignOut ?? false;
}

class SignOutButtonAlert extends StatelessWidget {

  const SignOutButtonAlert({ super.key });

  @override
  Widget build(BuildContext context) {
    return FDialog(
      direction: Axis.horizontal,
      title: const Text('Bist du sicher?'),
      body: const Text('Möchtest du dich wirklich abmelden?'),
      actions: [
        FButton(
          onPress: () => context.pop(false),
          style: FButtonStyle.outline(), 
          child: const Text('Abbrechen')
        ),
        FButton(
          onPress: () => context.pop(true), 
          child: const Text('Abmelden')
        )
      ]
    );
  }
}