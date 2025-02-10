import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:flame_id_app/core/utils/decode_jwt.dart';
import 'package:flame_id_app/core/extensions/generic_x.dart';
import 'package:flame_id_app/core/utils/enums/user_role.dart';
import 'package:flame_id_app/core/utils/typedefs.dart';
import 'package:flame_id_app/core/services/router.dart';

part 'custom_auth_state_notifier_provider.g.dart';

@Riverpod(keepAlive: true)
class CustomAuthStateNotifier extends _$CustomAuthStateNotifier {

  late final StreamSubscription<SupabaseAuthState> _supabaseAuthStateSubscription;

  @override
  CustomAuthState build() {
    _initSupabaseAuthListener();

    ref.onDispose(() {
      _cancelSupabaseAuthListener();
    });

    return CustomAuthState.fromCurrentSupabaseAuthState();
  }

  void _initSupabaseAuthListener() {
    _supabaseAuthStateSubscription = Supabase.instance.client.auth.onAuthStateChange.listen((SupabaseAuthState supabaseAuthState) {
      if (supabaseAuthState.event == AuthChangeEvent.initialSession) return;

      state = CustomAuthState.fromSupabaseAuthSession(supabaseAuthState.session);
    });
  }

  void _cancelSupabaseAuthListener() {
    _supabaseAuthStateSubscription.cancel();
  }
}

enum CustomAuthStatus {
  unauthenticated,
  authenticated
}

class CustomAuthState {

  final CustomAuthStatus status;
  final UserRole? role;
  
  const CustomAuthState({
    required this.status,
    this.role
  });

  factory CustomAuthState.fromSupabaseAuthSession(SupabaseAuthSession? supabaseAuthSession) {
    final CustomAuthStatus status = supabaseAuthSession == null ? CustomAuthStatus.unauthenticated : CustomAuthStatus.authenticated;
    final UserRole? role = supabaseAuthSession?.accessToken.whenNotNull((String accessToken) {
      return UserRole.fromDbValue(decodeJwt(accessToken)['user_role'] as String);
    });

    return CustomAuthState(
      status: status,
      role: role
    );
  }

  factory CustomAuthState.fromCurrentSupabaseAuthState() {
    return CustomAuthState.fromSupabaseAuthSession(Supabase.instance.client.auth.currentSession);
  }

  String get redirectPath {
    if (status == CustomAuthStatus.unauthenticated) return SignInRoute.path;
    if (role != UserRole.normal) return UserManagementRoute.path;
    return PersonalDataRoute.path;
  }

  List<String> get allowedPaths {
    if (status == CustomAuthStatus.unauthenticated) return <String>[ SignInRoute.path ];
    return <String>[
      if (role != UserRole.normal) UserManagementRoute.path,
      PersonalDataRoute.path,
      CertificatesRoute.path,
      LicensesRoute.path,
      VaultRoute.path
    ];
  }
}