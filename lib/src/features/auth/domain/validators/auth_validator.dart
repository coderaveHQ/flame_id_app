import 'package:flame_id_app/src/features/auth/domain/failures/auth_validation_failure.dart';

class AuthValidator {

  static AuthValidationFailure? validateEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(email)) return const AuthValidationFailure.invalidEmail();
    return null;
  }

  static AuthValidationFailure? validatePassword(String password) {
    if (password.length < 6)return const AuthValidationFailure.invalidPassword();
    return null;
  }

  static AuthValidationFailure? validateName(String name) {
    if (name.length < 2 || name.length > 64) return const AuthValidationFailure.invalidName();
    return null;
  }
}
