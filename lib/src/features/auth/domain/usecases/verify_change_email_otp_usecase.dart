import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/core/error/failures/validation_failure.dart';
import 'package:flame_id_app/core/utils/validator.dart';
import 'package:flame_id_app/src/features/auth/domain/repositories/auth_repository.dart';

part 'verify_change_email_otp_usecase.g.dart';

@riverpod
VerifyChangeEmailOtpUsecase verifyChangeEmailOtpUsecase(Ref ref) {
  final AuthRepository authRepository = ref.watch(authRepositoryProvider);
  return VerifyChangeEmailOtpUsecase(authRepository);
}

class VerifyChangeEmailOtpUsecase {

  final AuthRepository _authRepository;

  const VerifyChangeEmailOtpUsecase(this._authRepository);

  Future<Either<Failure, Unit>> call({
    required String newEmail,
    required String otp
  }) async {
    final ValidationFailure? newEmailValidationFailure = Validator.validateEmail(newEmail);
    if (newEmailValidationFailure != null) return Left(newEmailValidationFailure);

    final ValidationFailure? otpValidationFailure = Validator.validateOtp(otp);
    if (otpValidationFailure != null) return Left(otpValidationFailure);
    
    return await _authRepository.verifyChangeEmailOtp(
      newEmail: newEmail,
      otp: otp
    );
  }
}