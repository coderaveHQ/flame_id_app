import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flame_id_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:flame_id_app/src/features/auth/presentation/providers/custom_auth_state_notifier_provider.dart';

part 'current_auth_state_usecase.g.dart';

@riverpod
CurrentAuthStateUsecase currentAuthStateUsecase(Ref ref) {
  final AuthRepository authRepository = ref.watch(authRepositoryProvider);
  return CurrentAuthStateUsecase(authRepository);
}

class CurrentAuthStateUsecase {

  final AuthRepository _authRepository;
  
  const CurrentAuthStateUsecase(this._authRepository);

  CustomAuthState call() {
    return _authRepository.currentAuthState;
  }
}