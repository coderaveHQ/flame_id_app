import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

import 'package:flame_id_app/core/extensions/build_context_x.dart';
import 'package:flame_id_app/src/main_sidebar.dart';

class ChatsPage extends StatelessWidget {

  const ChatsPage({ super.key });

  @override
  Widget build(BuildContext context) {

    final FBreakpoints breakpoints = context.theme.breakpoints;

    return FScaffold(
      header: FHeader.nested(
        title: const Text('Chats'),
        prefixes: [
          if (context.screenWidth < breakpoints.md) FHeaderAction(
            onPress: () => showMainSidebar(context),
            icon: Icon(FIcons.menu)
          )
        ]
      ),
      child: Container()
    );
  }
}