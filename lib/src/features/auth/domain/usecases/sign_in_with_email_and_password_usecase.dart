import 'package:dartz/dartz.dart';

import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/core/error/failures/validation_failure.dart';
import 'package:flame_id_app/core/utils/validator.dart';
import 'package:flame_id_app/src/features/auth/domain/repositories/auth_repository.dart';

class SignInWithEmailAndPasswordUsecase {

  final AuthRepository _authRepository;

  const SignInWithEmailAndPasswordUsecase(this._authRepository);

  Future<Either<Failure, Unit>> call({
    required String email,
    required String password
  }) async {
    final ValidationFailure? emailValidationFailure = Validator.validateEmail(email);
    if (emailValidationFailure != null) return Left(emailValidationFailure);
    
    final ValidationFailure? passwordValidationFailure = Validator.validatePassword(password);
    if (passwordValidationFailure != null) return Left(passwordValidationFailure);

    return await _authRepository.signInWithEmailAndPassword(
      email: email,
      password: password
    );
  }
}
