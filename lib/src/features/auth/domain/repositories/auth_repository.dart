import 'package:dartz/dartz.dart';

import 'package:flame_id_app/src/features/auth/domain/failures/auth_supabase_failure.dart';

abstract class AuthRepository {

  Future<Either<AuthSupabaseFailure, Unit>> signIn({
    required String email,
    required String password
  });

  Future<Either<AuthSupabaseFailure, Unit>> signUp({
    required String name,
    required String email,
    required String password
  });
}