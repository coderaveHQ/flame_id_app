import 'package:flame_id_app/core/error/failures/validation_failure.dart';

class Validator {

  static ValidationFailure? validateEmail(String email) {
    final RegExp regExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(email)) {
      return const ValidationFailure.invalidEmail();
    }

    return null;
  }

  static ValidationFailure? validatePassword(String password) {
    if (password.length < 6 || password.length > 128) {
      return const ValidationFailure.invalidPassword();
    }

    return null;
  }
}