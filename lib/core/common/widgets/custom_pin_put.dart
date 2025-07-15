import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:pinput/pinput.dart';

class CustomPinPut extends StatelessWidget {

  final int length;
  final TextEditingController? controller;
  final void Function(String)? onCompleted;

  const CustomPinPut({
    super.key,
    this.length = 6,
    this.controller,
    this.onCompleted
  });

  @override
  Widget build(BuildContext context) {

    final FThemeData theme = context.theme;
    final FColors colors = theme.colors;
    final FTypography typography = theme.typography;

    final PinTheme defaultPinTheme = PinTheme(
      width: 56.0,
      height: 60.0,
      textStyle: typography.base.copyWith(color: context.theme.colors.foreground),
      decoration: BoxDecoration(
        color: colors.secondary,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: colors.border)
      )
    );

    return Material(
      color: colors.background,
      child: SizedBox(
        height: 68.0,
        child: Pinput(
          onCompleted: onCompleted,
          length: length,
          controller: controller,
          autofocus: false,
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: defaultPinTheme.copyWith(
            height: 68.0,
            width: 64.0,
            decoration: defaultPinTheme.decoration!.copyWith(
              border: Border.all(color: colors.foreground)
            )
          )
        )
      )
    );
  }
}