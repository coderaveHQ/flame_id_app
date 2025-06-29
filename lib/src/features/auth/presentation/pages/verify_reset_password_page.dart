import 'package:flutter/material.dart';

import 'package:dartz/dartz.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flame_id_app/core/success/success.dart';
import 'package:flame_id_app/src/features/auth/domain/usecases/resend_reset_password_otp_usecase.dart';
import 'package:flame_id_app/core/common/widgets/custom_pin_put.dart';
import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/src/features/auth/domain/usecases/verify_reset_password_otp_usecase.dart';
import 'package:flame_id_app/src/features/auth/presentation/widgets/auth_form.dart';

class VerifyResetPasswordPage extends ConsumerStatefulWidget {

  final String email;

  const VerifyResetPasswordPage({ 
    super.key,
    required this.email
  });

  @override
  ConsumerState<VerifyResetPasswordPage> createState() => _VerifyResetPasswordPageState();
}

class _VerifyResetPasswordPageState extends ConsumerState<VerifyResetPasswordPage> {

  bool _isVerifyResetPasswordLoading = false;
  bool _isResendResetPasswordOtpLoading = false;

  late final VerifyResetPasswordOtpUsecase _verifyResetPasswordOtpUsecase;
  late final ResendResetPasswordOtpUsecase _resendResetPasswordOtpUsecase;
  
  final TextEditingController _otpController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _verifyResetPasswordOtpUsecase = ref.read(verifyResetPasswordOtpUsecaseProvider);
    _resendResetPasswordOtpUsecase = ref.read(resendResetPasswordOtpUsecaseProvider);
  }

  @override
  void dispose() {
    super.dispose();

    _otpController.dispose();
  }

  void _handleBack() {
    if (_isVerifyResetPasswordLoading || _isResendResetPasswordOtpLoading) return;
    context.pop();
  }

  Future<void> _handleResendResetPasswordOtp() async {
    if (_isVerifyResetPasswordLoading || _isResendResetPasswordOtpLoading) return;

    setState(() => _isResendResetPasswordOtpLoading = true);

    final Either<Failure, Unit> resendResetPasswordOtpResult = await _resendResetPasswordOtpUsecase(
      email: widget.email
    );

    resendResetPasswordOtpResult.fold(
      (Failure failure) {
        if (mounted) {
          failure.showToast(context);
        }
      },
      (Unit _) {
        if (mounted) {
          const Success.resetPasswordEmailSent().showToast(context);
        }
      }
    );

    if (mounted) setState(() => _isResendResetPasswordOtpLoading = false);
  }

  Future<void> _handleVerifyResetPassword() async {
    if (_isVerifyResetPasswordLoading || _isResendResetPasswordOtpLoading) return;

    setState(() => _isVerifyResetPasswordLoading = true);

    final Either<Failure, Unit> verifyResetPasswordOtpResult = await _verifyResetPasswordOtpUsecase(
      email: widget.email,
      otp: _otpController.text.trim()
    );

    verifyResetPasswordOtpResult.fold(
      (Failure failure) {
        if (mounted) {
          failure.showToast(context);
        }
      },
      (Unit _) { }
    );

    if (mounted) setState(() => _isVerifyResetPasswordLoading = false);
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
            onCompleted: (String _) => _handleVerifyResetPassword(),
            controller: _otpController
          ),
          const SizedBox(height: 20.0),
          FButton(
            onPress: _handleVerifyResetPassword,
            child: _isVerifyResetPasswordLoading
              ? const FProgress.circularIcon()
              : const Text('Bestätigen')
          ),
          const SizedBox(height: 10.0),
          _isResendResetPasswordOtpLoading
            ? const FProgress.circularIcon()
            : FTappable(
              onPress: _handleResendResetPasswordOtp,
              child: const Text('Erneut senden')
            )
        ]
      )
    );
  }
}