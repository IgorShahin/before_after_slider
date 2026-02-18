import 'package:before_after_slider/before_after_slider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DemoApp());
}

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'before_after_slider demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final ZoomController _zoomController = ZoomController();
  double _progress = 0.5;
  static const double _demoContainerScaleMax = 1.55;
  static const double _demoContainerScaleZoomRange = 0.9;
  static const double _sceneVerticalScaleFactor = 1.4;

  @override
  void dispose() {
    _zoomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Before/After Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxDemoWidth = constraints.maxWidth.clamp(280.0, 960.0);
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: maxDemoWidth),
                        child: LayoutBuilder(
                          builder: (context, box) {
                            final previewWidth = box.maxWidth;
                            final previewHeight = previewWidth * 3 / 4;
                            final maxScaleProgress =
                                (_demoContainerScaleMax - 1.0).clamp(0.0, 1.0);
                            final maxContentScaleY = 1.0 +
                                maxScaleProgress * _sceneVerticalScaleFactor;
                            final previewOverflowReserve =
                                ((previewHeight * (maxContentScaleY - 1.0)) / 2)
                                        .ceilToDouble() +
                                    12;
                            return SizedBox(
                              width: previewWidth,
                              height:
                                  previewHeight + previewOverflowReserve * 2,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      top: previewOverflowReserve,
                                      height: previewHeight,
                                      child: BeforeAfter(
                                        beforeChild: Image.asset(
                                          'assets/before.jpeg',
                                          fit: BoxFit.cover,
                                        ),
                                        afterChild: Image.asset(
                                          'assets/after.jpeg',
                                          fit: BoxFit.cover,
                                        ),
                                        progress: _progress,
                                        labelsOptions: BeforeAfterLabelsOptions(
                                          behavior:
                                              LabelBehavior.attachedToContent,
                                          beforeBuilder: (_) => Container(
                                            margin: const EdgeInsets.all(10),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.black87.withValues(
                                                alpha: 0.85,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                            ),
                                            child: const Text(
                                              'Before',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          afterBuilder: (_) => Container(
                                            margin: const EdgeInsets.all(10),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.blue.shade700
                                                  .withValues(alpha: 0.85),
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                            ),
                                            child: const Text(
                                              'After',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                        interactionOptions:
                                            const BeforeAfterInteractionOptions(
                                          sliderDragMode:
                                              SliderDragMode.fullOverlay,
                                          sliderHitZone: SliderHitZone(
                                            minLineHalfWidth: 18,
                                            minThumbRadius: 30,
                                          ),
                                        ),
                                        zoomOptions:
                                            const BeforeAfterZoomOptions(
                                          zoomPanSensitivity: 0.95,
                                          enableContainerScaleOnZoom: true,
                                          containerScaleMax:
                                              _demoContainerScaleMax,
                                          containerScaleZoomRange:
                                              _demoContainerScaleZoomRange,
                                          desktop: DesktopZoomOptions(
                                            requiresModifier: true,
                                            smoothing: 0.4,
                                          ),
                                        ),
                                        enableReverseZoomVisualEffect: true,
                                        reverseZoomEffectBorderRadius: 12,
                                        onProgressChanged: (value) {
                                          setState(() {
                                            _progress = value;
                                          });
                                        },
                                        zoomController: _zoomController,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text('Progress: ${(_progress * 100).round()}%'),
                    Slider(
                      value: _progress,
                      onChanged: (value) {
                        setState(() {
                          _progress = value;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    FilledButton.tonal(
                      onPressed: _zoomController.reset,
                      child: const Text('Reset Zoom'),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Drag divider, pinch to zoom, Ctrl/Cmd + wheel for desktop zoom, and double-tap to reset.',
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
