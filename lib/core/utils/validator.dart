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
    final RegExp regExp = RegExp(r'^.{6,}$');
    if (!regExp.hasMatch(password)) {
      return const ValidationFailure.invalidPassword();
    }

    return null;
  }

  static ValidationFailure? validateName(String name) {
    final RegExp regExp = RegExp(r'^.{2,64}$');
    if (!regExp.hasMatch(name)) {
      return const ValidationFailure.invalidName();
    }

    return null;
  }

  static ValidationFailure? validateOtp(String otp) {
    final RegExp regExp = RegExp(r'^\d{6}$');
    if (!regExp.hasMatch(otp)) {
      return const ValidationFailure.invalidOtpToken();
    }

    return null;
  }
}