import 'package:flame_id_app/core/error/failure.dart';

class AuthValidationFailure extends Failure {

  const AuthValidationFailure.invalidEmail() : super('Das scheint eine ungültige E-Mail zu sein.');
  const AuthValidationFailure.invalidPassword() : super('Das Passwort muss mindestens 6 Zeichen lang sein.');
  const AuthValidationFailure.invalidName() : super('Der Name muss zwischen 2 und 64 Zeichen lang sein.');
}