import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flame_id_app/src/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:flame_id_app/src/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:flame_id_app/src/features/auth/domain/repositories/auth_repository.dart';

part 'sign_out_usecase_provider.g.dart';

@riverpod
SignOutUsecase signOutUsecase(Ref ref) {
  final AuthRepository authRepository = ref.watch(authRepositoryProvider);
  return SignOutUsecase(authRepository);
}