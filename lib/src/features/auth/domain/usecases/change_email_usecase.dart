import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/src/features/auth/domain/repositories/auth_repository.dart';

part 'change_email_usecase.g.dart';

@riverpod
ChangeEmailUsecase changeEmailUsecase(Ref ref) {
  final AuthRepository authRepository = ref.watch(authRepositoryProvider);
  return ChangeEmailUsecase(authRepository);
}

class ChangeEmailUsecase {

  final AuthRepository _authRepository;

  const ChangeEmailUsecase(this._authRepository);

  Future<Either<Failure, Unit>> call({
    required String newEmail
  }) async {
    return await _authRepository.changeEmail(newEmail: newEmail);
  }
}
