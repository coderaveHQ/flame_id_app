import 'package:dartz/dartz.dart';

import 'package:flame_id_app/core/error/exception_handler.dart';
import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/core/utils/enums/fire_department_rank.dart';
import 'package:flame_id_app/core/utils/enums/fire_department_sub_unit_user_role.dart';
import 'package:flame_id_app/core/utils/enums/fire_department_user_role.dart';
import 'package:flame_id_app/core/utils/typedefs.dart';
import 'package:flame_id_app/src/features/auth/presentation/providers/custom_auth_state_notifier_provider.dart';
import 'package:flame_id_app/src/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:flame_id_app/src/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {

  const AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDatasource _remoteDataSource;

  @override
  Future<Either<Failure, Unit>> signInWithEmailAndPassword({
    required String email,
    required String password
  }) async {
    return handleAsyncExceptions(() async {
      await _remoteDataSource.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> signInWithOtp({
    required String email
  }) async {
    return handleAsyncExceptions(() async {
      await _remoteDataSource.signInWithOtp(email: email);
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> resendSignInOtp({
    required String email
  }) async {
    return handleAsyncExceptions(() async {
      await _remoteDataSource.resendSignInOtp(email: email);
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> verifySignInOtp({
    required String email,
    required String otp
  }) async {
    return handleAsyncExceptions(() async {
      await _remoteDataSource.verifySignInOtp(
        email: email,
        otp: otp
      );
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> resetPasswordForEmail({
    required String email
  }) async {
    return handleAsyncExceptions(() async {
      await _remoteDataSource.resetPasswordForEmail(email: email);
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> resendResetPasswordOtp({
    required String email
  }) async {
    return handleAsyncExceptions(() async {
      await _remoteDataSource.resendResetPasswordOtp(email: email);
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> verifyResetPasswordOtp({
    required String email,
    required String otp
  }) async {
    return handleAsyncExceptions(() async {
      await _remoteDataSource.verifyResetPasswordOtp(
        email: email,
        otp: otp
      );
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> changeEmail({
    required String newEmail
  }) async {
    return handleAsyncExceptions(() async {
      await _remoteDataSource.changeEmail(newEmail: newEmail);
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> resendChangeEmailOtp({
    required String newEmail
  }) async {
    return handleAsyncExceptions(() async {
      await _remoteDataSource.resendChangeEmailOtp(newEmail: newEmail);
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> verifyChangeEmailOtp({
    required String newEmail,
    required String otp
  }) async {
    return handleAsyncExceptions(() async {
      await _remoteDataSource.verifyChangeEmailOtp(
        newEmail: newEmail,
        otp: otp
      );
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> changePassword({
    required String newPassword,
  }) async {
    return handleAsyncExceptions(() async {
      await _remoteDataSource.changePassword(newPassword: newPassword);
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> sendInvitation({
    required String email,
    required String name,
    required FireDepartmentUserRole role,
    required FireDepartmentRank rank,
    required List<({ String subUnitId, FireDepartmentSubUnitUserRole role })> subUnits
  }) async {
    return handleAsyncExceptions(() async {
      await _remoteDataSource.sendInvitation(
        email: email,
        name: name,
        role: role,
        rank: rank,
        subUnits: subUnits
      );
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> verifyInviteOtp({
    required String email,
    required String otp
  }) async {
    return handleAsyncExceptions(() async {
      await _remoteDataSource.verifyInviteOtp(
        email: email,
        otp: otp
      );
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    return handleAsyncExceptions(() async {
      await _remoteDataSource.signOut();
      return unit;
    });
  }

  @override
  Stream<Either<Failure, CustomAuthState>> get onAuthStateChange {
    return handleStreamExceptions(() => _remoteDataSource.onAuthStateChange.map((SupabaseAuthState supabaseAuthState) {
      return CustomAuthState.fromSupabaseAuthState(supabaseAuthState);
    }));
  }

  @override
  CustomAuthState get currentAuthState {
    final SupabaseAuthSession? supabaseAuthSession = _remoteDataSource.currentAuthSession;
    return CustomAuthState.fromSupabaseAuthSession(supabaseAuthSession);
  }
}
