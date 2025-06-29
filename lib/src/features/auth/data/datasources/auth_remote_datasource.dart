import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:flame_id_app/src/features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:flame_id_app/core/utils/typedefs.dart';

part 'auth_remote_datasource.g.dart';

@riverpod
AuthRemoteDatasource authRemoteDatasource(Ref ref) {
  return AuthRemoteDatasourceImpl(Supabase.instance.client);
}

abstract class AuthRemoteDatasource {

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password
  });

  Future<void> signInWithOtp({
    required String email
  });

  Future<void> resendSignInOtp({
    required String email
  });

  Future<void> verifySignInOtp({
    required String email,
    required String otp
  });

  Future<void> resetPasswordForEmail({
    required String email
  });

  Future<void> resendResetPasswordOtp({
    required String email
  });

  Future<void> verifyResetPasswordOtp({
    required String email,
    required String otp
  });

  Future<void> changeEmail({
    required String newEmail
  });

  Future<void> resendChangeEmailOtp({
    required String newEmail
  });

  Future<void> verifyChangeEmailOtp({
    required String newEmail,
    required String otp
  });

  Future<void> changePassword({
    required String newPassword
  });

  Future<void> signOut();

  Stream<SupabaseAuthState> onAuthStateChange();

  SupabaseAuthSession? get currentAuthSession;
}