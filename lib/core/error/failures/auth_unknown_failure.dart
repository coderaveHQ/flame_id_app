import 'package:flame_id_app/core/error/failures/auth_failure.dart';

class AuthUnknownFailure extends AuthFailure {

  const AuthUnknownFailure()
      : super(
          title: 'Unbekannter Authentifizierungsfehler',
          description: 'Ein unbekannter Fehler bei der Authentifizierung ist aufgetreten.'
        );
}