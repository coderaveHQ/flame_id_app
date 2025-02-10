import 'package:flutter/material.dart';

import 'package:flame_id_app/core/common/widgets/fl_spinner.dart';
import 'package:flame_id_app/core/res/theme/colors/fl_colors.dart';

class FLCircularButton extends StatelessWidget {

  final void Function()? onPressed;
  final IconData icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double size;
  final bool isLoading;
  final bool isEnabled;

  const FLCircularButton({
    super.key,
    this.onPressed,
    required this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.size = 52.0,
    this.isLoading = false,
    this.isEnabled = true
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: RawMaterialButton(
        onPressed: isEnabled && !isLoading ? onPressed : null,
        elevation: 0.0,
        focusElevation: 0.0,
        highlightElevation: 0.0,
        hoverElevation: 0.0,
        enableFeedback: isEnabled && !isLoading,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(size / 2.0)),
        fillColor: backgroundColor ?? FLColors.gray100,
        child: isLoading
          ? FLSpinner(
            size: size / 2.0, 
            color: foregroundColor ?? FLColors.gray900
          )
          : Icon(
            icon,
            color: foregroundColor ?? FLColors.gray900,
            size: size / 2.0
          )
      )
    );
  }
}