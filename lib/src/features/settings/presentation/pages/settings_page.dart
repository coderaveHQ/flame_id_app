import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flame_id_app/core/extensions/generic_x.dart';
import 'package:flame_id_app/src/features/auth/presentation/providers/custom_auth_state_notifier_provider.dart';
import 'package:flame_id_app/core/services/router.dart';
import 'package:flame_id_app/core/extensions/build_context_x.dart';
import 'package:flame_id_app/src/main_sidebar.dart';

class SettingsPage extends ConsumerWidget {

  const SettingsPage({ super.key });

  Future<void> _handleChangeEmail(BuildContext context, String? newEmail) async {
    if (newEmail != null) {
      await VerifyChangeEmailRoute(newEmail).push(context);
    } else {
      await const ChangeEmailRoute().push(context);
    }
  }

  Future<void> _handleChangePassword(BuildContext context) async {
    await const ChangePasswordRoute().push(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final FBreakpoints breakpoints = context.theme.breakpoints;

    final CustomAuthState customAuthState = ref.watch(customAuthStateNotifierProvider);

    return FScaffold(
      header: FHeader.nested(
        title: const Text('Einstellungen'),
        prefixes: [
          if (context.screenWidth < breakpoints.md) FHeaderAction(
            onPress: () => showMainSidebar(context),
            icon: Icon(FIcons.menu)
          )
        ]
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: context.bottomPadding
        ),
        child: Column(
          children: [
            FTileGroup(
              label: const Text('Konto'),
              description: const Text('Ändere deine Anmeldedaten.'),
              children: [
                FTile(
                  onPress: () async => await _handleChangeEmail(context, customAuthState.user!.newEmail),
                  prefixIcon: Icon(FIcons.mail),
                  title: const Text('E-Mail ändern'),
                  details: Text(customAuthState.user!.email),
                  subtitle: Text(
                    customAuthState.user!.newEmail.whenNotNull((String newEmail) => 'Änderung angefordert: $newEmail') 
                      ?? 'Ändere deine E-Mail-Adresse.',
                  ),
                  suffixIcon: Icon(FIcons.chevronRight)
                ),
                FTile(
                  onPress: () async => await _handleChangePassword(context),
                  prefixIcon: Icon(FIcons.lock),
                  title: const Text('Passwort ändern'),
                  subtitle: const Text('Ändere dein Passwort.'),
                  suffixIcon: Icon(FIcons.chevronRight)
                )
              ]
            ),
            FTileGroup(
              label: const Text('Benachrichtigungen'),
              description: const Text('Passe an, welche Benachrichtigungen du erhalten möchtest.'),
              children: [
                FTile(
                  onPress: () {},
                  prefixIcon: Icon(FIcons.mail),
                  title: const Text('Benachrichtigungen anpassen'),
                  subtitle: const Text('Passe Banner, Töne und Abzeichen an.'),
                  suffixIcon: Icon(FIcons.chevronRight)
                )
              ]
            )
          ]
        )
      )
    );
  }
}