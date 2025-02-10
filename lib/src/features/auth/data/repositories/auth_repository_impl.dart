import 'package:dartz/dartz.dart';

import 'package:flame_id_app/src/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:flame_id_app/src/features/auth/domain/failures/auth_supabase_failure.dart';
import 'package:flame_id_app/src/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {

  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AuthSupabaseFailure, Unit>> signIn({
    required String email,
    required String password
  }) async {
    try {
      await remoteDataSource.signIn(
        email: email,
        password: password
      );
      return const Right(unit);
    } catch (e) {
      return const Left(AuthSupabaseFailure.invalidCredentials());
    }
  }

  @override
  Future<Either<AuthSupabaseFailure, Unit>> signUp({
    required String name,
    required String email,
    required String password
  }) async {
    try {
      await remoteDataSource.signUp(
        name: name,
        email: email,
        password: password
      );
      return const Right(unit);
    } catch (e) {
      return const Left(AuthSupabaseFailure.invalidCredentials());
    }
  }
}
