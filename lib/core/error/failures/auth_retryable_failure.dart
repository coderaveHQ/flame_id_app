import 'package:flame_id_app/core/error/failures/auth_failure.dart';

class AuthRetryableFailure extends AuthFailure {

  const AuthRetryableFailure()
      : super(
          title: 'Wiederholbarer Fehler',
          description: 'Ein temporärer Fehler ist aufgetreten. Bitte versuchen Sie es erneut.'
        );
}