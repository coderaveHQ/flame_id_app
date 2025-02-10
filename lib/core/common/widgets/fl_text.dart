import 'package:flutter/material.dart';

import 'package:flame_id_app/core/res/theme/typography/fl_typography.dart';

class FLText extends StatelessWidget {

  final String text;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? alignment;
  final TextStyle? style;

  const FLText({ 
    super.key,
    required this.text,
    this.maxLines,
    this.overflow,
    this.alignment,
    this.style
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: alignment,
      style: FLTypography.base.merge(style)
    );
  }
}