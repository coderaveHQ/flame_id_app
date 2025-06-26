import 'package:flutter/material.dart';

import 'package:dartz/dartz.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flame_id_app/src/features/auth/presentation/widgets/auth_form.dart';
import 'package:flame_id_app/core/services/router.dart';
import 'package:flame_id_app/core/success/success.dart';
import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/src/features/auth/domain/usecases/sign_in_with_email_and_password_usecase.dart';
import 'package:flame_id_app/src/features/auth/presentation/providers/sign_in_with_email_and_password_usecase_provider.dart';

class SignInPage extends ConsumerStatefulWidget {

  const SignInPage({ super.key });

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {

  bool _isSignInWithEmailAndPasswordLoading = false;

  late final SignInWithEmailAndPasswordUsecase _signInWithEmailAndPasswordUseCase;
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _signInWithEmailAndPasswordUseCase = ref.read(signInWithEmailAndPasswordUsecaseProvider);
  }

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
  }

  Future<void> _handleSignInWithEmailAndPassword() async {
    if (_isSignInWithEmailAndPasswordLoading) return;

    setState(() => _isSignInWithEmailAndPasswordLoading = true);

    final Either<Failure, Unit> signInResult = await _signInWithEmailAndPasswordUseCase(
      email: _emailController.text.toLowerCase().trim(),
      password: _passwordController.text.trim()
    );

    signInResult.fold(
      (Failure failure) {
        if (mounted) {
          failure.showToast(context);
        }
      },
      (Unit _) {
        if (mounted) {
          const Success.signedIn().showToast(context);
        }
      }
    );

    setState(() => _isSignInWithEmailAndPasswordLoading = false);
  }

  Future<void> _handleForgotPassword() async {
    if (_isSignInWithEmailAndPasswordLoading) return;
    const ResetPasswordRoute().push(context);
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      child: AuthForm(
        title: 'Anmeldung',
        subtitle: 'Melde dich mit deinen Anmeldedaten an, um alle Funktionen freizuschalten.',
        children: <Widget>[
          FTextField.email(
            controller: _emailController,
            label: const Text('E-Mail'),
            hint: 'mail@feuerwehr.de'
          ),
          const SizedBox(height: 10.0),
          FTextField.password(
            controller: _passwordController,
            label: const Text('Passwort')
          ),
          const SizedBox(height: 10.0),
          Align(
            alignment: Alignment.centerRight,
            child: FTappable(
              onPress: _handleForgotPassword,
              child: const Text('Passwort vergessen?')
            )
          ),
          const SizedBox(height: 20.0),
          FButton(
            onPress: _handleSignInWithEmailAndPassword,
            child: _isSignInWithEmailAndPasswordLoading
              ? const FProgress.circularIcon()
              : const Text('Anmelden')
          )
        ]
      )
    );
  }
}