import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dartz/dartz.dart';

import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/src/features/deep_links/domain/entities/deep_link_entity.dart';
import 'package:flame_id_app/src/features/deep_links/presentation/providers/deep_links_stream_provider.dart';
import 'package:flame_id_app/core/services/router.dart';
import 'package:flame_id_app/core/success/success.dart';
import 'package:flame_id_app/core/utils/typedefs.dart';
import 'package:flame_id_app/src/features/auth/presentation/providers/custom_auth_state_notifier_provider.dart';

class App extends ConsumerWidget {
  
  const App({ super.key });

  Future<void> _handleCustomAuthStateNotifierProviderChange(
    BuildContext context,
    GoRouter router,
    CustomAuthState? last,
    CustomAuthState next
  ) async {
    switch (next.event) {
      case SupabaseAuthChangeEvent.signedIn:
        if (next.user?.invitedAt != null && 
          (next.user?.confirmedAt != null && next.user?.lastSignInAt != null) &&
          next.user!.confirmedAt!.difference(next.user!.lastSignInAt!).inSeconds.abs() <= 10) {
          const Success.signedIn().showToast(context);
          await router.push(ChangePasswordRoute.fullPath);
          break;
        }
        
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
        await router.push(ChangePasswordRoute.fullPath);
        break;
      default:
        break;
    }
  }

  void _handleDeepLinkStreamProviderChange(
    BuildContext context,
    AsyncValue<Either<Failure, DeepLinkEntity>> next
  ) {
    if (!next.hasValue || next.value!.isLeft()) return;

    next.value!.fold(
    (Failure _) { }, 
    (DeepLinkEntity deepLink) {
      print(deepLink.hasEmptyPath);
      print(deepLink.queryParams.toString());
      if (deepLink.hasEmptyPath && deepLink.queryParams.containsKey('invite-verified')) {
        const Success.inviteVerified().showToast(context);
      }
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final GoRouter router = ref.watch(routerProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      builder: (BuildContext _, Widget? child) => FTheme(
        data: FThemes.zinc.light,
        child: FToaster(
          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              ref.listen(customAuthStateNotifierProvider, (CustomAuthState? last, CustomAuthState next) => _handleCustomAuthStateNotifierProviderChange(context, router, last, next));
              ref.listen(deepLinksStreamProvider, (AsyncValue<Either<Failure, DeepLinkEntity>>? _, AsyncValue<Either<Failure, DeepLinkEntity>> next) => _handleDeepLinkStreamProviderChange(context, next));
              return child!;
            },
            child: child
          )
        )
      )
    );
  }
}