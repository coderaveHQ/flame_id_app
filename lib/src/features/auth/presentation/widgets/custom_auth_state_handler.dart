import 'dart:async';

import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flame_id_app/core/success/success.dart';
import 'package:flame_id_app/core/utils/typedefs.dart';
import 'package:flame_id_app/src/features/auth/presentation/providers/custom_auth_state_notifier_provider.dart';
import 'package:flame_id_app/core/services/router.dart';

class CustomAuthStateHandler extends ConsumerWidget {

  final Widget child;

  const CustomAuthStateHandler({ 
    super.key,
    required this.child
  });

  Future<void> _handleCustomAuthStateNotifierProviderChange(BuildContext context, CustomAuthState? last, CustomAuthState next) async {
    switch (next.event) {
      case SupabaseAuthChangeEvent.signedIn:
        if (next.user?.email == last?.user?.newEmail) {
          const Success.emailChanged().showToast(context);
          break;
        }

        const Success.signedIn().showToast(context);
        break;
      case SupabaseAuthChangeEvent.signedOut:
        const Success.signedOut().showToast(context);
        break;
      case SupabaseAuthChangeEvent.passwordRecovery:
        const Success.signedIn().showToast(context);
        await ChangePasswordRoute().push(context);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(customAuthStateNotifierProvider, (CustomAuthState? last, CustomAuthState next) => _handleCustomAuthStateNotifierProviderChange(context, last, next));
    return child;
  }
}