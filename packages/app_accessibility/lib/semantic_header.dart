import 'package:flutter/material.dart';

/// A wrapper for text or other content that marks it as a header for screen readers.
class SemanticHeader extends StatelessWidget {
  final Widget child;

  const SemanticHeader({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      child: child,
    );
  }
}
