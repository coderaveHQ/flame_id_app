import 'package:flame_id_app/core/error/failures/auth_failure.dart';

class AuthWeakPasswordFailure extends AuthFailure {

  const AuthWeakPasswordFailure()
      : super(
          title: 'Schwaches Passwort',
          description: 'Das Passwort entspricht nicht den Stärkeanforderungen. Bitte verwenden Sie ein stärkeres Passwort.'
        );
}