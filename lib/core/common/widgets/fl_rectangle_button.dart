import 'package:flutter/material.dart';

import 'package:flame_id_app/core/common/widgets/fl_spinner.dart';
import 'package:flame_id_app/core/common/widgets/fl_text.dart';
import 'package:flame_id_app/core/res/theme/colors/fl_colors.dart';
import 'package:flame_id_app/core/res/theme/spacing/fl_spacing.dart';

class FLRectangleButton extends StatelessWidget {

  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final String title;

  const FLRectangleButton({
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52.0,
      child: RawMaterialButton(
        onPressed: isEnabled && !isLoading ? onPressed : null,
        fillColor: FLColors.red600,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        padding: const EdgeInsets.symmetric(horizontal: FLSpacing.lg),
        enableFeedback: isEnabled && !isLoading,
        child: isLoading
          ? const FLSpinner(
            color: FLColors.white,
            size: 18.0
          )
          : FLText(
            text: title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            alignment: TextAlign.center,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: FLColors.white
            )
          )
      )
    );
  }
}