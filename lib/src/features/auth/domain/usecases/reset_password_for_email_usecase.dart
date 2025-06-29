import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/core/error/failures/validation_failure.dart';
import 'package:flame_id_app/core/utils/validator.dart';
import 'package:flame_id_app/src/features/auth/domain/repositories/auth_repository.dart';

part 'reset_password_for_email_usecase.g.dart';

@riverpod
ResetPasswordForEmailUsecase resetPasswordForEmailUsecase(Ref ref) {
  final AuthRepository authRepository = ref.watch(authRepositoryProvider);
  return ResetPasswordForEmailUsecase(authRepository);
}

class ResetPasswordForEmailUsecase {

  final AuthRepository _authRepository;

  const ResetPasswordForEmailUsecase(this._authRepository);

  Future<Either<Failure, Unit>> call({
    required String email
  }) async {
    final ValidationFailure? emailValidationFailure = Validator.validateEmail(email);
    if (emailValidationFailure != null) return Left(emailValidationFailure);
    
    return await _authRepository.resetPasswordForEmail(email: email);
  }
}