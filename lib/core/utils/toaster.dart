import 'package:flutter/material.dart';

import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:flame_id_app/core/common/widgets/fl_text.dart';
import 'package:flame_id_app/core/res/theme/colors/fl_colors.dart';

enum ToastType {

  success(
    icon: LucideIcons.check,
    iconColor: FLColors.green600
  ),
  info(
    icon: LucideIcons.info,
    iconColor: FLColors.blue600
  ),
  warning(
    icon: LucideIcons.triangleAlert,
    iconColor: FLColors.orange600
  ),
  error(
    icon: LucideIcons.x,
    iconColor: FLColors.red600
  );

  final IconData icon;
  final Color iconColor;

  const ToastType({
    required this.icon,
    required this.iconColor
  });
}

class Toaster {

  static void showSuccess(BuildContext context, String text) {
    _show(context, ToastType.success, text);
  }

  static void showInfo(BuildContext context, String text) {
    _show(context, ToastType.info, text);
  }

  static void showWarning(BuildContext context, String text) {
    _show(context, ToastType.warning, text);
  }

  static void showError(BuildContext context, String text) {
    _show(context, ToastType.error, text);
  }

  static void _show(BuildContext context, ToastType type, String text) {
    DelightToastBar(
      autoDismiss: true,
      builder: (BuildContext context) => _build(context, type, text)
    ).show(context);
  }

  static ToastCard _build(BuildContext context, ToastType type, String text) {
    return ToastCard(
      color: FLColors.white,
      leading: Icon(
        type.icon,
        size: 28.0,
        color: type.iconColor
      ),
      title: FLText(
        text: text,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14.0,
          color: FLColors.gray900
        )
      )
    );
  }
}