import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flame_id_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:flame_id_app/src/features/auth/domain/repositories/auth_repository_provider.dart';
import 'package:flame_id_app/src/features/auth/domain/usecases/sign_up_use_case.dart';

part 'sign_up_use_case_provider.g.dart';

@riverpod
SignUpUseCase signUpUseCase(Ref ref) {
  final AuthRepository authRepository = ref.watch(authRepositoryProvider);
  return SignUpUseCase(authRepository);
}