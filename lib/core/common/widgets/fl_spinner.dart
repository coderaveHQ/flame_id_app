import 'package:flutter/material.dart';

class FLSpinner extends StatelessWidget {

  final double size;
  final Color color;

  const FLSpinner({
    super.key,
    required this.size,
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: CircularProgressIndicator(color: color)
    );
  }
}