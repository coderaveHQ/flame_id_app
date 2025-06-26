import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

import 'package:flame_id_app/core/extensions/build_context_x.dart';
import 'package:flame_id_app/src/main_sidebar.dart';

class MainPage extends StatelessWidget {

  final Widget navigator;

  const MainPage({
    super.key,
    required this.navigator
  });

  @override
  Widget build(BuildContext context) {

    final FBreakpoints breakpoints = context.theme.breakpoints;

    return FScaffold(
      sidebar: context.screenWidth >= breakpoints.md
        ? MainSidebar(
          currentRoute: context.currentRoute,
          onNavigate: (String route) => context.go(route)
        )
        : null,
      child: navigator
    );
  }
}