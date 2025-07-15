import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

enum ToastType {

  success,
  info,
  warning,
  error;

  IconData get icon {
    return switch (this) {
      ToastType.success => FIcons.check,
      ToastType.info => FIcons.info,
      ToastType.warning => FIcons.triangleAlert,
      ToastType.error => FIcons.x
    };
  }
}

class Toaster {

  static void showSuccess({
    required BuildContext context,
    required String title,
    required String description
  }) {
    _show(
      context: context,
      type: ToastType.success,
      title: title,
      description: description
    );
  }

  static void showInfo({
    required BuildContext context,
    required String title,
    required String description
  }) {
    _show(
      context: context,
      type: ToastType.info,
      title: title,
      description: description
    );
  }

  static void showWarning({
    required BuildContext context,
    required String title,
    required String description
  }) {
    _show(
      context: context,
      type: ToastType.warning,
      title: title,
      description: description
    );
  }

  static void showError({
    required BuildContext context,
    required String title,
    required String description
  }) {
    _show(
      context: context,
      type: ToastType.error,
      title: title,
      description: description
    );
  }

  static void _show({
    required BuildContext context, 
    required ToastType type, 
    required String title,
    required String description
  }) {
    final FToasterEntry _ = showFToast(
      context: context,
      alignment: FToastAlignment.topRight,
      icon: Icon(type.icon),
      title: Text(title),
      description: Text(description),
      duration: const Duration(seconds: 3)
    );
  }
}