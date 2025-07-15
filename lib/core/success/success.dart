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

  const Success.signInWithOtpEmailSent()
    : title = 'E-Mail gesendet',
      description = 'Wir haben dir eine E-Mail gesendet.';

  const Success.resetPasswordEmailSent()
    : title = 'E-Mail gesendet',
      description = 'Wir haben dir eine E-Mail gesendet.';

  const Success.changeEmailEmailSent()
    : title = 'E-Mail gesendet',
      description = 'Wir haben dir eine E-Mail gesendet.';

  const Success.emailChanged()
    : title = 'E-Mail geändert',
      description = 'Wir haben deine E-Mail geändert.';

  const Success.passwordChanged()
    : title = 'Passwort geändert',
      description = 'Wir haben dein Passwort geändert.';

  const Success.signedOut()
    : title = 'Abmeldung erfolgreich',
      description = 'Die Abmeldung war erfolgreich.';

  const Success.invitationSent()
    : title = 'E-Mail gesendet',
      description = 'Wir haben eine Einladungs-E-Mail versendet.';

  const Success.inviteVerified()
    : title = 'Einladung angenommen',
      description = 'Du kannst dich jetzt anmelden.';

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