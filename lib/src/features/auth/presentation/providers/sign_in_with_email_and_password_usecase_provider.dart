import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flame_id_app/src/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:flame_id_app/src/features/auth/domain/usecases/sign_in_with_email_and_password_usecase.dart';
import 'package:flame_id_app/src/features/auth/domain/repositories/auth_repository.dart';

part 'sign_in_with_email_and_password_usecase_provider.g.dart';

@riverpod
SignInWithEmailAndPasswordUsecase signInWithEmailAndPasswordUsecase(Ref ref) {
  final AuthRepository authRepository = ref.watch(authRepositoryProvider);
  return SignInWithEmailAndPasswordUsecase(authRepository);
}