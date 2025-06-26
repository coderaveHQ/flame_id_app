import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';

import 'package:flame_id_app/core/utils/toaster.dart';

class Success extends Equatable {

  final String title;
  final String description;

  const Success({
    required this.title,
    required this.description
  });

  const Success.signedIn()
    : title = 'Anmeldung erfolgreich',
      description = 'Die Anmeldung war erfolgreich.';

  const Success.resetPasswordEmailSent()
    : title = 'E-Mail gesendet',
      description = 'Wir haben dir eine E-Mail gesendet.';

  const Success.signedOut()
    : title = 'Abmeldung erfolgreich',
      description = 'Die Abmeldung war erfolgreich.';

  void showToast(BuildContext context) {
    Toaster.showSuccess(
      context: context,
      title: title,
      description: description
    );
  }

  @override
  List<Object> get props => [
    title, 
    description
  ];
}