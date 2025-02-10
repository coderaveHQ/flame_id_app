import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:collection/collection.dart';

import 'package:flame_id_app/core/common/widgets/fl_circular_button.dart';
import 'package:flame_id_app/core/common/widgets/fl_text.dart';
import 'package:flame_id_app/core/extensions/build_context_x.dart';
import 'package:flame_id_app/core/res/theme/colors/fl_colors.dart';
import 'package:flame_id_app/core/res/theme/spacing/fl_spacing.dart';
import 'package:flame_id_app/core/extensions/generic_x.dart';

class FLAppBar extends StatelessWidget implements PreferredSizeWidget {

  final BuildContext context;
  final FLAppBarBackButton? backButton;
  final List<FLAppBarButton> actionButtons;
  final String? title;
  final Widget? extraLeading;
  final Widget? extraTrailing;

  const FLAppBar({
    super.key,
    required this.context,
    this.backButton,
    this.actionButtons = const <FLAppBarButton>[],
    this.title,
    this.extraLeading,
    this.extraTrailing
  });

  @override
  Size get preferredSize => Size.fromHeight(context.topPadding + kToolbarHeight);

  @override
  Widget build(BuildContext context) {

    final List<Widget?> children = <Widget?>[
      backButton,
      extraLeading,
      title.whenNotNull((String title) => FLText(
        text: title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w600,
          color: FLColors.gray900
        )
      )),
      ...actionButtons.map((Widget actionButton) => Align(
        alignment: Alignment.centerRight,
        child: actionButton
      )),
      extraTrailing
    ];

    return Container(
      width: preferredSize.width,
      height: preferredSize.height,
      color: FLColors.white,
      padding: EdgeInsets.only(top: context.topPadding),
      child: Row(
        children: <Widget>[
          ...children
          .mapIndexed((int index, Widget? child) {
            if (child == null) return const SizedBox.shrink();

            final Widget innerChild = Padding(
              padding: EdgeInsets.only(
                left: index == 0
                  ? context.leftPadding + FLSpacing.lg
                  : FLSpacing.sm,
                right: index == children.length - 1
                  ? context.rightPadding + FLSpacing.lg
                  : 0.0
              ),
              child: child
            );

            if (index == 1) return Flexible(child: innerChild);
            if (index == 2) return Expanded(child: innerChild);

            return innerChild;
          })
        ]
      )
    );
  }
}

class FLAppBarButton extends StatelessWidget {

  final void Function()? onPressed;
  final IconData icon;
  final bool isLoading;
  final bool isEnabled;

  const FLAppBarButton({
    super.key,
    this.onPressed,
    required this.icon,
    this.isLoading = false,
    this.isEnabled = true
  });

  @override
  Widget build(BuildContext context) {
    return FLCircularButton(
      onPressed: onPressed,
      icon: icon,
      size: kToolbarHeight - 4.0,
      isLoading: isLoading,
      isEnabled: isEnabled,
      backgroundColor: FLColors.white,
      foregroundColor: FLColors.gray900
    );
  }
}

class FLAppBarBackButton extends StatelessWidget {

  final bool Function()? onPressed;
  final bool isLoading;
  final bool isEnabled;

  const FLAppBarBackButton({ 
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true
  });

  @override
  Widget build(BuildContext context) {
    return FLAppBarButton(
      onPressed: isEnabled && !isLoading ? () => context.pop() : null,
      isLoading: isLoading,
      isEnabled: isEnabled,
      icon: LucideIcons.arrowLeft
    );
  }
}