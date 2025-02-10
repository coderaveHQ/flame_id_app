import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenHeight => screenSize.height;
  double get screenWidth => screenSize.width;

  EdgeInsets get padding => MediaQuery.paddingOf(this);
  double get leftPadding => padding.left;
  double get topPadding => padding.top;
  double get rightPadding => padding.right;
  double get bottomPadding => padding.bottom;
  double get verticalPadding => padding.top + padding.bottom;
  double get horizontalPadding => padding.left + padding.right;

  Orientation get orientation => mediaQuery.orientation;

  double get bottomPaddingOrKeyboard {
    if (isKeyboardShown) return currentKeyboardHeight;
    return bottomPadding;
  }

  double get bottomPaddingOrZeroWhenKeyboard {
    if (isKeyboardShown) return 0.0;
    return bottomPadding;
  }

  double get currentKeyboardHeight => mediaQuery.viewInsets.bottom;
  bool get isKeyboardShown => currentKeyboardHeight > 0.0;
}