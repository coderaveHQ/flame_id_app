import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/src/features/auth/domain/repositories/auth_repository.dart';

part 'resend_change_email_otp_usecase.g.dart';

@riverpod
ResendChangeEmailOtpUsecase resendChangeEmailOtpUsecase(Ref ref) {
  final AuthRepository authRepository = ref.watch(authRepositoryProvider);
  return ResendChangeEmailOtpUsecase(authRepository);
}

class ResendChangeEmailOtpUsecase {

  final AuthRepository _authRepository;

  const ResendChangeEmailOtpUsecase(this._authRepository);

  Future<Either<Failure, Unit>> call({
    required String newEmail
  }) async {
    return await _authRepository.resendChangeEmailOtp(newEmail: newEmail);
  }
}
