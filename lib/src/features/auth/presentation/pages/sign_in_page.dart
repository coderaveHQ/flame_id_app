import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:flame_id_app/core/common/widgets/fl_max_width.dart';
import 'package:flame_id_app/core/extensions/object_x.dart';
import 'package:flame_id_app/src/features/auth/presentation/state/sign_in_state.dart';
import 'package:flame_id_app/src/features/auth/presentation/state/sign_in_notifier_provider.dart';
import 'package:flame_id_app/core/common/widgets/fl_rectangle_button.dart';
import 'package:flame_id_app/core/common/widgets/fl_text.dart';
import 'package:flame_id_app/core/common/widgets/fl_text_field.dart';
import 'package:flame_id_app/core/res/theme/colors/fl_colors.dart';
import 'package:flame_id_app/core/res/theme/spacing/fl_spacing.dart';
import 'package:flame_id_app/core/common/widgets/fl_scaffold.dart';
import 'package:flame_id_app/core/extensions/build_context_x.dart';

class SignInPage extends StatefulHookConsumerWidget {

  const SignInPage({ super.key });

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  Future<void> _onSignIn() async {
    final String email = _emailController.text.trim().toLowerCase();
    final String password = _passwordController.text.trim();

    final SignInNotifier signInNotifier = ref.read(signInNotifierProvider.notifier);
    await signInNotifier.signIn(
      email: email,
      password: password
    );
  }

  void _handleSignInStateUpdate(SignInState? last, SignInState next) {
    if (next.hasError) next.error!.showErrorToast(context);
  }

  @override
  Widget build(BuildContext context) {

    _emailController = useTextEditingController();
    _passwordController = useTextEditingController();

    final SignInState signInState = ref.watch(signInNotifierProvider);

    ref.listen(signInNotifierProvider, _handleSignInStateUpdate);

    return FLScaffold(
      body: SizedBox.expand(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: context.leftPadding + FLSpacing.lg,
            right: context.rightPadding + FLSpacing.lg,
            top: context.topPadding + FLSpacing.lg,
            bottom: context.bottomPaddingOrKeyboard + FLSpacing.lg
          ),
          child: Column(
            children: [
              const FLMaxWidth.withDefaultBreakpoint(
                child: FLText(
                  text: 'Willkommen bei Flame ID!',
                  alignment: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w600,
                    color: FLColors.gray900
                  )
                )
              ),
              const Gap(FLSpacing.lg),
              const FLMaxWidth.withDefaultBreakpoint(
                child: FLText(
                  text: 'Melde dich an und schon kann es losgehen.',
                  alignment: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: FLColors.gray700
                  )
                )
              ),
              const Gap(FLSpacing.xxl),
              FLMaxWidth.withDefaultBreakpoint(
                child: FLTextField(
                  inputType: TextInputType.emailAddress,
                  icon: LucideIcons.mail,
                  controller: _emailController,
                  hint: 'test@example.com',
                  isEnabled: !signInState.isLoading
                )
              ),
              const Gap(FLSpacing.lg),
              FLMaxWidth.withDefaultBreakpoint(
                child: FLTextField(
                  icon: LucideIcons.lock,
                  hint: '* * * * * *',
                  controller: _passwordController,
                  obscure: true,
                  isEnabled: !signInState.isLoading
                )
              ),
              const Gap(FLSpacing.lg),
              FLMaxWidth.withDefaultBreakpoint(
                child: FLRectangleButton(
                  onPressed: _onSignIn,
                  title: 'Anmelden',
                  isLoading: signInState.isLoading
                )
              )
            ]
          )
        )
      )
    );
  }
}