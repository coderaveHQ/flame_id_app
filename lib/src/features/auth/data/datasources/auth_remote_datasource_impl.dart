import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:flame_id_app/core/utils/redirect_urls.dart';
import 'package:flame_id_app/core/utils/typedefs.dart';
import 'package:flame_id_app/src/features/auth/data/datasources/auth_remote_datasource.dart';

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {

  const AuthRemoteDatasourceImpl(this._client);

  final SupabaseClient _client;

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password
  }) async {
    final AuthResponse _ = await _client.auth.signInWithPassword(
      email: email,
      password: password
    );
  }

  @override
  Future<void> signInWithOtp({
    required String email
  }) async {
    await _client.auth.signInWithOtp(
      email: email,
      emailRedirectTo: RedirectUrls.magicLink
    );
  }

  @override
  Future<void> resendSignInOtp({
    required String email
  }) async {
    await _client.auth.resend(
      type: OtpType.email,
      email: email,
      emailRedirectTo: RedirectUrls.magicLink
    );
  }

  @override
  Future<void> verifySignInOtp({
    required String email,
    required String otp
  }) async {
    await _client.auth.verifyOTP(
      type: OtpType.email,
      email: email,
      token: otp,
      redirectTo: RedirectUrls.magicLink
    );
  }

  @override
  Future<void> resetPasswordForEmail({
    required String email
  }) async {
    await _client.auth.resetPasswordForEmail(
      email,
      redirectTo: RedirectUrls.resetPassword
    );
  }

  @override
  Future<void> resendResetPasswordOtp({
    required String email
  }) async {
    await _client.auth.resend(
      type: OtpType.recovery,
      email: email,
      emailRedirectTo: RedirectUrls.resetPassword
    );
  }

  @override
  Future<void> verifyResetPasswordOtp({
    required String email,
    required String otp
  }) async {
    await _client.auth.verifyOTP(
      type: OtpType.recovery,
      email: email,
      token: otp,
      redirectTo: RedirectUrls.resetPassword
    );
  }

  @override
  Future<void> changeEmail({
    required String newEmail
  }) async {
    await _client.auth.updateUser(
      UserAttributes(email: newEmail),
      emailRedirectTo: RedirectUrls.changeEmail
    );
  }

  @override
  Future<void> resendChangeEmailOtp({
    required String newEmail
  }) async {
    await _client.auth.resend(
      type: OtpType.emailChange,
      email: newEmail,
      emailRedirectTo: RedirectUrls.changeEmail
    );
  }

  @override
  Future<void> verifyChangeEmailOtp({
    required String newEmail,
    required String otp
  }) async {
    await _client.auth.verifyOTP(
      type: OtpType.emailChange,
      email: newEmail,
      token: otp,
      redirectTo: RedirectUrls.changeEmail
    );
  }

  @override
  Future<void> changePassword({
    required String newPassword
  }) async {
    await _client.auth.updateUser(
      UserAttributes(password: newPassword)
    );
  }

  @override
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  @override
  Stream<SupabaseAuthState> onAuthStateChange() {
    return _client.auth.onAuthStateChange;
  }

  @override
  SupabaseAuthSession? get currentAuthSession {
    return _client.auth.currentSession;
  }
}