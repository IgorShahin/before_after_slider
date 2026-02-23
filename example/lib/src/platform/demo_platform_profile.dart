import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum DemoPlatformKind {
  web,
  desktop,
  mobile,
}

@immutable
class DemoPlatformProfile {
  const DemoPlatformProfile({
    required this.kind,
    required this.screenWidth,
  });

  final DemoPlatformKind kind;
  final double screenWidth;

  static DemoPlatformProfile from(BuildContext context, double screenWidth) {
    if (kIsWeb) {
      return DemoPlatformProfile(
        kind: DemoPlatformKind.web,
        screenWidth: screenWidth,
      );
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
        return DemoPlatformProfile(
          kind: DemoPlatformKind.desktop,
          screenWidth: screenWidth,
        );
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
        return DemoPlatformProfile(
          kind: DemoPlatformKind.mobile,
          screenWidth: screenWidth,
        );
    }
  }

  bool get isWeb => kind == DemoPlatformKind.web;
  bool get isDesktop => kind == DemoPlatformKind.desktop;
  bool get isMobile => kind == DemoPlatformKind.mobile;

  bool get isWideLayout => screenWidth >= 980 && !isMobile;

  String get title {
    if (isWeb) return 'Web Demo Showcase';
    if (isDesktop) return 'Desktop Demo Showcase';
    return 'Mobile Demo Showcase';
  }

  String get platformBadge {
    if (isWeb) return 'Web';
    if (isDesktop) return 'Desktop';
    return 'Mobile';
  }

  bool get showPrepareSceneButton => isWeb || isDesktop;

  String get prepareButtonLabel => isWeb ? 'Prepare Web' : 'Prepare Scene';

  String get modifierLabel {
    if (isMobile) return 'Pinch';
    if (defaultTargetPlatform == TargetPlatform.macOS || isWeb) {
      return 'Cmd';
    }
    return 'Ctrl';
  }

  String get interactionHint {
    if (isMobile) {
      return 'Use pinch and pan in the center Expanded area. '
          'Header/footer stay fixed while BeforeAfter expands.';
    }
    return 'Hold $modifierLabel and scroll in the center Expanded area. '
        'Header/footer stay fixed while BeforeAfter expands.';
  }

  List<String> get stepByStep {
    if (isMobile) {
      return const [
        '1. Use two fingers over preview.',
        '2. Pinch to zoom and pan.',
        '3. Observe expansion in the center Expanded zone.',
      ];
    }
    return [
      '1. Click "$prepareButtonLabel".',
      '2. Place cursor in the center Expanded area.',
      '3. Hold $modifierLabel.',
      '4. Scroll to zoom and watch frame expansion.',
    ];
  }

  double get previewHeight {
    if (isMobile) return 460;
    if (isWeb) return 540;
    return 520;
  }
}
