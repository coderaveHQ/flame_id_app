import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

Future<bool> showInviteUserUnspecifiedSubUnitDetailsAlert(BuildContext context) async {
  final bool? shouldSignOut = await showAdaptiveDialog<bool>(
    context: context,
    builder: (BuildContext context) => const InviteUserUnspecifiedSubUnitDetailsAlert()
  );
  return shouldSignOut ?? false;
}

class InviteUserUnspecifiedSubUnitDetailsAlert extends StatelessWidget {

  const InviteUserUnspecifiedSubUnitDetailsAlert({ super.key });

  @override
  Widget build(BuildContext context) {
    return FDialog(
      direction: Axis.horizontal,
      title: const Text('Unvollständige Angaben!'),
      body: const Text('Es gibt unvollständige Angaben zu Untereinheiten. Sollen diese automatisch entfernt werden?'),
      actions: [
        FButton(
          onPress: () => context.pop(false),
          style: FButtonStyle.outline(), 
          child: const Text('Abbrechen')
        ),
        FButton(
          onPress: () => context.pop(true), 
          child: const Text('Entfernen')
        )
      ]
    );
  }
}