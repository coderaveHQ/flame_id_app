import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/src/features/auth/domain/repositories/auth_repository.dart';

part 'change_password_usecase.g.dart';

@riverpod
ChangePasswordUsecase changePasswordUsecase(Ref ref) {
  final AuthRepository authRepository = ref.watch(authRepositoryProvider);
  return ChangePasswordUsecase(authRepository);
}

class ChangePasswordUsecase {

  final AuthRepository _authRepository;

  const ChangePasswordUsecase(this._authRepository);

  Future<Either<Failure, Unit>> call({
    required String newPassword
  }) async {
    return await _authRepository.changePassword(newPassword: newPassword);
  }
}
