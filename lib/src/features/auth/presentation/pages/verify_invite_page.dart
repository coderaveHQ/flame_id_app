import 'package:flutter/material.dart';

import 'package:dartz/dartz.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flame_id_app/src/features/auth/domain/usecases/verify_invite_otp_usecase.dart';
import 'package:flame_id_app/core/common/widgets/custom_pin_put.dart';
import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/src/features/auth/presentation/widgets/auth_form.dart';

class VerifyInvitePage extends ConsumerStatefulWidget {

  final String? email;

  const VerifyInvitePage({ 
    super.key,
    this.email
  });

  @override
  ConsumerState<VerifyInvitePage> createState() => _VerifyInvitePageState();
}

class _VerifyInvitePageState extends ConsumerState<VerifyInvitePage> {

  bool _isVerifyInviteLoading = false;

  late final VerifyInviteOtpUsecase _verifyInviteOtpUsecase;
  
  late final TextEditingController _emailController;
  final TextEditingController _otpController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController(text: widget.email);
    _verifyInviteOtpUsecase = ref.read(verifyInviteOtpUsecaseProvider);
  }

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _otpController.dispose();
  }

  void _handleBack() {
    if (_isVerifyInviteLoading) return;
    context.pop();
  }

  Future<void> _handleVerifyInvite() async {
    if (_isVerifyInviteLoading) return;

    setState(() => _isVerifyInviteLoading = true);

    final Either<Failure, Unit> verifyInviteOtpResult = await _verifyInviteOtpUsecase(
      email: _emailController.text.toLowerCase().trim(),
      otp: _otpController.text.trim()
    );

    verifyInviteOtpResult.fold(
      (Failure failure) {
        if (mounted) {
          failure.showToast(context);
        }
      },
      (Unit _) { }
    );

    if (mounted) setState(() => _isVerifyInviteLoading = false);
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
        subtitle: 'Gib deine E-Mail und den Code ein, den wir dir per E-Mail gesendet haben.',
        children: <Widget>[
          FTextField.email(
            controller: _emailController,
            label: const Text('E-Mail'),
            hint: 'mail@feuerwehr.de'
          ),
          const SizedBox(height: 10.0),
          CustomPinPut(controller: _otpController),
          const SizedBox(height: 20.0),
          FButton(
            onPress: _handleVerifyInvite,
            child: _isVerifyInviteLoading
              ? const FProgress.circularIcon()
              : const Text('Bestätigen')
          )
        ]
      )
    );
  }
}