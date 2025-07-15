import 'package:flutter/material.dart';

import 'package:dartz/dartz.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flame_id_app/core/success/success.dart';
import 'package:flame_id_app/src/features/auth/domain/usecases/sign_in_with_otp_usecase.dart';
import 'package:flame_id_app/src/features/auth/presentation/widgets/auth_form.dart';
import 'package:flame_id_app/core/services/router.dart';
import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/src/features/auth/domain/usecases/sign_in_with_email_and_password_usecase.dart';

class SignInPage extends ConsumerStatefulWidget {

  const SignInPage({ super.key });

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {

  bool _isSignInWithEmailAndPasswordLoading = false;
  bool _isSignInWithOtpLoading = false;
  bool _useSignInWithOtp = true;

  late final SignInWithEmailAndPasswordUsecase _signInWithEmailAndPasswordUseCase;
  late final SignInWithOtpUsecase _signInWithOtpUseCase;
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _signInWithEmailAndPasswordUseCase = ref.read(signInWithEmailAndPasswordUsecaseProvider);
    _signInWithOtpUseCase = ref.read(signInWithOtpUsecaseProvider);
  }

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
  }

  void _handleUseSignInWithEmailAndPassword() {
    if (_isSignInWithOtpLoading) return;
    setState(() => _useSignInWithOtp = false);
  }

  void _handleUseSignInWithOtp() {
    if (_isSignInWithEmailAndPasswordLoading) return;
    setState(() => _useSignInWithOtp = true);
  }

  Future<void> _handleVerifyInvite() async {
    if (_isSignInWithEmailAndPasswordLoading || _isSignInWithOtpLoading) return;

    final String email = _emailController.text.toLowerCase().trim();
    await VerifyInviteRoute(email).push(context);
  }

  Future<void> _handleSignInWithEmailAndPassword() async {
    if (_isSignInWithEmailAndPasswordLoading || _isSignInWithOtpLoading) return;

    setState(() => _isSignInWithEmailAndPasswordLoading = true);

    final Either<Failure, Unit> signInWithEmailAndPasswordResult = await _signInWithEmailAndPasswordUseCase(
      email: _emailController.text.toLowerCase().trim(),
      password: _passwordController.text.trim()
    );

    signInWithEmailAndPasswordResult.fold(
      (Failure failure) {
        if (mounted) {
          failure.showToast(context);
        }
      },
      (Unit _) { }
    );

    if (mounted) setState(() => _isSignInWithEmailAndPasswordLoading = false);
  }

  Future<void> _handleSignInWithOtp() async {
    if (_isSignInWithEmailAndPasswordLoading || _isSignInWithOtpLoading) return;

    setState(() => _isSignInWithOtpLoading = true);

    final String email = _emailController.text.toLowerCase().trim();

    final Either<Failure, Unit> signInWithOtpResult = await _signInWithOtpUseCase(
      email: email
    );

    await signInWithOtpResult.fold(
      (Failure failure) {
        if (mounted) {
          failure.showToast(context);
        }
      },
      (Unit _) async {
        if (mounted) {
          const Success.signInWithOtpEmailSent().showToast(context);
          await VerifySignInRoute(email).push(context);
        }
      }
    );

    if (mounted) setState(() => _isSignInWithOtpLoading = false);
  }

  Future<void> _handleForgotPassword() async {
    if (_isSignInWithEmailAndPasswordLoading || _isSignInWithOtpLoading) return;

    final String email = _emailController.text.toLowerCase().trim();
    await ResetPasswordRoute(email).push(context);
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
          if (!_useSignInWithOtp) const SizedBox(height: 10.0),
          if (!_useSignInWithOtp) FTextField.password(
            controller: _passwordController,
            label: const Text('Passwort')
          ),
          if (!_useSignInWithOtp) const SizedBox(height: 10.0),
          if (!_useSignInWithOtp) Align(
            alignment: Alignment.centerRight,
            child: FTappable(
              onPress: _handleForgotPassword,
              child: const Text('Passwort vergessen?')
            )
          ),
          const SizedBox(height: 20.0),
          _useSignInWithOtp
            ? FButton(
              onPress: _handleSignInWithOtp,
              child: _isSignInWithOtpLoading
                ? const FProgress.circularIcon()
                : const Text('Anmeldungs-Link senden')
            )
            : FButton(
            onPress: _handleSignInWithEmailAndPassword,
            child: _isSignInWithEmailAndPasswordLoading
              ? const FProgress.circularIcon()
              : const Text('Anmelden')
          ),
          const SizedBox(height: 10.0),
          _useSignInWithOtp 
            ? FButton(
              onPress: _handleUseSignInWithEmailAndPassword,
              style: FButtonStyle.secondary(),
              child: const Text('Passwort verwenden')
            )
            : FButton(
              onPress: _handleUseSignInWithOtp,
              style: FButtonStyle.secondary(),
              child: const Text('Anmeldungs-Link verwenden')
            ),
          const SizedBox(height: 10.0),
          FButton(
            onPress: _handleVerifyInvite,
            style: FButtonStyle.outline(),
            child: const Text('Einladungs-Code erhalten')
          )
        ]
      )
    );
  }
}