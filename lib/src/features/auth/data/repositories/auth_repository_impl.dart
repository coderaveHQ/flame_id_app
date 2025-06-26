import 'package:dartz/dartz.dart';

import 'package:flame_id_app/core/error/exception_handler.dart';
import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/src/features/auth/presentation/providers/custom_auth_state_notifier_provider.dart';
import 'package:flame_id_app/src/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:flame_id_app/src/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {

  const AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDatasource _remoteDataSource;

  @override
  Future<Either<Failure, Unit>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return handleAsyncExceptions(() async {
      await _remoteDataSource.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> resetPasswordForEmail({required String email}) async {
    return handleAsyncExceptions(() async {
      await _remoteDataSource.resetPasswordForEmail(email: email);
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    return handleAsyncExceptions(() async {
      await _remoteDataSource.signOut();
      return unit;
    });
  }

  @override
  Stream<Either<Failure, CustomAuthState>> onAuthStateChanges() {
    return handleStreamExceptions(() => _remoteDataSource.onAuthStateChanges().map((supabaseAuthState) {
      return CustomAuthState.fromSupabaseAuthSession(supabaseAuthState.session);
    }));
  }
}