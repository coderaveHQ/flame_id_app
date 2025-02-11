import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:flame_id_app/core/res/app_assets.dart';
import 'package:flame_id_app/core/services/router.dart';
import 'package:flame_id_app/core/common/widgets/fl_navigation_rail.dart';
import 'package:flame_id_app/core/extensions/build_context_x.dart';
import 'package:flame_id_app/core/common/widgets/fl_bottom_navigation_bar.dart';
import 'package:flame_id_app/core/common/widgets/fl_scaffold.dart';

class MainPage extends StatefulWidget {

  final Widget navigator;

  const MainPage({ 
    super.key,
    required this.navigator
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  List<MainNavigationBarItem> get _items {

    final String currentPath = GoRouterState.of(context).uri.toString();

    return <MainNavigationBarItem>[
      MainNavigationBarItem(
        onPressed: _onUserManagement,
        icon: LucideIcons.users,
        isSelected: UserManagementRoute.fullPath == currentPath,
        title: 'Benutzerverwaltung'
      ),
      MainNavigationBarItem(
        onPressed: _onPersonalData,
        icon: LucideIcons.mapPinHouse,
        isSelected: PersonalDataRoute.fullPath == currentPath,
        title: 'Personendaten'
      ),
      MainNavigationBarItem(
        onPressed: _onCertificates,
        icon: LucideIcons.award,
        isSelected: CertificatesRoute.fullPath == currentPath,
        title: 'Zertifikate'
      ),
      MainNavigationBarItem(
        onPressed: _onLicenses,
        icon: LucideIcons.idCard,
        isSelected: LicensesRoute.fullPath == currentPath,
        title: 'Führerscheine'
      ),
      MainNavigationBarItem(
        onPressed: _onVault,
        icon: LucideIcons.vault,
        isSelected: VaultRoute.fullPath == currentPath,
        title: 'Tresor'
      )
    ];
  }

  void _onUserManagement() {
    const UserManagementRoute().go(context);
  }

  void _onPersonalData() {
    const PersonalDataRoute().go(context);
  }

  void _onCertificates() {
    const CertificatesRoute().go(context);
  }

  void _onLicenses() {
    const LicensesRoute().go(context);
  }

  void _onVault() {
    const VaultRoute().go(context);
  }

  @override
  Widget build(BuildContext context) {
    return FLScaffold(
      body: Row(
        children: [
          if (context.screenWidth > 480.0) FLNavigationRail(
            logoPath: AppAssets.logo, 
            appName: 'Flame ID', 
            appVersion: '1.0.0',
            navigationItems: _items.map(
              (MainNavigationBarItem item) => item.toNavigationRailItem()
            ).toList()
          ),
          Expanded(child: widget.navigator)
        ]
      ),
      bottomNavigationBar: context.screenWidth <= 480.0
        ? FLBottomNavigationBar(
          items: _items.map(
            (MainNavigationBarItem item) => item.toBottomNavigationBarItem()
          ).toList()
        )
        : null
    );
  }
}

class MainNavigationBarItem {

  final void Function()? onPressed;
  final IconData icon;
  final bool isSelected;
  final String title;

  const MainNavigationBarItem({
    this.onPressed,
    required this.icon,
    this.isSelected = false,
    required this.title
  });

  FLBottomNavigationBarItem toBottomNavigationBarItem() {
    return FLBottomNavigationBarItem(
      onPressed: onPressed,
      icon: icon,
      isSelected: isSelected
    );
  }

  FLNavigationRailItem toNavigationRailItem() {
    return FLNavigationRailItem(
      onPressed: onPressed,
      icon: icon,
      isSelected: isSelected,
      title: title
    );
  }
}