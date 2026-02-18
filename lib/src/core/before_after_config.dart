part of '../before_after.dart';

extension _BeforeAfterConfigX on _BeforeAfterState {
  bool get _isDoubleTapZoomEnabled {
    final optionsEnabled = widget.zoomOptions?.enableDoubleTapZoom;
    if (optionsEnabled != null) return optionsEnabled;
    final enabled = widget.enableDoubleTapZoom;
    if (enabled != null) return enabled;
    // ignore: deprecated_member_use_from_same_package
    return widget.enableDoubleTapZoomToggle ?? true;
  }

  bool get _isZoomEnabled => widget.zoomOptions?.enabled ?? widget.enableZoom;

  double get _effectiveGestureZoomSmoothing =>
      widget.zoomOptions?.gestureZoomSmoothing ?? widget.gestureZoomSmoothing;

  double get _effectiveZoomPanSensitivity =>
      widget.zoomOptions?.zoomPanSensitivity ?? widget.zoomPanSensitivity;

  DesktopZoomOptions get _effectiveDesktopZoom =>
      widget.zoomOptions?.desktop ?? widget.desktopZoom;

  double get _effectiveDoubleTapZoomScale =>
      widget.zoomOptions?.doubleTapZoomScale ?? widget.doubleTapZoomScale;

  Duration get _effectiveDoubleTapZoomDuration =>
      widget.zoomOptions?.doubleTapZoomDuration ?? widget.doubleTapZoomDuration;

  Curve get _effectiveDoubleTapZoomCurve =>
      widget.zoomOptions?.doubleTapZoomCurve ?? widget.doubleTapZoomCurve;

  bool get _effectiveEnableContainerScaleOnZoom =>
      widget.zoomOptions?.enableContainerScaleOnZoom ?? false;

  double get _effectiveContainerScaleMax =>
      widget.zoomOptions?.containerScaleMax ?? 1.12;

  double get _effectiveContainerScaleZoomRange =>
      widget.zoomOptions?.containerScaleZoomRange ?? 2.0;

  bool get _hasContainerVisualScaleEffect =>
      widget.enableReverseZoomVisualEffect ||
      _effectiveEnableContainerScaleOnZoom;

  double get _minContainerVisualScale =>
      widget.enableReverseZoomVisualEffect ? widget.reverseZoomMinScale : 1.0;

  double get _maxContainerVisualScale =>
      _effectiveEnableContainerScaleOnZoom ? _effectiveContainerScaleMax : 1.0;

  bool get _effectiveEnableProgressWithTouch =>
      widget.interactionOptions?.enableProgressWithTouch ??
      widget.enableProgressWithTouch;

  SliderDragMode get _effectiveSliderDragMode =>
      widget.interactionOptions?.sliderDragMode ?? widget.sliderDragMode;

  SliderHitZone get _effectiveSliderHitZone =>
      widget.interactionOptions?.sliderHitZone ?? widget.sliderHitZone;

  bool get _effectiveShowLabels =>
      widget.labelsOptions?.show ?? widget.showLabels;
}
