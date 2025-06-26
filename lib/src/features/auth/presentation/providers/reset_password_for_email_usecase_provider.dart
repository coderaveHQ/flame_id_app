import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flame_id_app/src/features/auth/domain/usecases/reset_password_for_email_usecase.dart';
import 'package:flame_id_app/src/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:flame_id_app/src/features/auth/domain/repositories/auth_repository.dart';

part 'reset_password_for_email_usecase_provider.g.dart';

@riverpod
ResetPasswordForEmailUsecase resetPasswordForEmailUsecase(Ref ref) {
  final AuthRepository authRepository = ref.watch(authRepositoryProvider);
  return ResetPasswordForEmailUsecase(authRepository);
}