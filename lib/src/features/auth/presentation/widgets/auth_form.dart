import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

import 'package:flame_id_app/core/extensions/build_context_x.dart';

class AuthForm extends StatelessWidget {

  final String title;
  final String subtitle;
  final List<Widget> children;
  final bool withTopPadding;

  const AuthForm({
    super.key,
    required this.title,
    required this.subtitle,
    required this.children,
    this.withTopPadding = true
  });

  @override
  Widget build(BuildContext context) {

    final double maxComponentWidth = 640.0;
    final double leftPadding = context.leftPadding + 16.0;
    final double rightPadding = context.rightPadding + 16.0;
    final double horizontalPadding = leftPadding + rightPadding;
    final double bothSidedDynamicPadding = (context.screenWidth - horizontalPadding - maxComponentWidth) / 2.0;

    final bool useDynamicPadding = context.screenWidth > maxComponentWidth + horizontalPadding;
    
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: (withTopPadding ? context.topPadding : 0.0) + 16.0,
          bottom: 16.0,
          left: useDynamicPadding ? leftPadding + bothSidedDynamicPadding : leftPadding,
          right: useDynamicPadding ? rightPadding + bothSidedDynamicPadding : rightPadding
        ),
        child: FCard(
          title: Text(title),
          subtitle: Text(subtitle),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children
          )
        )
      )
    );
  }
}