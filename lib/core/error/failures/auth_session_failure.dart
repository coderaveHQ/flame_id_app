import 'package:flame_id_app/core/error/failures/auth_failure.dart';

class AuthSessionFailure extends AuthFailure {

  const AuthSessionFailure()
      : super(
          title: 'Sitzung fehlt',
          description: 'Keine gültige Sitzung vorhanden. Bitte melden Sie sich erneut an.'
        );
}