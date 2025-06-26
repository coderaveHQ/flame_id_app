import 'package:dartz/dartz.dart';

import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/core/error/failures/validation_failure.dart';
import 'package:flame_id_app/core/utils/validator.dart';
import 'package:flame_id_app/src/features/auth/domain/repositories/auth_repository.dart';

class ResetPasswordForEmailUsecase {

  final AuthRepository _authRepository;

  ResetPasswordForEmailUsecase(this._authRepository);

  Future<Either<Failure, Unit>> call({
    required String email
  }) async {
    final ValidationFailure? emailValidationFailure = Validator.validateEmail(email);
    if (emailValidationFailure != null) return Left(emailValidationFailure);
    
    return await _authRepository.resetPasswordForEmail(email: email);
  }
}