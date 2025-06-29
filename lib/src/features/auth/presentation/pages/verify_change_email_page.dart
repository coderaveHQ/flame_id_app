import 'package:flutter/material.dart';

import 'package:dartz/dartz.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flame_id_app/core/success/success.dart';
import 'package:flame_id_app/src/features/auth/domain/usecases/resend_change_email_otp_usecase.dart';
import 'package:flame_id_app/core/common/widgets/custom_pin_put.dart';
import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/src/features/auth/domain/usecases/verify_change_email_otp_usecase.dart';
import 'package:flame_id_app/src/features/auth/presentation/widgets/auth_form.dart';

class VerifyChangeEmailPage extends ConsumerStatefulWidget {

  final String newEmail;

  const VerifyChangeEmailPage({ 
    super.key,
    required this.newEmail
  });

  @override
  ConsumerState<VerifyChangeEmailPage> createState() => _VerifyChangeEmailPageState();
}

class _VerifyChangeEmailPageState extends ConsumerState<VerifyChangeEmailPage> {

  bool _isVerifyChangeEmailLoading = false;
  bool _isResendChangeEmailOtpLoading = false;

  late final VerifyChangeEmailOtpUsecase _verifyChangeEmailOtpUsecase;
  late final ResendChangeEmailOtpUsecase _resendChangeEmailOtpUsecase;
  
  final TextEditingController _otpController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _verifyChangeEmailOtpUsecase = ref.read(verifyChangeEmailOtpUsecaseProvider);
    _resendChangeEmailOtpUsecase = ref.read(resendChangeEmailOtpUsecaseProvider);
  }

  @override
  void dispose() {
    super.dispose();

    _otpController.dispose();
  }

  void _handleBack() {
    if (_isVerifyChangeEmailLoading || _isResendChangeEmailOtpLoading) return;
    context.pop();
  }

  Future<void> _handleResendChangeEmailOtp() async {
    if (_isVerifyChangeEmailLoading || _isResendChangeEmailOtpLoading) return;

    setState(() => _isResendChangeEmailOtpLoading = true);

    final Either<Failure, Unit> resendChangeEmailOtpResult = await _resendChangeEmailOtpUsecase(
      newEmail: widget.newEmail
    );

    resendChangeEmailOtpResult.fold(
      (Failure failure) {
        if (mounted) {
          failure.showToast(context);
        }
      },
      (Unit _) {
        if (mounted) {
          const Success.changeEmailEmailSent().showToast(context);
        }
      }
    );

    if (mounted) setState(() => _isResendChangeEmailOtpLoading = false);
  }

  Future<void> _handleVerifyChangeEmail() async {
    if (_isVerifyChangeEmailLoading || _isResendChangeEmailOtpLoading) return;

    setState(() => _isVerifyChangeEmailLoading = true);

    final Either<Failure, Unit> verifyChangeEmailOtpResult = await _verifyChangeEmailOtpUsecase(
      newEmail: widget.newEmail,
      otp: _otpController.text.trim()
    );

    verifyChangeEmailOtpResult.fold(
      (Failure failure) {
        if (mounted) {
          failure.showToast(context);
        }
      },
      (Unit _) {
        if (mounted) {
          context.pop();
        }
      }
    );

    if (mounted) setState(() => _isVerifyChangeEmailLoading = false);
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
        subtitle: 'Gib den Code ein, den wir dir per E-Mail an ${ widget.newEmail } gesendet haben.', 
        children: <Widget>[
          CustomPinPut(
            onCompleted: (String _) => _handleVerifyChangeEmail(),
            controller: _otpController
          ),
          const SizedBox(height: 20.0),
          FButton(
            onPress: _handleVerifyChangeEmail,
            child: _isVerifyChangeEmailLoading
              ? const FProgress.circularIcon()
              : const Text('Bestätigen')
          ),
          const SizedBox(height: 10.0),
          _isResendChangeEmailOtpLoading
            ? const FProgress.circularIcon()
            : FTappable(
              onPress: _handleResendChangeEmailOtp,
              child: const Text('Erneut senden')
            )
        ]
      )
    );
  }
}