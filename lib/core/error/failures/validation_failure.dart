import 'package:flame_id_app/core/error/failures/failure.dart';

class ValidationFailure extends Failure {

  const ValidationFailure({
    required super.title,
    required super.description
  }) : super(stackTrace: null);

  const ValidationFailure.invalidEmail()
      : super(
          title: 'E-Mail nicht gültig',
          description: 'Das scheint keine valide E-Mail zu sein.'
        );

  const ValidationFailure.invalidPassword()
      : super(
          title: 'Passwort nicht gültig',
          description: 'Das Passwort muss mindestens 6 Zeichen lang sein.'
        );

  const ValidationFailure.invalidOtpToken()
      : super(
          title: 'Code nicht gültig',
          description: 'Der angegebene Code ist nicht gültig.'
        );
}