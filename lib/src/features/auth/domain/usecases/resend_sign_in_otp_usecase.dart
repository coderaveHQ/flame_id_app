import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/src/features/auth/domain/repositories/auth_repository.dart';

part 'resend_sign_in_otp_usecase.g.dart';

@riverpod
ResendSignInOtpUsecase resendSignInOtpUsecase(Ref ref) {
  final AuthRepository authRepository = ref.watch(authRepositoryProvider);
  return ResendSignInOtpUsecase(authRepository);
}

class ResendSignInOtpUsecase {

  final AuthRepository _authRepository;

  const ResendSignInOtpUsecase(this._authRepository);

  Future<Either<Failure, Unit>> call({
    required String email
  }) async {
    return await _authRepository.resendSignInOtp(email: email);
  }
}
