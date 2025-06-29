import 'package:flutter/material.dart';

import 'package:dartz/dartz.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flame_id_app/core/services/router.dart';
import 'package:flame_id_app/src/features/auth/presentation/widgets/auth_form.dart';
import 'package:flame_id_app/src/features/auth/domain/usecases/reset_password_for_email_usecase.dart';
import 'package:flame_id_app/core/success/success.dart';
import 'package:flame_id_app/core/error/failures/failure.dart';

class ResetPasswordPage extends ConsumerStatefulWidget {
  
  final String? email;

  const ResetPasswordPage({ 
    super.key,
    this.email
  });

  @override
  ConsumerState<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {

  bool _isResetPasswordForEmailLoading = false;

  late final ResetPasswordForEmailUsecase _resetPasswordForEmailUsecase;
  
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();

    _resetPasswordForEmailUsecase = ref.read(resetPasswordForEmailUsecaseProvider);

    _emailController = TextEditingController(text: widget.email);
  }

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
  }

  void _handleBack() {
    if (_isResetPasswordForEmailLoading) return;
    context.pop();
  }

  Future<void> _handleResetPasswordForEmail() async {
    if (_isResetPasswordForEmailLoading) return;

    setState(() => _isResetPasswordForEmailLoading = true);

    final String email = _emailController.text.toLowerCase().trim();

    final Either<Failure, Unit> resetPasswordForEmailResult = await _resetPasswordForEmailUsecase(
      email: email
    );

    await resetPasswordForEmailResult.fold(
      (Failure failure) {
        if (mounted) {
          failure.showToast(context);
        }
      },
      (Unit _) async {
        if (mounted) {
          const Success.resetPasswordEmailSent().showToast(context);
          await VerifyResetPasswordRoute(email).push(context);
        }
      }
    );

    if (mounted) setState(() => _isResetPasswordForEmailLoading = false);
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
        title: 'Passwort zurücksetzen', 
        subtitle: 'Gib deine E-Mail ein, damit wir dir eine E-Mail senden können.', 
        children: <Widget>[
          FTextField.email(
            controller: _emailController,
            label: const Text('E-Mail'),
            hint: 'mail@feuerwehr.de'
          ),
          const SizedBox(height: 20.0),
          FButton(
            onPress: _handleResetPasswordForEmail,
            child: _isResetPasswordForEmailLoading
              ? const FProgress.circularIcon()
              : const Text('Zurücksetzen')
          )
        ]
      )
    );
  }
}