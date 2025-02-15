import 'package:flutter/material.dart';

class FLMaxWidth extends StatelessWidget {

  final double width;
  final Widget child;

  const FLMaxWidth({
    super.key,
    required this.width,
    required this.child
  });

  const FLMaxWidth.withDefaultBreakpoint({
    super.key,
    required this.child
  })  : width = 480.0;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: width),
      child: child
    );
  }
}