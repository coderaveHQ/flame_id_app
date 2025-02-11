import 'package:flutter/material.dart';

import 'package:flame_id_app/core/extensions/build_context_x.dart';
import 'package:flame_id_app/core/res/theme/spacing/fl_spacing.dart';
import 'package:flame_id_app/core/common/widgets/fl_circular_button.dart';
import 'package:flame_id_app/core/res/theme/colors/fl_colors.dart';

class FLBottomNavigationBar extends StatelessWidget {

  final List<FLBottomNavigationBarItem> items;

  const FLBottomNavigationBar({
    super.key,
    this.items = const <FLBottomNavigationBarItem>[]
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kBottomNavigationBarHeight + context.bottomPadding,
      color: FLColors.white,
      padding: EdgeInsets.only(
        left: context.leftPadding + FLSpacing.lg,
        right: context.rightPadding + FLSpacing.lg,
        bottom: context.bottomPadding
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items
      )
    );
  }
}

class FLBottomNavigationBarItem extends StatelessWidget {

  final void Function()? onPressed;
  final IconData icon;
  final bool isSelected;

  const FLBottomNavigationBarItem({
    super.key,
    this.onPressed,
    required this.icon,
    this.isSelected = false
  });

  @override
  Widget build(BuildContext context) {
    return FLCircularButton(
      onPressed: onPressed,
      icon: icon,
      size: kBottomNavigationBarHeight - 8.0,
      backgroundColor: isSelected ? FLColors.red600 : Colors.transparent,
      foregroundColor: isSelected ? FLColors.white : FLColors.gray500
    );
  }
}