import 'package:flutter/material.dart';

import 'package:dartz/dartz.dart';

import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/core/success/success.dart';
import 'package:flame_id_app/src/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:flame_id_app/src/features/auth/presentation/providers/sign_out_usecase_provider.dart';

class SignOutButton extends StatefulHookConsumerWidget {

  const SignOutButton({ super.key });

  @override
  ConsumerState<SignOutButton> createState() => _SignOutButtonState();
}

class _SignOutButtonState extends ConsumerState<SignOutButton> {

  late final ValueNotifier<bool> _isLoadingNotifier;
  late final SignOutUsecase _signOutUseCase;

  @override
  void initState() {
    super.initState();

    _isLoadingNotifier = ValueNotifier<bool>(false);
    _signOutUseCase = ref.read(signOutUsecaseProvider);
  }

  @override
  void dispose() {
    _isLoadingNotifier.dispose();

    super.dispose();
  }

  Future<void> _handleSignOut() async {
    if (_isLoadingNotifier.value) return;

    _isLoadingNotifier.value = true;

    final Either<Failure, Unit> signOutResult = await _signOutUseCase();

    signOutResult.fold(
      (Failure failure) {
        if (mounted) {
          failure.showToast(context);
        }
      },
      (Unit _) {
        if (mounted) {
          const Success.signedOut().showToast(context);
        }
      }
    );

    _isLoadingNotifier.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return FTooltip(
      tipBuilder: (BuildContext _, FTooltipStyle _, Widget? _) => const Text('Abmelden'),
      child: FButton.icon(
        onPress: _handleSignOut,
        child: _isLoadingNotifier.value
          ? const FProgress.circularIcon()
          : Icon(FIcons.logOut)
      )
    );
  }
}