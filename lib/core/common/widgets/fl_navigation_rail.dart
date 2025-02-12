import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

import 'package:flame_id_app/core/common/widgets/fl_text.dart';
import 'package:flame_id_app/core/extensions/build_context_x.dart';
import 'package:flame_id_app/core/res/theme/colors/fl_colors.dart';
import 'package:flame_id_app/core/res/theme/spacing/fl_spacing.dart';

class FLNavigationRail extends StatelessWidget {

  final String logoPath;
  final String appName;
  final String appVersion;
  final List<FLNavigationRailItem> navigationItems;

  const FLNavigationRail({ 
    super.key,
    required this.logoPath,
    required this.appName,
    required this.appVersion,
    this.navigationItems = const <FLNavigationRailItem>[]
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.leftPadding + 2 * FLSpacing.lg + 280.0,
      height: double.infinity,
      color: FLColors.gray200,
      child: Column(
        children: [
          _TLNavigationRailTop(
            logoPath: logoPath,
            appName: appName,
            appVersion: appVersion
          ),
          const Gap(FLSpacing.xxl),
          _FLNavigationRailCenter(navigationItems: navigationItems)
        ]
      )
    );
  }
}

class FLNavigationRailItem extends StatelessWidget {

  final void Function()? onPressed;
  final String title;
  final IconData icon;
  final bool isSelected;

  const FLNavigationRailItem({ 
    super.key,
    this.onPressed,
    required this.title,
    required this.icon,
    this.isSelected = false
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42.0,
      width: 280.0,
      child: RawMaterialButton(
        onPressed: onPressed,
        padding: EdgeInsets.symmetric(horizontal: FLSpacing.lg),
        elevation: 0.0,
        focusElevation: 0.0,
        hoverElevation: 0.0,
        disabledElevation: 0.0,
        highlightElevation: 0.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        fillColor: isSelected ? FLColors.red600 : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18.0,
              color: isSelected ? FLColors.white : FLColors.gray500
            ),
            const Gap(FLSpacing.md),
            Expanded(
              child: FLText(
                text: title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? FLColors.white : FLColors.gray500
                )
              )
            )
          ]
        )
      )
    );
  }
}

class _TLNavigationRailTop extends StatelessWidget {

  final String logoPath;
  final String appName;
  final String appVersion;

  const _TLNavigationRailTop({
    required this.logoPath,
    required this.appName,
    required this.appVersion
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: context.topPadding + (kToolbarHeight - 40.0) / 2.0,
        left: context.leftPadding + FLSpacing.lg,
        right: FLSpacing.lg
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.asset(
              logoPath,
              width: 40.0,
              height: 40.0
            )
          ),
          const Gap(FLSpacing.sm),
          Expanded(
            child: FLText(
              text: appName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: FLColors.gray900
              )
            )
          ),
          const Gap(FLSpacing.sm),
          FLText(
            text: 'v$appVersion',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            alignment: TextAlign.end,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              color: FLColors.gray500
            )
          )
        ]
      )
    );
  }
}

class _FLNavigationRailCenter extends StatelessWidget {

  final List<FLNavigationRailItem> navigationItems;

  const _FLNavigationRailCenter({
    this.navigationItems = const <FLNavigationRailItem>[],
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: context.leftPadding + FLSpacing.lg,
          right: FLSpacing.lg,
          bottom: context.bottomPadding + FLSpacing.lg
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(navigationItems.length, (int index) {
            final FLNavigationRailItem item = navigationItems[index];
            final bool isLast = index == navigationItems.length - 1;
            return Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0.0 : FLSpacing.sm),
              child: item
            );
          })
        )
      )
    );
  }
}