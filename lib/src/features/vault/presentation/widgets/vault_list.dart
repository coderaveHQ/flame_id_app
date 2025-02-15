import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

import 'package:flame_id_app/core/extensions/build_context_x.dart';
import 'package:flame_id_app/core/common/widgets/fl_text.dart';
import 'package:flame_id_app/core/res/theme/colors/fl_colors.dart';
import 'package:flame_id_app/core/res/theme/spacing/fl_spacing.dart';

class VaultList extends StatelessWidget {

  const VaultList({ super.key });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 50,
      padding: EdgeInsets.only(
        top: FLSpacing.lg,
        bottom: context.bottomPaddingOrZeroWhenKeyboard + FLSpacing.lg,
        left: (context.screenWidth <= 480.0 ? context.leftPadding : 0.0) + FLSpacing.lg,
        right: context.leftPadding + FLSpacing.lg
      ),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 480.0,
        mainAxisSpacing: FLSpacing.md,
        crossAxisSpacing: FLSpacing.md,
        mainAxisExtent: 70.0
      ), 
      itemBuilder: (BuildContext context, int index) {
        return VaultListItem();
      }
    );
  }
}

class VaultListItem extends StatelessWidget {

  const VaultListItem({ super.key });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {},
      padding: EdgeInsets.symmetric(horizontal: FLSpacing.lg),
      fillColor: FLColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FLText(
              text: 'Google',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: FLColors.gray900
              )
            ),
            const Gap(FLSpacing.xs),
            FLText(
              text: 'https://google.com',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                color: FLColors.gray500
              )
            )
          ]
        )
      )
    );
  }
}