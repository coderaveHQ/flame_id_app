import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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

      return null;
    }
  );

  ref
    ..onDispose(() {
      customAuthStateNotifier.dispose();
      router.dispose();
    })
    ..listen(
      customAuthStateNotifierProvider, 
      (CustomAuthState? last, CustomAuthState next) => customAuthStateNotifier.value = next
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

  const ErrorRoute({
    required this.error
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ErrorPage(error: error);
  }
}

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

@TypedGoRoute<SplashRoute>(path: SplashRoute.path)
class SplashRoute extends GoRouteData with _$SplashRoute {

  const SplashRoute();

  static const String path = '/';
  static const String fullPath = path;
}

@TypedGoRoute<SignInRoute>(path: SignInRoute.path)
class SignInRoute extends GoRouteData with _$SignInRoute {

  const SignInRoute();

  static const String path = '/sign-in';
  static const String fullPath = path;

  static final GlobalKey<NavigatorState> $navigatorKey = rootNavigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      key: state.pageKey,
      child: const SignInPage()
    );
  }
}

@TypedGoRoute<ResetPasswordRoute>(path: ResetPasswordRoute.path)
class ResetPasswordRoute extends GoRouteData with _$ResetPasswordRoute {

  const ResetPasswordRoute();

  static const String path = '/reset-password';
  static const String fullPath = path;

  static final GlobalKey<NavigatorState> $navigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ResetPasswordPage();
  }
}

final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

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
    TypedGoRoute<SettingsRoute>(path: SettingsRoute.path)
  ]
)
class MainRoute extends ShellRouteData {

  const MainRoute();

  static final GlobalKey<NavigatorState> $navigatorKey = shellNavigatorKey;

  @override
  Page<void> pageBuilder(BuildContext context, GoRouterState state, Widget navigator) {
    return NoTransitionPage(
      key: state.pageKey,
      child: MainPage(navigator: navigator)
    );
  }
}

class UsersRoute extends GoRouteData with _$UsersRoute {

  const UsersRoute();

  static const String path = '/users';
  static const String fullPath = path;

  static final GlobalKey<NavigatorState> $parentNavigatorKey = shellNavigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      key: state.pageKey,
      child: const UsersPage()
    );
  }
}

class CertificatesRoute extends GoRouteData with _$CertificatesRoute {

  const CertificatesRoute();

  static const String path = '/certificates';
  static const String fullPath = path;

  static final GlobalKey<NavigatorState> $parentNavigatorKey = shellNavigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      key: state.pageKey,
      child: const CertificatesPage()
    );
  }
}

class DrivingLicensesRoute extends GoRouteData with _$DrivingLicensesRoute {

  const DrivingLicensesRoute();

  static const String path = '/driving-licenses';
  static const String fullPath = path;

  static final GlobalKey<NavigatorState> $parentNavigatorKey = shellNavigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      key: state.pageKey,
      child: const DrivingLicensesPage()
    );
  }
}

class DroneLicensesRoute extends GoRouteData with _$DroneLicensesRoute {

  const DroneLicensesRoute();

  static const String path = '/drone-licenses';
  static const String fullPath = path;

  static final GlobalKey<NavigatorState> $parentNavigatorKey = shellNavigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      key: state.pageKey,
      child: const DroneLicensesPage()
    );
  }
}

class ChatsRoute extends GoRouteData with _$ChatsRoute {

  const ChatsRoute();

  static const String path = '/chats';
  static const String fullPath = path;

  static final GlobalKey<NavigatorState> $parentNavigatorKey = shellNavigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      key: state.pageKey,
      child: const ChatsPage()
    );
  }
}

class NotificationsRoute extends GoRouteData with _$NotificationsRoute {

  const NotificationsRoute();

  static const String path = '/notifications';
  static const String fullPath = path;

  static final GlobalKey<NavigatorState> $parentNavigatorKey = shellNavigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      key: state.pageKey,
      child: const NotificationsPage()
    );
  }
}

class PasswordsRoute extends GoRouteData with _$PasswordsRoute {

  const PasswordsRoute();

  static const String path = '/passwords';
  static const String fullPath = path;

  static final GlobalKey<NavigatorState> $parentNavigatorKey = shellNavigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      key: state.pageKey,
      child: const PasswordsPage()
    );
  }
}

class PersonalDataRoute extends GoRouteData with _$PersonalDataRoute {

  const PersonalDataRoute();

  static const String path = '/personal-data';
  static const String fullPath = path;

  static final GlobalKey<NavigatorState> $parentNavigatorKey = shellNavigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      key: state.pageKey,
      child: const PersonalDataPage()
    );
  }
}

class SettingsRoute extends GoRouteData with _$SettingsRoute {

  const SettingsRoute();

  static const String path = '/settings';
  static const String fullPath = path;

  static final GlobalKey<NavigatorState> $parentNavigatorKey = shellNavigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      key: state.pageKey,
      child: const SettingsPage()
    );
  }
}