import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flame_id_app/src/features/auth/presentation/providers/auth_remote_datasource_provider.dart';
import 'package:flame_id_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:flame_id_app/src/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:flame_id_app/src/features/auth/data/repositories/auth_repository_impl.dart';

part 'auth_repository_provider.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  final AuthRemoteDatasource authRemoteDatasource = ref.watch(authRemoteDatasourceProvider);
  return AuthRepositoryImpl(authRemoteDatasource);
}