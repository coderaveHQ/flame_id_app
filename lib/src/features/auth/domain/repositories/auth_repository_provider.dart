import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:flame_id_app/src/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:flame_id_app/src/features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:flame_id_app/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flame_id_app/src/features/auth/domain/repositories/auth_repository.dart';

part 'auth_repository_provider.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  final AuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSourceImpl(Supabase.instance.client);
  return AuthRepositoryImpl(authRemoteDataSource);
}