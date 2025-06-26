import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flame_id_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:flame_id_app/src/features/auth/domain/usecases/on_auth_state_changes_usecase.dart';
import 'package:flame_id_app/src/features/auth/presentation/providers/auth_repository_provider.dart';

part 'on_auth_state_changes_usecase_provider.g.dart';

@riverpod
OnAuthStateChangesUsecase onAuthStateChangesUsecase(Ref ref) {
  final AuthRepository authRepository = ref.watch(authRepositoryProvider);
  return OnAuthStateChangesUsecase(authRepository);
}