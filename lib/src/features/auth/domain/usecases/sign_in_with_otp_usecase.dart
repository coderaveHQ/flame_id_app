import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/core/error/failures/validation_failure.dart';
import 'package:flame_id_app/core/utils/validator.dart';
import 'package:flame_id_app/src/features/auth/domain/repositories/auth_repository.dart';

part 'sign_in_with_otp_usecase.g.dart';

@riverpod
SignInWithOtpUsecase signInWithOtpUsecase(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return SignInWithOtpUsecase(authRepository);
}

class SignInWithOtpUsecase {

  final AuthRepository _authRepository;

  const SignInWithOtpUsecase(this._authRepository);

  Future<Either<Failure, Unit>> call({
    required String email
  }) async {
    final ValidationFailure? emailValidationFailure = Validator.validateEmail(email);
    if (emailValidationFailure != null) return Left(emailValidationFailure);
    
    return await _authRepository.signInWithOtp(email: email);
  }
}