import 'package:dartz/dartz.dart';

import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/src/features/auth/presentation/providers/custom_auth_state_notifier_provider.dart';

abstract class AuthRepository {

  Future<Either<Failure, Unit>> signInWithEmailAndPassword({
    required String email,
    required String password
  });

  Future<Either<Failure, Unit>> resetPasswordForEmail({
    required String email
  });

  Future<Either<Failure, Unit>> signOut();

  Stream<Either<Failure, CustomAuthState>> onAuthStateChanges();
}
