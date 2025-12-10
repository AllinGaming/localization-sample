import 'package:flutter/semantics.dart';

/// A helper class to trigger screen reader announcements.
class AccessibilityAnnouncer {
  /// Announces a message to the screen reader.
  static void announce(String message) {
    // ignore: deprecated_member_use
    SemanticsService.announce(message, TextDirection.ltr);
  }
}
