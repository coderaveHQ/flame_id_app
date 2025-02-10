import 'package:flutter/material.dart';

import 'package:flame_id_app/core/utils/toaster.dart';
import 'package:flame_id_app/core/error/failure.dart';

extension ObjectX on Object {

  void showErrorToast(BuildContext context) {
    if (this is Failure) { (this as Failure).showErrorToast(context); }
    else { Toaster.showError(context, 'Ein unbekannter Fehler ist aufgetreten.'); }
  }
}