import 'package:flutter/material.dart';

import 'package:flame_id_app/core/res/theme/colors/fl_colors.dart';
import 'package:flame_id_app/core/res/theme/spacing/fl_spacing.dart';
import 'package:flame_id_app/core/res/theme/typography/fl_typography.dart';
import 'package:flame_id_app/core/extensions/generic_x.dart';

class FLTextField extends StatelessWidget {

  final TextEditingController? controller;
  final TextInputType? inputType;
  final IconData? icon;
  final String? hint;
  final bool obscure;
  final bool isEnabled;

  const FLTextField({
    super.key,
    this.controller,
    this.inputType = TextInputType.text,
    this.icon,
    this.hint,
    this.obscure = false,
    this.isEnabled = true
  });

  @override
  Widget build(BuildContext context) {

    final InputBorder defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(
        color: FLColors.gray200, 
        width: 1.5
      )
    );

    final TextStyle defaultTextStyle = FLTypography.base.copyWith(
      fontSize: 15.0,
      fontWeight: FontWeight.w400,
      color: FLColors.gray900
    );

    return TextField(
      keyboardAppearance: Brightness.light,
      controller: controller,
      autocorrect: false,
      enabled: isEnabled,
      keyboardType: inputType,
      canRequestFocus: isEnabled,
      obscureText: obscure,
      cursorColor: FLColors.gray500,
      style: defaultTextStyle,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: FLSpacing.md,
          vertical: (52.0 - 24.0) / 2.0
        ),
        border: defaultBorder,
        errorBorder: defaultBorder,
        enabledBorder: defaultBorder,
        disabledBorder: defaultBorder,
        focusedErrorBorder: defaultBorder,
        focusedBorder: defaultBorder.copyWith(borderSide: defaultBorder.borderSide.copyWith(color: FLColors.red600)),
        prefixIconConstraints: const BoxConstraints.tightFor(height: 24.0),
        prefixIcon: icon.whenNotNull((IconData ic) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: FLSpacing.md),
          child: Icon(
            icon,
            color: FLColors.gray900
          )
        )),
        hintText: hint,
        hintStyle: defaultTextStyle.copyWith(color: FLColors.gray500)
      )
    );
  }
}