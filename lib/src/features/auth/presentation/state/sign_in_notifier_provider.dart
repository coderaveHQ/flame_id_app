import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flame_id_app/src/features/auth/domain/usecases/sign_in_use_case_provider.dart';
import 'package:flame_id_app/src/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:flame_id_app/src/features/auth/presentation/state/sign_in_state.dart';
import 'package:flame_id_app/core/error/failure.dart';

part 'sign_in_notifier_provider.g.dart';

@riverpod
class SignInNotifier extends _$SignInNotifier {

  late final SignInUseCase _signInUseCase;

  @override
  SignInState build() {
    _signInUseCase = ref.read(signInUseCaseProvider);
    return const SignInState();
  }

  Future<void> signIn({
    required String email,
    required String password
  }) async {
    state = state.copyWith(
      status: SignInStatus.loading,
      removeError: true
    );

    final Either<Failure, Unit> result = await _signInUseCase(
      email: email, 
      password: password
    );
    
    result.fold(
      (Failure failure) => state = state.copyWith(
        status: SignInStatus.failure,
        error: failure
      ),
      (Unit _) { }
    );
  }
}
