import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

import 'package:flame_id_app/src/features/auth/presentation/widgets/invite_user_form_dialog.dart';
import 'package:flame_id_app/core/extensions/build_context_x.dart';
import 'package:flame_id_app/src/main_sidebar.dart';

class UsersPage extends StatelessWidget {

  const UsersPage({ super.key });

  @override
  Widget build(BuildContext context) {

    final FBreakpoints breakpoints = context.theme.breakpoints;

    return FScaffold(
      header: FHeader.nested(
        title: const Text('Benutzerverwaltung'),
        prefixes: <Widget>[
          if (context.screenWidth < breakpoints.md) FHeaderAction(
            onPress: () => showMainSidebar(context),
            icon: Icon(FIcons.menu)
          )
        ],
        suffixes: <Widget>[
          FButton(
            onPress: () => showFDialog(
              context: context,
              builder: (BuildContext _, FDialogStyle style, Animation<double> animation) => InviteUserDialog(
                style: style,
                animation: animation
              )
            ),
            child: const Text('Benutzer einladen')
          )
        ]
      ),
      child: Container()
    );
  }
}