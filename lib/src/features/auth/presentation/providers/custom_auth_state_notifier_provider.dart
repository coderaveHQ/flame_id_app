import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flame_id_app/core/extensions/generic_x.dart';
import 'package:flame_id_app/src/features/auth/domain/usecases/on_auth_state_change_usecase.dart';
import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/core/utils/typedefs.dart';
import 'package:flame_id_app/src/features/auth/domain/usecases/current_auth_state_usecase.dart';
import 'package:flame_id_app/core/services/router.dart';

part 'custom_auth_state_notifier_provider.g.dart';

@riverpod
class CustomAuthStateNotifier extends _$CustomAuthStateNotifier {

  late final StreamSubscription<Either<Failure, CustomAuthState>> _authStateSubscription;

  @override
  CustomAuthState build() {
    _initAuthStateListener();

    ref.onDispose(() {
      _cancelAuthStateListener();
    });

    final CurrentAuthStateUsecase currentAuthStateUsecase = ref.read(currentAuthStateUsecaseProvider);
    return currentAuthStateUsecase();
  }

  void _initAuthStateListener() {
    _authStateSubscription = ref.read(onAuthStateChangeUsecaseProvider).call().listen(
      (Either<Failure, CustomAuthState> result) {
        result.fold(
          (Failure failure) { },
          (CustomAuthState authState) => state = authState
        );
      }
    );
  }

  void _cancelAuthStateListener() {
    _authStateSubscription.cancel();
  }
}

enum CustomAuthStatus {

  unauthenticated(
    redirectPath: SignInRoute.fullPath,
    allowedPaths: <String>[
      SignInRoute.fullPath,
      VerifySignInRoute.fullPath,
      ResetPasswordRoute.fullPath,
      VerifyResetPasswordRoute.fullPath
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
      UsersRoute.fullPath,
      SettingsRoute.fullPath,
      ChangeEmailRoute.fullPath,
      VerifyChangeEmailRoute.fullPath,
      ChangePasswordRoute.fullPath
    ]
  );

  final String redirectPath;
  final List<String> allowedPaths;

  const CustomAuthStatus({
    required this.redirectPath,
    required this.allowedPaths
  });
}

class CustomAuthUser extends Equatable {

  final String email;
  final String? newEmail;

  const CustomAuthUser({
    required this.email,
    this.newEmail
  });

  factory CustomAuthUser.fromSupabaseAuthSession(SupabaseAuthSession session) {
    return CustomAuthUser(
      email: session.user.email!,
      newEmail: session.user.newEmail
    );
  }

  @override
  List<Object?> get props => [ 
    email,
    newEmail
  ];
}

class CustomAuthState extends Equatable {

  final CustomAuthStatus status;
  final CustomAuthUser? user;
  final SupabaseAuthChangeEvent? event;
  
  const CustomAuthState({
    required this.status,
    this.user,
    this.event
  });

  @override
  List<Object?> get props => [ 
    status,
    user,
    event
  ];

  factory CustomAuthState.fromSupabaseAuthSession(
    SupabaseAuthSession? supabaseAuthSession, {
    SupabaseAuthChangeEvent? event
  }) {
    final CustomAuthStatus status = supabaseAuthSession == null ? CustomAuthStatus.unauthenticated : CustomAuthStatus.authenticated;
    final CustomAuthUser? user = supabaseAuthSession.whenNotNull((SupabaseAuthSession session) => CustomAuthUser.fromSupabaseAuthSession(session));
    return CustomAuthState(
      status: status,
      user: user,
      event: event
    );
  }

  factory CustomAuthState.fromSupabaseAuthState(SupabaseAuthState supabaseAuthState) {
    return CustomAuthState.fromSupabaseAuthSession(
      supabaseAuthState.session,
      event: supabaseAuthState.event
    );
  }
}

/*

At start:
------------
flutter: confirmationSentAt: null
flutter: email: fleeser@coderave.dev
flutter: newEmail: null
flutter: emailChangeSentAt: null
flutter: emailConfirmedAt: 2025-06-29T17:55:44.613679Z

When E-Mail sent:
-------------------
flutter: confirmationSentAt: null
flutter: email: fleeser@coderave.dev
flutter: newEmail: florian.leeser@icloud.com
flutter: emailChangeSentAt: 2025-06-29T17:59:12.471916211Z
flutter: emailConfirmedAt: 2025-06-29T17:55:44.613679Z

When done:
-------------------
flutter: confirmationSentAt: null
flutter: email: florian.leeser@icloud.com
flutter: newEmail: null
flutter: emailChangeSentAt: 2025-06-29T17:59:12.471916Z
flutter: emailConfirmedAt: 2025-06-29T17:55:44.613679Z
*/