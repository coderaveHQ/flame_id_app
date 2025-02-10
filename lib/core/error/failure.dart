import 'package:flutter/material.dart';

import 'package:flame_id_app/core/utils/toaster.dart';

abstract class Failure {

  final String message;

  const Failure(this.message);

  void showErrorToast(BuildContext context) {
    Toaster.showError(context, message);
  }
}