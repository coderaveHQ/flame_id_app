import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/src/features/auth/presentation/providers/on_auth_state_changes_usecase_provider.dart';
import 'package:flame_id_app/core/utils/typedefs.dart';
import 'package:flame_id_app/core/services/router.dart';

part 'custom_auth_state_notifier_provider.g.dart';

@riverpod
class CustomAuthStateNotifier extends _$CustomAuthStateNotifier {

  late final StreamSubscription<Either<Failure, CustomAuthState>> _supabaseAuthStateSubscription;

  @override
  CustomAuthState build() {
    _initSupabaseAuthListener();

    ref.onDispose(() {
      _cancelSupabaseAuthListener();
    });

    return CustomAuthState.fromCurrentSupabaseAuthState();
  }

  void _initSupabaseAuthListener() {
    _supabaseAuthStateSubscription = ref.watch(onAuthStateChangesUsecaseProvider).call().listen(
      (Either<Failure, CustomAuthState> result) {
        result.fold(
          (Failure failure) { },
          (CustomAuthState authState) => state = authState
        );
      }
    );
  }

  void _cancelSupabaseAuthListener() {
    _supabaseAuthStateSubscription.cancel();
  }
}

enum CustomAuthStatus {

  unauthenticated(
    redirectPath: SignInRoute.fullPath,
    allowedPaths: <String>[
      SignInRoute.fullPath,
      ResetPasswordRoute.fullPath
    ]
  ),
  authenticated(
    redirectPath: NotificationsRoute.fullPath,
    allowedPaths: <String>[
      ResetPasswordRoute.fullPath,
      CertificatesRoute.fullPath,
      ChatsRoute.fullPath,
      DrivingLicensesRoute.fullPath,
      DroneLicensesRoute.fullPath,
      NotificationsRoute.fullPath,
      PasswordsRoute.fullPath,
      PersonalDataRoute.fullPath,
      SettingsRoute.fullPath,
      UsersRoute.fullPath
    ]
  );

  final String redirectPath;
  final List<String> allowedPaths;

  const CustomAuthStatus({
    required this.redirectPath,
    required this.allowedPaths
  });
}

class CustomAuthState extends Equatable {

  final CustomAuthStatus status;
  
  const CustomAuthState({
    required this.status
  });

  factory CustomAuthState.fromSupabaseAuthSession(SupabaseAuthSession? supabaseAuthSession) {
    final CustomAuthStatus status = supabaseAuthSession == null ? CustomAuthStatus.unauthenticated : CustomAuthStatus.authenticated;
    return CustomAuthState(status: status);
  }

  factory CustomAuthState.fromCurrentSupabaseAuthState() {
    return CustomAuthState.fromSupabaseAuthSession(Supabase.instance.client.auth.currentSession);
  }

  @override
  List<Object?> get props => [ status ];
}