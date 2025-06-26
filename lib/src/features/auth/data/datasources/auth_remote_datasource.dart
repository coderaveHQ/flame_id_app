import 'package:flame_id_app/core/utils/typedefs.dart';

abstract class AuthRemoteDatasource {

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password
  });

  Future<void> resetPasswordForEmail({
    required String email
  });

  Future<void> signOut();

  Stream<SupabaseAuthState> onAuthStateChanges();
}