import 'package:flutter/material.dart';

import '../controllers/zoom_controller.dart';

/// Runtime/state configuration used when [BeforeAfter] creates an internal
/// [ZoomController].
@immutable
class ZoomRuntimeOptions {
  const ZoomRuntimeOptions({
    this.minZoom = 1.0,
    this.maxZoom = 15.0,
    this.zoomEnabled = true,
    this.panEnabled = true,
    this.rotationEnabled = false,
    this.boundPan = true,
    this.enableZoomOvershoot = true,
    this.maxZoomOvershoot = 0.22,
    this.zoomOvershootResistance = 0.35,
    this.zoomOvershootReboundDuration = const Duration(milliseconds: 180),
  })  : assert(minZoom > 0.0, 'minZoom must be > 0.0'),
        assert(maxZoom >= minZoom, 'maxZoom must be >= minZoom'),
        assert(maxZoomOvershoot >= 0.0, 'maxZoomOvershoot must be >= 0.0'),
        assert(
          zoomOvershootResistance >= 0.0 && zoomOvershootResistance <= 1.0,
          'zoomOvershootResistance must be in [0.0, 1.0]',
        );

  final double minZoom;
  final double maxZoom;
  final bool zoomEnabled;
  final bool panEnabled;
  final bool rotationEnabled;
  final bool boundPan;
  final bool enableZoomOvershoot;
  final double maxZoomOvershoot;
  final double zoomOvershootResistance;
  final Duration zoomOvershootReboundDuration;

  ZoomController createController({
    double initialZoom = 1.0,
    Offset initialPan = Offset.zero,
    double initialRotation = 0.0,
  }) {
    return ZoomController(
      initialZoom: initialZoom,
      initialPan: initialPan,
      initialRotation: initialRotation,
      minZoom: minZoom,
      maxZoom: maxZoom,
      zoomEnabled: zoomEnabled,
      panEnabled: panEnabled,
      rotationEnabled: rotationEnabled,
      boundPan: boundPan,
      enableZoomOvershoot: enableZoomOvershoot,
      maxZoomOvershoot: maxZoomOvershoot,
      zoomOvershootResistance: zoomOvershootResistance,
      zoomOvershootReboundDuration: zoomOvershootReboundDuration,
    );
  }
}
