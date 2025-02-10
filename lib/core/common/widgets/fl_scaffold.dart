import 'package:flutter/material.dart';

import 'package:flame_id_app/core/res/theme/colors/fl_colors.dart';
import 'package:flame_id_app/core/common/widgets/fl_app_bar.dart';

class FLScaffold extends StatelessWidget {

  final FLAppBar? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const FLScaffold({
    super.key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FLColors.white,
      appBar: appBar,
      body: body,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation
    );
  }
}