import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flame_id_app/src/features/auth/presentation/pages/verify_change_email_page.dart';
import 'package:flame_id_app/src/features/auth/presentation/pages/verify_sign_in_page.dart';
import 'package:flame_id_app/src/features/auth/presentation/pages/verify_reset_password_page.dart';
import 'package:flame_id_app/src/features/auth/presentation/pages/change_password_page.dart';
import 'package:flame_id_app/src/features/auth/presentation/pages/change_email_page.dart';
import 'package:flame_id_app/src/features/auth/presentation/pages/reset_password_page.dart';
import 'package:flame_id_app/core/error/error_page.dart';
import 'package:flame_id_app/src/features/auth/presentation/providers/custom_auth_state_notifier_provider.dart';
import 'package:flame_id_app/src/features/auth/presentation/pages/sign_in_page.dart';
import 'package:flame_id_app/src/features/certificates/presentation/pages/certificates_page.dart';
import 'package:flame_id_app/src/features/chats/presentation/pages/chats_page.dart';
import 'package:flame_id_app/src/features/driving_licenses/presentation/pages/driving_licenses_page.dart';
import 'package:flame_id_app/src/features/drone_licenses/presentation/pages/drone_licenses_page.dart';
import 'package:flame_id_app/src/features/notifications/presentation/pages/notifications_page.dart';
import 'package:flame_id_app/src/features/passwords/presentation/pages/passwords_page.dart';
import 'package:flame_id_app/src/features/personal_data/presentation/pages/personal_data_page.dart';
import 'package:flame_id_app/src/features/settings/presentation/pages/settings_page.dart';
import 'package:flame_id_app/src/features/users/presentation/pages/users_page.dart';
import 'package:flame_id_app/src/main_page.dart';

part 'router.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter router(Ref ref) {

  final CustomAuthState initialCustomAuthState = ref.read(customAuthStateNotifierProvider);
  final ValueNotifier<CustomAuthState> customAuthStateNotifier = ValueNotifier<CustomAuthState>(initialCustomAuthState);

  final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: SplashRoute.path,
    routes: $appRoutes,
    refreshListenable: customAuthStateNotifier,
    extraCodec: const ExtraCodec(),
    errorBuilder: (BuildContext context, GoRouterState state) {
      return ErrorRoute(error: state.error!).build(context, state);
    },
    redirect: (BuildContext context, GoRouterState state) {
      final CustomAuthStatus currentCustomAuthStatus = customAuthStateNotifier.value.status;

      if (!currentCustomAuthStatus.allowedPaths.contains(state.fullPath)) {
        return currentCustomAuthStatus.redirectPath;
      }

      if (state.fullPath == VerifyResetPasswordRoute.fullPath && state.extra == null) {
        return ResetPasswordRoute.fullPath;
      }

      if (state.fullPath == VerifySignInRoute.fullPath && state.extra == null) {
        return SignInRoute.fullPath;
      }

      if (state.fullPath == VerifyChangeEmailRoute.fullPath && state.extra == null) {
        return ChangeEmailRoute.fullPath;
      }

      return null;
    },
  );

  ref
    ..onDispose(() {
      customAuthStateNotifier.dispose();
      router.dispose();
    })
    ..listen(
      customAuthStateNotifierProvider,
      (CustomAuthState? _, CustomAuthState next) => customAuthStateNotifier.value = next
    );

  return router;
}

class ExtraCodec extends Codec<Object?, Object?> {

  const ExtraCodec();

  @override
  Converter<Object?, Object?> get decoder => const ExtraDecoder();

  @override
  Converter<Object?, Object?> get encoder => const ExtraEncoder();
}

class ExtraDecoder extends Converter<Object?, Object?> {

  const ExtraDecoder();

  @override
  Object? convert(Object? input) {
    return null;
  }
}

class ExtraEncoder extends Converter<Object?, Object?> {

  const ExtraEncoder();

  @override
  Object? convert(Object? input) {
    return null;
  }
}

class ErrorRoute extends GoRouteData {

  final Exception error;

  const ErrorRoute({ required this.error });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ErrorPage(error: error);
  }
}

@TypedGoRoute<SplashRoute>(path: SplashRoute.path)
class SplashRoute extends GoRouteData with _$SplashRoute {

  const SplashRoute();

  static const String path = '/';
  static const String fullPath = path;

  static final GlobalKey<NavigatorState> $navigatorKey = rootNavigatorKey;
}

@TypedGoRoute<SignInRoute>(
  path: SignInRoute.path,
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<VerifySignInRoute>(path: VerifySignInRoute.path),
  ]
)
class SignInRoute extends GoRouteData with _$SignInRoute {

  const SignInRoute();

  static const String path = '/sign-in';
  static const String fullPath = path;

  static final GlobalKey<NavigatorState> $navigatorKey = rootNavigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(child: const SignInPage());
  }
}

class VerifySignInRoute extends GoRouteData with _$VerifySignInRoute {
  
  const VerifySignInRoute(this.$extra);

  final String $extra;

  static const String path = 'verify';
  static const String fullPath = '${SignInRoute.fullPath}/$path';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return VerifySignInPage(email: $extra);
  }
}

@TypedGoRoute<ResetPasswordRoute>(
  path: ResetPasswordRoute.path,
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<VerifyResetPasswordRoute>(path: VerifyResetPasswordRoute.path),
  ]
)
class ResetPasswordRoute extends GoRouteData with _$ResetPasswordRoute {

  const ResetPasswordRoute(this.$extra);

  final String? $extra;

  static const String path = '/reset-password';
  static const String fullPath = path;

  static final GlobalKey<NavigatorState> $navigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ResetPasswordPage(email: $extra);
  }
}

class VerifyResetPasswordRoute extends GoRouteData with _$VerifyResetPasswordRoute {
  
  const VerifyResetPasswordRoute(this.$extra);

  final String $extra;

  static const String path = 'verify';
  static const String fullPath = '${ResetPasswordRoute.fullPath}/$path';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return VerifyResetPasswordPage(email: $extra);
  }
}

@TypedShellRoute<MainRoute>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<UsersRoute>(path: UsersRoute.path),
    TypedGoRoute<CertificatesRoute>(path: CertificatesRoute.path),
    TypedGoRoute<DrivingLicensesRoute>(path: DrivingLicensesRoute.path),
    TypedGoRoute<DroneLicensesRoute>(path: DroneLicensesRoute.path),
    TypedGoRoute<ChatsRoute>(path: ChatsRoute.path),
    TypedGoRoute<NotificationsRoute>(path: NotificationsRoute.path),
    TypedGoRoute<PasswordsRoute>(path: PasswordsRoute.path),
    TypedGoRoute<PersonalDataRoute>(path: PersonalDataRoute.path),
    TypedGoRoute<SettingsRoute>(
      path: SettingsRoute.path,
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<ChangeEmailRoute>(
          path: ChangeEmailRoute.path,
          routes: <TypedRoute<RouteData>>[
            TypedGoRoute<VerifyChangeEmailRoute>(path: VerifyChangeEmailRoute.path),
          ]
        ),
        TypedGoRoute<ChangePasswordRoute>(path: ChangePasswordRoute.path)
      ]
    )
  ]
)
class MainRoute extends ShellRouteData {

  const MainRoute();

  static final GlobalKey<NavigatorState> $navigatorKey = shellNavigatorKey;

  @override
  Page<void> pageBuilder(BuildContext context, GoRouterState state, Widget navigator) {
    return NoTransitionPage(child: MainPage(navigator: navigator));
  }
}

class UsersRoute extends GoRouteData with _$UsersRoute {

  const UsersRoute();

  static const String path = '/users';
  static const String fullPath = path;

  static final GlobalKey<NavigatorState> $parentNavigatorKey = shellNavigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(child: const UsersPage());
  }
}

class CertificatesRoute extends GoRouteData with _$CertificatesRoute {

  const CertificatesRoute();

  static const String path = '/certificates';
  static const String fullPath = path;

  static final GlobalKey<NavigatorState> $parentNavigatorKey = shellNavigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(child: const CertificatesPage());
  }
}

class DrivingLicensesRoute extends GoRouteData with _$DrivingLicensesRoute {

  const DrivingLicensesRoute();

  static const String path = '/driving-licenses';
  static const String fullPath = path;

  static final GlobalKey<NavigatorState> $parentNavigatorKey = shellNavigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(child: const DrivingLicensesPage());
  }
}

class DroneLicensesRoute extends GoRouteData with _$DroneLicensesRoute {

  const DroneLicensesRoute();

  static const String path = '/drone-licenses';
  static const String fullPath = path;

  static final GlobalKey<NavigatorState> $parentNavigatorKey = shellNavigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(child: const DroneLicensesPage());
  }
}

class ChatsRoute extends GoRouteData with _$ChatsRoute {

  const ChatsRoute();

  static const String path = '/chats';
  static const String fullPath = path;

  static final GlobalKey<NavigatorState> $parentNavigatorKey = shellNavigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(child: const ChatsPage());
  }
}

class NotificationsRoute extends GoRouteData with _$NotificationsRoute {

  const NotificationsRoute();

  static const String path = '/notifications';
  static const String fullPath = path;

  static final GlobalKey<NavigatorState> $parentNavigatorKey = shellNavigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(child: const NotificationsPage());
  }
}

class PasswordsRoute extends GoRouteData with _$PasswordsRoute {

  const PasswordsRoute();

  static const String path = '/passwords';
  static const String fullPath = path;

  static final GlobalKey<NavigatorState> $parentNavigatorKey = shellNavigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(child: const PasswordsPage());
  }
}

class PersonalDataRoute extends GoRouteData with _$PersonalDataRoute {

  const PersonalDataRoute();

  static const String path = '/personal-data';
  static const String fullPath = path;

  static final GlobalKey<NavigatorState> $parentNavigatorKey = shellNavigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(child: const PersonalDataPage());
  }
}

class SettingsRoute extends GoRouteData with _$SettingsRoute {

  const SettingsRoute();

  static const String path = '/settings';
  static const String fullPath = path;

  static final GlobalKey<NavigatorState> $parentNavigatorKey = shellNavigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(child: const SettingsPage());
  }
}

class ChangeEmailRoute extends GoRouteData with _$ChangeEmailRoute {

  const ChangeEmailRoute();

  static const String path = 'change-email';
  static const String fullPath = '${SettingsRoute.fullPath}/$path';

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ChangeEmailPage(key: state.pageKey);
  }
}

class VerifyChangeEmailRoute extends GoRouteData with _$VerifyChangeEmailRoute {
  
  const VerifyChangeEmailRoute(this.$extra);

  final String $extra;

  static const String path = 'verify';
  static const String fullPath = '${ChangeEmailRoute.fullPath}/$path';

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return VerifyChangeEmailPage(newEmail: $extra);
  }
}

class ChangePasswordRoute extends GoRouteData with _$ChangePasswordRoute {
  
  const ChangePasswordRoute();

  static const String path = 'change-password';
  static const String fullPath = '${SettingsRoute.fullPath}/$path';

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ChangePasswordPage(key: state.pageKey);
  }
}