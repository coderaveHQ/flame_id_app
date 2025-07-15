import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

import 'package:flame_id_app/core/extensions/build_context_x.dart';
import 'package:flame_id_app/src/features/auth/presentation/widgets/sign_out_button.dart';
import 'package:flame_id_app/core/services/router.dart';

Future<void> showMainSidebar(BuildContext context) async {
  await showFSheet(
    context: context,
    side: FLayout.ltr,
    builder: (BuildContext sheetContext) => MainSidebar(
      currentRoute: context.currentRoute,
      onNavigate: (route) => context.go(route)
    )
  );
}

class MainSidebar extends StatelessWidget {

  final String currentRoute;
  final void Function(String route) onNavigate;

  const MainSidebar({ 
    super.key,
    required this.currentRoute,
    required this.onNavigate
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: context.theme.colors.background),
      child: FSidebar(
        header: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    'images/logo.png',
                    width: 50.0,
                    height: 50.0
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      'Flame ID',
                      style: context.theme.typography.xl2.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.theme.colors.foreground
                      ),
                      overflow: TextOverflow.ellipsis
                    )
                  )
                ]
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: FDivider(style: context.theme.dividerStyles.horizontalStyle.copyWith(padding: EdgeInsets.zero).call)
              )
            ]
          )
        ),
        footer: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: FCard.raw(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0, 
                horizontal: 16.0
              ),
              child: Row(
                spacing: 10.0,
                children: [
                  FAvatar.raw(
                    child: Icon(
                      FIcons.userRound, 
                      size: 18.0, 
                      color: context.theme.colors.mutedForeground
                    )
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 2.0,
                      children: [
                        Text(
                          'Florian Leeser',
                          style: context.theme.typography.sm.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.theme.colors.foreground
                          ),
                          overflow: TextOverflow.ellipsis
                        ),
                        Text(
                          'fleeser@coderave.dev',
                          style: context.theme.typography.xs.copyWith(color: context.theme.colors.mutedForeground),
                          overflow: TextOverflow.ellipsis
                        )
                      ]
                    )
                  ),
                  const SignOutButton()
                ]
              )
            )
          )
        ),
        children: [
          FSidebarGroup(
            label: const Text('Nachrichten'),
            children: [
              FSidebarItem(
                onPress: () => onNavigate(NotificationsRoute.fullPath),
                icon: const Icon(FIcons.bell), 
                label: const Text('Benachrichtigungen'),
                selected: currentRoute == NotificationsRoute.fullPath
              ),
              FSidebarItem(
                onPress: () => onNavigate(ChatsRoute.fullPath),
                icon: const Icon(FIcons.messageCircle), 
                label: const Text('Chats'),
                selected: currentRoute == ChatsRoute.fullPath
              )
            ]
          ),
          FSidebarGroup(
            label: const Text('Dokumente'),
            children: [
              FSidebarItem(
                onPress: () => onNavigate(CertificatesRoute.fullPath),
                icon: const Icon(FIcons.fileCheck2),
                label: const Text('Zertifikate'),
                selected: currentRoute == CertificatesRoute.fullPath
              ),
              FSidebarItem(
                onPress: () => onNavigate(DrivingLicensesRoute.fullPath),
                icon: const Icon(FIcons.car),
                label: const Text('Führerscheine'),
                selected: currentRoute == DrivingLicensesRoute.fullPath
              ),
              FSidebarItem(
                onPress: () => onNavigate(DroneLicensesRoute.fullPath),
                icon: const Icon(FIcons.plane),
                label: const Text('Drohnenscheine'),
                selected: currentRoute == DroneLicensesRoute.fullPath
              )
            ]
          ),
          FSidebarGroup(
            label: const Text('Privates'),
            children: [
              FSidebarItem(
                onPress: () => onNavigate(PasswordsRoute.fullPath),
                icon: const Icon(FIcons.vault), 
                label: const Text('Passwörter'),
                selected: currentRoute == PasswordsRoute.fullPath
              )
            ]
          ),
          FSidebarGroup(
            label: const Text('Über mich'),
            children: [
              FSidebarItem(
                onPress: () => onNavigate(PersonalDataRoute.fullPath),
                icon: const Icon(FIcons.idCard), 
                label: const Text('Persönliche Daten'),
                selected: currentRoute == PersonalDataRoute.fullPath
              )
            ]
          ),
          FSidebarGroup(
            label: const Text('Administration'),
            children: [
              FSidebarItem(
                onPress: () => onNavigate(UsersRoute.fullPath),
                icon: const Icon(FIcons.users),
                label: const Text('Benutzerverwaltung'),
                selected: currentRoute == UsersRoute.fullPath
              )
            ]
          ),
          FSidebarGroup(
            label: const Text('Personalisierung'),
            children: [
              FSidebarItem(
                onPress: () => onNavigate(SettingsRoute.fullPath),
                icon: const Icon(FIcons.settings),
                label: const Text('Einstellungen'),
                selected: currentRoute == SettingsRoute.fullPath
              )
            ]
          )
        ]
      )
    );
  }
}