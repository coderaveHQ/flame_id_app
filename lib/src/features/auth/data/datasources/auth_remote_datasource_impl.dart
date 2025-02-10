import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:flame_id_app/src/features/auth/data/datasources/auth_remote_datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<void> signIn({
    required String email,
    required String password
  }) async {
    final AuthResponse _ = await supabaseClient.auth.signInWithPassword(
      email: email, 
      password: password
    );
  }

  @override
  Future<void> signUp({
    required String name,
    required String email,
    required String password
  }) async {
    final AuthResponse _ = await supabaseClient.auth.signUp(
      email: email,
      password: password,
      data: <String, dynamic>{
        'name' : name
      }
    );
  }
}