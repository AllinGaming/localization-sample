import 'package:flutter/material.dart';

/// A widget that builds different content based on the user's motion preference.
///
/// If the user has requested reduced motion (e.g., via system settings),
/// [staticChild] is built. Otherwise, [motionChild] is built.
class ReducedMotion extends StatelessWidget {
  final Widget motionChild;
  final Widget staticChild;

  const ReducedMotion({
    super.key,
    required this.motionChild,
    required this.staticChild,
  });

  @override
  Widget build(BuildContext context) {
    final bool reduceMotion = MediaQuery.disableAnimationsOf(context);
    return reduceMotion ? staticChild : motionChild;
  }
}
