import 'package:flutter/material.dart';

import 'package:dartz/dartz.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flame_id_app/core/success/success.dart';
import 'package:flame_id_app/src/features/auth/domain/usecases/resend_sign_in_otp_usecase.dart';
import 'package:flame_id_app/src/features/auth/domain/usecases/verify_sign_in_otp_usecase.dart';
import 'package:flame_id_app/core/common/widgets/custom_pin_put.dart';
import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/src/features/auth/presentation/widgets/auth_form.dart';

class VerifySignInPage extends ConsumerStatefulWidget {

  final String email;

  const VerifySignInPage({ 
    super.key,
    required this.email
  });

  @override
  ConsumerState<VerifySignInPage> createState() => _VerifySignInPageState();
}

class _VerifySignInPageState extends ConsumerState<VerifySignInPage> {

  bool _isVerifySignInLoading = false;
  bool _isResendSignInOtpLoading = false;

  late final VerifySignInOtpUsecase _verifySignInOtpUsecase;
  late final ResendSignInOtpUsecase _resendSignInOtpUsecase;
  
  final TextEditingController _otpController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _verifySignInOtpUsecase = ref.read(verifySignInOtpUsecaseProvider);
    _resendSignInOtpUsecase = ref.read(resendSignInOtpUsecaseProvider);
  }

  @override
  void dispose() {
    super.dispose();

    _otpController.dispose();
  }

  void _handleBack() {
    if (_isVerifySignInLoading || _isResendSignInOtpLoading) return;
    context.pop();
  }

  Future<void> _handleResendSignInOtp() async {
    if (_isVerifySignInLoading || _isResendSignInOtpLoading) return;

    setState(() => _isResendSignInOtpLoading = true);

    final Either<Failure, Unit> resendSignInOtpResult = await _resendSignInOtpUsecase(
      email: widget.email
    );

    resendSignInOtpResult.fold(
      (Failure failure) {
        if (mounted) {
          failure.showToast(context);
        }
      },
      (Unit _) {
        if (mounted) {
          const Success.signInWithOtpEmailSent().showToast(context);
        }
      }
    );

    if (mounted) setState(() => _isResendSignInOtpLoading = false);
  }

  Future<void> _handleVerifySignIn() async {
    if (_isVerifySignInLoading || _isResendSignInOtpLoading) return;

    setState(() => _isVerifySignInLoading = true);

    final Either<Failure, Unit> verifySignInOtpResult = await _verifySignInOtpUsecase(
      email: widget.email,
      otp: _otpController.text.trim()
    );

    verifySignInOtpResult.fold(
      (Failure failure) {
        if (mounted) {
          failure.showToast(context);
        }
      },
      (Unit _) { }
    );

    if (mounted) setState(() => _isVerifySignInLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        prefixes: [
          FHeaderAction.back(onPress: _handleBack)
        ]
      ),
      child: AuthForm(
        withTopPadding: false,
        title: 'Bestätigung',
        subtitle: 'Gib den Code ein, den wir dir per E-Mail an ${ widget.email } gesendet haben.', 
        children: <Widget>[
          CustomPinPut(
            onCompleted: (String _) => _handleVerifySignIn(),
            controller: _otpController
          ),
          const SizedBox(height: 20.0),
          FButton(
            onPress: _handleVerifySignIn,
            child: _isVerifySignInLoading
              ? const FProgress.circularIcon()
              : const Text('Bestätigen')
          ),
          const SizedBox(height: 10.0),
          _isResendSignInOtpLoading
            ? const FProgress.circularIcon()
            : FTappable(
              onPress: _handleResendSignInOtp,
              child: const Text('Erneut senden')
            )
        ]
      )
    );
  }
}