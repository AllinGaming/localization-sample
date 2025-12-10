# Flutter Monorepo: Localization & Accessibility

[![Build Status](https://img.shields.io/github/actions/workflow/status/example/repo/deploy_web.yml?branch=main&style=flat-square)](https://github.com/example/repo/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-3.0%2B-02569B?style=flat-square&logo=flutter&logoColor=white)](https://flutter.dev)
[![Melos](https://img.shields.io/badge/Melos-Enabled-orange?style=flat-square)](https://melos.invertase.dev)
[![Style: Flutter Lints](https://img.shields.io/badge/style-flutter__lints-blue?style=flat-square)](https://pub.dev/packages/flutter_lints)

A production-ready reference implementation for a Flutter Melos monorepo, featuring type-safe internationalization (i18n) and a reusable accessibility design system.

## Overview

This repository demonstrates scalable patterns for:
*   **Type-safe Localization**: Using `i69n` for compile-time checked translation keys.
*   **Dynamic Content**: Loading translations from an external source (API) at runtime without app updates.
*   **Universal Accessibility**: A dedicated package for enforcing WCAG guidelines across iOS, Android, and Web.

## Project Structure

The workspace is managed by [Melos](https://melos.invertase.dev/).

| Package | Path | Description |
| :--- | :--- | :--- |
| **app_localization** | `packages/app_localization` | Core i18n logic. Contains YAML definitions, generated code, and the dynamic loading engine. |
| **app_accessibility** | `packages/app_accessibility` | Shared UI components for accessibility (A11y), including touch targets, semantic headers, and adaptive layouts. |
| **example_app** | `packages/example_app` | A demo application showcasing the integration of both packages. |

## Features

### 🌍 Internationalization (`app_localization`)
*   **Supported Locales**: English (`en`), Spanish (`es`), French (`fr`), German (`de`), Arabic (`ar` - RTL support).
*   **Type Safety**: Translations are generated into Dart classes. No more string-based key lookups.
*   **Dynamic Loading**: Demonstrates fetching translations for Italian (`it`) from a simulated backend API, seamlessly integrating with the standard `LocalizationsDelegate`.

### ♿ Accessibility (`app_accessibility`)
Designed to work natively on Mobile and Web (via ARIA mapping).
*   **`AccessibleTouchTarget`**: Enforces a minimum 48x48 logical pixel size for interactive elements.
*   **`SemanticHeader`**: Correctly marks text as headers for screen readers (VoiceOver/TalkBack).
*   **`ReducedMotion`**: Automatically swaps complex animations for static alternatives based on user system preferences.
*   **`ScalableLayout`**: Adaptive widget that switches from `Row` to `Column` when text scaling (Dynamic Type) exceeds 150%, preventing overflow.
*   **`AccessibilityAnnouncer`**: Simplified API for screen reader announcements.

## Getting Started

### Prerequisites
*   Flutter SDK
*   Melos (`dart pub global activate melos`)

### Installation
1.  Bootstrap the workspace to link local packages:
    ```bash
    melos bootstrap
    ```

2.  Generate localization files (if modifying YAMLs):
    ```bash
    melos run generate:i18n
    ```

### Running the App
```bash
flutter run -d chrome # or ios/android
```

## Usage Guide

### Adding a New Language
1.  Create `messages_<locale>.i69n.yaml` in `packages/app_localization/lib/`.
2.  Run `flutter pub run build_runner build`.
3.  Register the new locale in `setup.dart`.

### Using Accessibility Components
```dart
import 'package:app_accessibility/app_accessibility.dart';

// Adaptive layout that handles large fonts
ScalableLayout(
  children: [
    // Accessible button with min touch target
    AccessibleTouchTarget(
      child: ElevatedButton(onPressed: () {}, child: Text('Submit')),
    ),
  ],
)
```

## Testing

Run unit and widget tests across all packages:

```bash
melos run test
```

The `example_app` includes comprehensive widget tests verifying:
*   Locale switching and string correctness.
*   RTL directionality.
*   Dynamic API loading simulation.
*   Accessibility semantics (Alt text, header traits).
