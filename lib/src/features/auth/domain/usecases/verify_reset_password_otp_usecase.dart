import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/core/error/failures/validation_failure.dart';
import 'package:flame_id_app/core/utils/validator.dart';
import 'package:flame_id_app/src/features/auth/domain/repositories/auth_repository.dart';

part 'verify_reset_password_otp_usecase.g.dart';

@riverpod
VerifyResetPasswordOtpUsecase verifyResetPasswordOtpUsecase(Ref ref) {
  final AuthRepository authRepository = ref.watch(authRepositoryProvider);
  return VerifyResetPasswordOtpUsecase(authRepository);
}

class VerifyResetPasswordOtpUsecase {

  final AuthRepository _authRepository;

  const VerifyResetPasswordOtpUsecase(this._authRepository);

  Future<Either<Failure, Unit>> call({
    required String email,
    required String otp
  }) async {
    final ValidationFailure? emailValidationFailure = Validator.validateEmail(email);
    if (emailValidationFailure != null) return Left(emailValidationFailure);

    final ValidationFailure? otpValidationFailure = Validator.validateOtp(otp);
    if (otpValidationFailure != null) return Left(otpValidationFailure);
    
    return await _authRepository.verifyResetPasswordOtp(
      email: email,
      otp: otp
    );
  }
}