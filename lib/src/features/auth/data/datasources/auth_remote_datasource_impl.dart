import 'package:supabase_flutter/supabase_flutter.dart';

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
      password: password,
    );
  }

  @override
  Future<void> resetPasswordForEmail({
    required String email
  }) async {
    // TODO: Implement redirection
    await _client.auth.resetPasswordForEmail(email);
  }

  @override
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  @override
  Stream<AuthState> onAuthStateChanges() {
    return _client.auth.onAuthStateChange;
  }
}