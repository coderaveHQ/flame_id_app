import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flame_id_app/src/features/main/presentation/pages/main_page.dart';
import 'package:flame_id_app/src/features/auth/presentation/state/custom_auth_state_notifier_provider.dart';
import 'package:flame_id_app/src/features/auth/presentation/pages/sign_in_page.dart';
import 'package:flame_id_app/src/features/certificates/presentation/pages/certificates_page.dart';
import 'package:flame_id_app/src/features/licenses/presentation/pages/licenses_page.dart';
import 'package:flame_id_app/src/features/personal_data/presentation/pages/personal_data_page.dart';
import 'package:flame_id_app/src/features/user_management/presentation/pages/user_management_page.dart';
import 'package:flame_id_app/src/features/vault/presentation/pages/vault_page.dart';

part 'router.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {

  final CustomAuthState initialCustomAuthState = ref.read(customAuthStateNotifierProvider);
  final ValueNotifier<CustomAuthState> customAuthStateNotifier = ValueNotifier<CustomAuthState>(initialCustomAuthState);

  final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: SplashRoute.path,
    routes: $appRoutes,
    refreshListenable: customAuthStateNotifier,
    extraCodec: const ExtraCodec(),
    redirect: (BuildContext context, GoRouterState state) {
      final CustomAuthState currentCustomAuthState = customAuthStateNotifier.value;

      if (!currentCustomAuthState.allowedPaths.contains(state.fullPath)) {
        return currentCustomAuthState.redirectPath;
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

@TypedGoRoute<SplashRoute>(path: SplashRoute.path)
class SplashRoute extends GoRouteData {

  const SplashRoute();

  static const String path = '/';
  static const String fullPath = path;

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;
}

@TypedGoRoute<SignInRoute>(path: SignInRoute.path)
class SignInRoute extends GoRouteData {

  const SignInRoute();

  static const String path = '/sign-in';
  static const String fullPath = path;

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      key: state.pageKey,
      child: const SignInPage()
    );
  }
}

@TypedShellRoute<MainRoute>(
  routes: [
    TypedGoRoute<UserManagementRoute>(path: UserManagementRoute.path),
    TypedGoRoute<PersonalDataRoute>(path: PersonalDataRoute.path),
    TypedGoRoute<CertificatesRoute>(path: CertificatesRoute.path),
    TypedGoRoute<LicensesRoute>(path: LicensesRoute.path),
    TypedGoRoute<VaultRoute>(path: VaultRoute.path)
  ]
)
class MainRoute extends ShellRouteData {

  const MainRoute();

  @override
  Page<void> pageBuilder(BuildContext context, GoRouterState state, Widget navigator) {
    return NoTransitionPage(
      key: state.pageKey,
      child: MainPage(navigator: navigator)
    );
  }
}

class UserManagementRoute extends GoRouteData {

  const UserManagementRoute();

  static const String path = '/user-management';
  static const String fullPath = path;

  static final GlobalKey<NavigatorState> $navigatorKey = shellNavigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      key: state.pageKey,
      child: const UserManagementPage()
    );
  }
}

class PersonalDataRoute extends GoRouteData {

  const PersonalDataRoute();

  static const String path = '/personal-data';
  static const String fullPath = path;

  static final GlobalKey<NavigatorState> $navigatorKey = shellNavigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      key: state.pageKey,
      child: const PersonalDataPage()
    );
  }
}

class CertificatesRoute extends GoRouteData {

  const CertificatesRoute();

  static const String path = '/certificates';
  static const String fullPath = path;

  static final GlobalKey<NavigatorState> $navigatorKey = shellNavigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      key: state.pageKey,
      child: const CertificatesPage()
    );
  }
}

class LicensesRoute extends GoRouteData {

  const LicensesRoute();

  static const String path = '/licenses';
  static const String fullPath = path;

  static final GlobalKey<NavigatorState> $navigatorKey = shellNavigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      key: state.pageKey,
      child: const LicensesPage()
    );
  }
}

class VaultRoute extends GoRouteData {

  const VaultRoute();

  static const String path = '/vault';
  static const String fullPath = path;

  static final GlobalKey<NavigatorState> $navigatorKey = shellNavigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      key: state.pageKey,
      child: const VaultPage()
    );
  }
}