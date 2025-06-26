import 'package:dartz/dartz.dart';

import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:flame_id_app/src/features/auth/presentation/providers/custom_auth_state_notifier_provider.dart';

class OnAuthStateChangesUsecase {

  final AuthRepository _authRepository;
  
  const OnAuthStateChangesUsecase(this._authRepository);

  Stream<Either<Failure, CustomAuthState>> call() {
    return _authRepository.onAuthStateChanges();
  }
}