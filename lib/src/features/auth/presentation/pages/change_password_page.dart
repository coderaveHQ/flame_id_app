import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dartz/dartz.dart';

import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:flame_id_app/core/success/success.dart';
import 'package:flame_id_app/src/features/auth/presentation/widgets/auth_form.dart';
import 'package:flame_id_app/src/features/auth/domain/usecases/change_password_usecase.dart';

class ChangePasswordPage extends ConsumerStatefulWidget {

  const ChangePasswordPage({super.key});

  @override
  ConsumerState<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends ConsumerState<ChangePasswordPage> {

  bool _isChangePasswordLoading = false;

  late final ChangePasswordUsecase _changePasswordUseCase;
  
  final TextEditingController _newPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _changePasswordUseCase = ref.read(changePasswordUsecaseProvider);
  }

  @override
  void dispose() {
    super.dispose();

    _newPasswordController.dispose();
  }

  void _handleBack() {
    if (_isChangePasswordLoading) return;
    context.pop();
  }

  Future<void> _handleChangePassword() async {
    if (_isChangePasswordLoading) return;

    setState(() => _isChangePasswordLoading = true);

    final Either<Failure, Unit> changePasswordResult = await _changePasswordUseCase(
      newPassword: _newPasswordController.text.trim()
    );

    changePasswordResult.fold(
      (Failure failure) {
        if (mounted) {
          failure.showToast(context);
        }
      },
      (Unit _) {
        if (mounted) {
          const Success.passwordChanged().showToast(context);
          context.pop();
        }
      }
    );

    if (mounted) setState(() => _isChangePasswordLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: const Text('Passwort ändern'),
        prefixes: [
          FHeaderAction.back(onPress: _handleBack)
        ]
      ),
      child: AuthForm(
        title: 'Passwort ändern', 
        subtitle: 'Gib das neue Passwort ein, das du zur Anmeldung nutzen möchtest.', 
        children: <Widget>[
          FTextField.password(
            controller: _newPasswordController,
            label: const Text('Neues Passwort')
          ),
          const SizedBox(height: 20.0),
          FButton(
            onPress: _handleChangePassword,
            child: _isChangePasswordLoading
              ? const FProgress.circularIcon()
              : const Text('Ändern')
          )
        ]
      )
    );
  }
}