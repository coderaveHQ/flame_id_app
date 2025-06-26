import 'package:dartz/dartz.dart';

import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/src/features/auth/domain/repositories/auth_repository.dart';

class SignOutUsecase {

  final AuthRepository _authRepository;

  const SignOutUsecase(this._authRepository);

  Future<Either<Failure, Unit>> call() async {
    return await _authRepository.signOut();
  }
}
