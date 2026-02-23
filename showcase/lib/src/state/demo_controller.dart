import 'package:before_after_slider/before_after_slider.dart';
import 'package:flutter/foundation.dart';

class DemoController {
  final ZoomController zoomController = ZoomController();
  final ValueNotifier<double> progress = ValueNotifier<double>(0.5);
  final ValueNotifier<bool> showLabels = ValueNotifier<bool>(true);
  final ValueNotifier<bool> enableDoubleTapZoom = ValueNotifier<bool>(true);
  final ValueNotifier<bool> enableContainerScale = ValueNotifier<bool>(true);
  final ValueNotifier<SliderDragMode> dragMode =
      ValueNotifier<SliderDragMode>(SliderDragMode.fullOverlay);
  final ValueNotifier<LabelBehavior> labelBehavior =
      ValueNotifier<LabelBehavior>(LabelBehavior.attachedToContent);
  final ValueNotifier<SliderOrientation> sliderOrientation =
      ValueNotifier<SliderOrientation>(SliderOrientation.horizontal);

  late final Listenable showcaseListenable = Listenable.merge([
    showLabels,
    enableDoubleTapZoom,
    enableContainerScale,
    dragMode,
    labelBehavior,
    sliderOrientation,
  ]);

  static const double _containerScaleMax = 1.60;
  static const double _containerScaleZoomRange = 0.55;

  double get containerScaleMax => _containerScaleMax;
  double get containerScaleZoomRange => _containerScaleZoomRange;

  void setShowLabels(bool value) {
    if (showLabels.value == value) return;
    showLabels.value = value;
  }

  void setEnableDoubleTapZoom(bool value) {
    if (enableDoubleTapZoom.value == value) return;
    enableDoubleTapZoom.value = value;
  }

  void setEnableContainerScale(bool value) {
    if (enableContainerScale.value == value) return;
    enableContainerScale.value = value;
  }

  void setDragMode(SliderDragMode? value) {
    if (value == null || dragMode.value == value) return;
    dragMode.value = value;
  }

  void setLabelBehavior(LabelBehavior? value) {
    if (value == null || labelBehavior.value == value) return;
    labelBehavior.value = value;
  }

  void setSliderOrientation(SliderOrientation value) {
    if (sliderOrientation.value == value) return;
    sliderOrientation.value = value;
  }

  void resetZoom() {
    zoomController.reset();
  }

  void dispose() {
    zoomController.dispose();
    progress.dispose();
    showLabels.dispose();
    enableDoubleTapZoom.dispose();
    enableContainerScale.dispose();
    dragMode.dispose();
    labelBehavior.dispose();
    sliderOrientation.dispose();
  }
}
