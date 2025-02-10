abstract class AuthRemoteDataSource {

  Future<void> signIn({
    required String email,
    required String password
  });

  Future<void> signUp({
    required String name,
    required String email,
    required String password
  });
}