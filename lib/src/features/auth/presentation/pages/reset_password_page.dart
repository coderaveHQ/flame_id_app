import 'package:flutter/material.dart';

import 'package:dartz/dartz.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flame_id_app/src/features/auth/presentation/widgets/auth_form.dart';
import 'package:flame_id_app/src/features/auth/presentation/providers/reset_password_for_email_usecase_provider.dart';
import 'package:flame_id_app/src/features/auth/domain/usecases/reset_password_for_email_usecase.dart';
import 'package:flame_id_app/core/success/success.dart';
import 'package:flame_id_app/core/error/failures/failure.dart';

class ResetPasswordPage extends ConsumerStatefulWidget {

  const ResetPasswordPage({ super.key });

  @override
  ConsumerState<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {

  bool _isResetPasswordForEmailLoading = false;

  late final ResetPasswordForEmailUsecase _resetPasswordForEmailUseCase;
  
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _resetPasswordForEmailUseCase = ref.read(resetPasswordForEmailUsecaseProvider);
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

    final Either<Failure, Unit> resetPasswordResult = await _resetPasswordForEmailUseCase(
      email: _emailController.text.toLowerCase().trim()
    );

    resetPasswordResult.fold(
      (Failure failure) {
        if (mounted) {
          failure.showToast(context);
        }
      },
      (Unit _) {
        if (mounted) {
          const Success.resetPasswordEmailSent().showToast(context);
          context.pop();
        }
      }
    );

    setState(() => _isResetPasswordForEmailLoading = false);
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