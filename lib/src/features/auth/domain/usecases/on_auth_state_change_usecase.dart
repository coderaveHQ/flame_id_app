import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:flame_id_app/src/features/auth/presentation/providers/custom_auth_state_notifier_provider.dart';

part 'on_auth_state_change_usecase.g.dart';

@riverpod
OnAuthStateChangeUsecase onAuthStateChangeUsecase(Ref ref) {
  final AuthRepository authRepository = ref.watch(authRepositoryProvider);
  return OnAuthStateChangeUsecase(authRepository);
}

class OnAuthStateChangeUsecase {

  final AuthRepository _authRepository;
  
  const OnAuthStateChangeUsecase(this._authRepository);

  Stream<Either<Failure, CustomAuthState>> call() {
    return _authRepository.onAuthStateChange;
  }
}