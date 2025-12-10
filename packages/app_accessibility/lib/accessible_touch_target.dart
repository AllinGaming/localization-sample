import 'package:flutter/material.dart';

/// A widget that ensures its child has a minimum size of 48x48 logical pixels.
/// This complies with Material Design accessibility guidelines for touch targets.
class AccessibleTouchTarget extends StatelessWidget {
  final Widget child;
  final double minWidth;
  final double minHeight;

  const AccessibleTouchTarget({
    super.key,
    required this.child,
    this.minWidth = 48.0,
    this.minHeight = 48.0,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minWidth,
        minHeight: minHeight,
      ),
      child: Center(
        widthFactor: 1.0,
        heightFactor: 1.0,
        child: child,
      ),
    );
  }
}
