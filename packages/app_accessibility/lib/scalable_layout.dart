import 'package:flutter/material.dart';

/// A widget that switches its layout from [Row] to [Column] when the
/// text scale factor exceeds [breakThreshold].
///
/// This is useful for ensuring that content remains readable and accessible
/// even when users have set a large font size, preventing overflow errors.
class ScalableLayout extends StatelessWidget {
  final List<Widget> children;
  final double breakThreshold;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const ScalableLayout({
    super.key,
    required this.children,
    this.breakThreshold = 1.5,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.textScalerOf(context).scale(1);

    if (textScaleFactor > breakThreshold) {
      return Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    } else {
      return Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    }
  }
}
