import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/core/error/failures/supabase/supabase_auth_api_failure.dart';

class SupabaseAuthFailure extends Failure {

  final String? code;
  final String? httpStatus;

  const SupabaseAuthFailure({
    this.code,
    this.httpStatus,
    required super.title,
    required super.description,
    super.stackTrace
  });

  const SupabaseAuthFailure.unknown({
    this.code,
    this.httpStatus,
    super.stackTrace
  }) : super(
         title: 'Unbekannter Authentifizierungsfehler',
         description: 'Ein unbekannter Fehler bei der Authentifizierung ist aufgetreten.');

  const SupabaseAuthFailure.weakPassword({
    this.code,
    this.httpStatus,
    super.stackTrace
  }) : super(
         title: 'Schwaches Passwort',
         description: 'Das Passwort entspricht nicht den Stärkeanforderungen. Bitte verwenden Sie ein stärkeres Passwort.');

  const SupabaseAuthFailure.retryable({
    this.code,
    this.httpStatus,
    super.stackTrace
  }) : super(
         title: 'Wiederholbarer Fehler',
         description: 'Ein temporärer Fehler ist aufgetreten. Bitte versuchen Sie es erneut.');

  const SupabaseAuthFailure.sessionMissing({
    this.code,
    this.httpStatus,
    super.stackTrace
  }) : super(
         title: 'Sitzung fehlt',
         description: 'Keine gültige Sitzung vorhanden. Bitte melden Sie sich erneut an.');

  SupabaseAuthFailure copyWith({
    String? code,
    String? httpStatus,
    String? title,
    String? description,
    StackTrace? stackTrace
  }) {
    return SupabaseAuthFailure(
      code: code ?? this.code,
      httpStatus: httpStatus ?? this.httpStatus,
      title: title ?? this.title,
      description: description ?? this.description,
      stackTrace: stackTrace ?? this.stackTrace
    );
  }

  static SupabaseAuthFailure fromAuthException(AuthException e) {
    if (e is AuthApiException && e.statusCode != null) {
      final SupabaseAuthFailure? failure = SupabaseAuthApiFailure.getBySupabaseCode(e.code);
      return failure?.copyWith(httpStatus: e.statusCode) ?? SupabaseAuthApiFailure.unknown(httpStatus: e.statusCode);
    }

    return switch (e) {
      AuthUnknownException() => const SupabaseAuthFailure.unknown(),
      AuthWeakPasswordException() => const SupabaseAuthFailure.weakPassword(),
      AuthRetryableFetchException() => const SupabaseAuthFailure.retryable(),
      AuthSessionMissingException() => const SupabaseAuthFailure.sessionMissing(),
      _ => const SupabaseAuthFailure.unknown()
    };
  }
}