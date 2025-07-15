import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:flame_id_app/core/utils/enums/fire_department_rank.dart';
import 'package:flame_id_app/core/utils/enums/fire_department_sub_unit_user_role.dart';
import 'package:flame_id_app/core/utils/enums/fire_department_user_role.dart';
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
  Future<void> sendInvitation({
    required String email,
    required String name,
    required FireDepartmentUserRole role,
    required FireDepartmentRank rank,
    required List<({ String subUnitId, FireDepartmentSubUnitUserRole role })> subUnits
  }) async {
    await _client.functions.invoke(
      'send-invitation',
      body: <String, dynamic>{
        'email' : email,
        'redirect_to' : RedirectUrls.verifyInvite,
        'initial_data' : <String, dynamic>{
          'role' : role.dbValue,
          'rank' : rank.dbValue,
          'name' : name,
          'sub_units' : <Map<String, dynamic>>[
            ...subUnits.map((({ String subUnitId, FireDepartmentSubUnitUserRole role }) subUnit) {
              return <String, dynamic>{
                'fire_department_sub_unit_id' : subUnit.subUnitId,
                'role' : subUnit.role.dbValue
              };
            })
          ]
        }
      }
    );
  }

  @override
  Future<void> verifyInviteOtp({
    required String email,
    required String otp
  }) async {
    await _client.auth.verifyOTP(
      type: OtpType.invite,
      email: email,
      token: otp,
      redirectTo: RedirectUrls.resetPassword
    );
  }

  @override
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  @override
  Stream<SupabaseAuthState> get onAuthStateChange {
    return _client.auth.onAuthStateChange;
  }

  @override
  SupabaseAuthSession? get currentAuthSession {
    return _client.auth.currentSession;
  }
}