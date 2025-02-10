import 'package:dartz/dartz.dart';

import 'package:flame_id_app/core/error/failure.dart';
import 'package:flame_id_app/src/features/auth/domain/failures/auth_validation_failure.dart';
import 'package:flame_id_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:flame_id_app/src/features/auth/domain/validators/auth_validator.dart';

class SignInUseCase {
  
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<Either<Failure, Unit>> call({
    required String email,
    required String password
  }) async {
    final AuthValidationFailure? emailFailure = AuthValidator.validateEmail(email);
    if (emailFailure != null) return Left(emailFailure);

    final AuthValidationFailure? passwordFailure = AuthValidator.validatePassword(password);
    if (passwordFailure != null) return Left(passwordFailure);

    return repository.signIn(
      email: email,
      password: password
    );
  }
}