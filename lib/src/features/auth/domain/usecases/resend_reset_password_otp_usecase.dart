import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/src/features/auth/domain/repositories/auth_repository.dart';

part 'resend_reset_password_otp_usecase.g.dart';

@riverpod
ResendResetPasswordOtpUsecase resendResetPasswordOtpUsecase(Ref ref) {
  final AuthRepository authRepository = ref.watch(authRepositoryProvider);
  return ResendResetPasswordOtpUsecase(authRepository);
}

class ResendResetPasswordOtpUsecase {

  final AuthRepository _authRepository;

  const ResendResetPasswordOtpUsecase(this._authRepository);

  Future<Either<Failure, Unit>> call({
    required String email
  }) async {
    return await _authRepository.resendResetPasswordOtp(email: email);
  }
}
