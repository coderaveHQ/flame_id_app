import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dartz/dartz.dart';

import 'package:flame_id_app/core/services/router.dart';
import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/core/success/success.dart';
import 'package:flame_id_app/src/features/auth/presentation/widgets/auth_form.dart';
import 'package:flame_id_app/src/features/auth/domain/usecases/change_email_usecase.dart';

class ChangeEmailPage extends ConsumerStatefulWidget {

  const ChangeEmailPage({super.key});

  @override
  ConsumerState<ChangeEmailPage> createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends ConsumerState<ChangeEmailPage> {

  bool _isChangeEmailLoading = false;

  late final ChangeEmailUsecase _changeEmailUseCase;
  
  final TextEditingController _newEmailController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _changeEmailUseCase = ref.read(changeEmailUsecaseProvider);
  }

  @override
  void dispose() {
    super.dispose();

    _newEmailController.dispose();
  }

  void _handleBack() {
    if (_isChangeEmailLoading) return;
    context.pop();
  }

  Future<void> _handleChangeEmail() async {
    if (_isChangeEmailLoading) return;

    setState(() => _isChangeEmailLoading = true);

    final String newEmail = _newEmailController.text.toLowerCase().trim();

    final Either<Failure, Unit> changeEmailResult = await _changeEmailUseCase(
      newEmail: newEmail
    );

    await changeEmailResult.fold(
      (Failure failure) {
        if (mounted) {
          failure.showToast(context);
        }
      },
      (Unit _) async {
        if (mounted) {
          const Success.changeEmailEmailSent().showToast(context);
          VerifyChangeEmailRoute(newEmail).pushReplacement(context);
        }
      }
    );

    if (mounted) setState(() => _isChangeEmailLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: const Text('E-Mail ändern'),
        prefixes: [
          FHeaderAction.back(onPress: _handleBack)
        ]
      ),
      child: AuthForm(
        title: 'E-Mail ändern', 
        subtitle: 'Gib die neue E-Mail ein, die du zur Anmeldung nutzen möchtest.', 
        children: <Widget>[
          FTextField.email(
            controller: _newEmailController,
            label: const Text('Neue E-Mail'),
            hint: 'mail@feuerwehr.de'
          ),
          const SizedBox(height: 20.0),
          FButton(
            onPress: _handleChangeEmail,
            child: _isChangeEmailLoading
              ? const FProgress.circularIcon()
              : const Text('Ändern')
          )
        ]
      )
    );
  }
}