import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flame_id_app/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flame_id_app/src/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/src/features/auth/presentation/providers/custom_auth_state_notifier_provider.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  final AuthRemoteDatasource authRemoteDatasource = ref.watch(authRemoteDatasourceProvider);
  return AuthRepositoryImpl(authRemoteDatasource);
}

abstract class AuthRepository {

  Future<Either<Failure, Unit>> signInWithEmailAndPassword({
    required String email,
    required String password
  });

  Future<Either<Failure, Unit>> signInWithOtp({
    required String email
  });

  Future<Either<Failure, Unit>> resendSignInOtp({
    required String email
  });

  Future<Either<Failure, Unit>> verifySignInOtp({
    required String email,
    required String otp
  });

  Future<Either<Failure, Unit>> resetPasswordForEmail({
    required String email
  });

  Future<Either<Failure, Unit>> resendResetPasswordOtp({
    required String email
  });

  Future<Either<Failure, Unit>> verifyResetPasswordOtp({
    required String email,
    required String otp
  });

  Future<Either<Failure, Unit>> changeEmail({
    required String newEmail
  });

  Future<Either<Failure, Unit>> resendChangeEmailOtp({
    required String newEmail
  });

  Future<Either<Failure, Unit>> verifyChangeEmailOtp({
    required String newEmail,
    required String otp
  });

  Future<Either<Failure, Unit>> changePassword({
    required String newPassword
  });

  Future<Either<Failure, Unit>> signOut();

  Stream<Either<Failure, CustomAuthState>> onAuthStateChange();

  CustomAuthState get currentAuthState;
}
