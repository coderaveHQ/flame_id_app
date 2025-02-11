import 'package:flutter/material.dart';

import 'package:flame_id_app/core/res/theme/colors/fl_colors.dart';
import 'package:flame_id_app/core/common/widgets/fl_app_bar.dart';
import 'package:flame_id_app/core/common/widgets/fl_bottom_navigation_bar.dart';

class FLScaffold extends StatelessWidget {

  final FLAppBar? appBar;
  final Widget? body;
  final FLBottomNavigationBar? bottomNavigationBar;

  const FLScaffold({
    super.key,
    this.appBar,
    this.body,
    this.bottomNavigationBar
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FLColors.white,
      appBar: appBar,
      body: body,
      bottomNavigationBar: bottomNavigationBar
    );
  }
}