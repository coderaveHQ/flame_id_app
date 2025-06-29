import 'package:flutter/material.dart';

import 'package:dartz/dartz.dart';

import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flame_id_app/src/features/auth/presentation/widgets/sign_out_button_alert.dart';
import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/src/features/auth/domain/usecases/sign_out_usecase.dart';

class SignOutButton extends ConsumerStatefulWidget {

  const SignOutButton({ super.key });

  @override
  ConsumerState<SignOutButton> createState() => _SignOutButtonState();
}

class _SignOutButtonState extends ConsumerState<SignOutButton> {

  bool _isSignOutLoading = false;

  late final SignOutUsecase _signOutUseCase;

  @override
  void initState() {
    super.initState();

    _signOutUseCase = ref.read(signOutUsecaseProvider);
  }

  Future<void> _handleSignOut() async {
    if (_isSignOutLoading) return;

    final bool shouldSignOut = await showSignOutButtonAlert(context);
    if (!shouldSignOut) return;

    setState(() => _isSignOutLoading = true);

    final Either<Failure, Unit> signOutResult = await _signOutUseCase();

    signOutResult.fold(
      (Failure failure) {
        if (mounted) {
          failure.showToast(context);
        }
      },
      (Unit _) { }
    );

    if (mounted) setState(() => _isSignOutLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return FTooltip(
      tipBuilder: (BuildContext _, FTooltipStyle _, Widget? _) => const Text('Abmelden'),
      child: FButton.icon(
        onPress: _handleSignOut,
        child: _isSignOutLoading
          ? const FProgress.circularIcon()
          : Icon(FIcons.logOut)
      )
    );
  }
}