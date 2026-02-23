import 'package:flutter/material.dart';

import 'platform/demo_platform_profile.dart';
import 'sections/control_panel.dart';
import 'sections/demo_card.dart';
import 'sections/header_section.dart';
import 'sections/info_section.dart';
import 'state/demo_controller.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final DemoController _controller = DemoController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final profile = DemoPlatformProfile.from(
              context,
              constraints.maxWidth,
            );
            final isWide = profile.isWideLayout;

            return Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      HeaderSection(profile: profile, isWide: isWide),
                      const SizedBox(height: 18),
                      ListenableBuilder(
                        listenable: _controller,
                        builder: (context, _) {
                          final card = DemoCard(
                            profile: profile,
                            progress: _controller.progress,
                            zoomController: _controller.zoomController,
                            showLabels: _controller.showLabels,
                            labelBehavior: _controller.labelBehavior,
                            dragMode: _controller.dragMode,
                            enableDoubleTapZoom:
                                _controller.enableDoubleTapZoom,
                            enableContainerScale:
                                _controller.enableContainerScale,
                            containerScaleMax: _controller.containerScaleMax,
                            containerScaleZoomRange:
                                _controller.containerScaleZoomRange,
                          );
                          final panel = ControlPanel(
                            profile: profile,
                            progress: _controller.progress,
                            onResetZoom: _controller.resetZoom,
                            onPrepareWebDemo: _controller.prepareWebDemo,
                            showLabels: _controller.showLabels,
                            onShowLabelsChanged: _controller.setShowLabels,
                            enableDoubleTapZoom:
                                _controller.enableDoubleTapZoom,
                            onEnableDoubleTapZoomChanged:
                                _controller.setEnableDoubleTapZoom,
                            enableContainerScale:
                                _controller.enableContainerScale,
                            onEnableContainerScaleChanged:
                                _controller.setEnableContainerScale,
                            containerScaleMax: _controller.containerScaleMax,
                            onContainerScaleMaxChanged:
                                _controller.setContainerScaleMax,
                            containerScaleZoomRange:
                                _controller.containerScaleZoomRange,
                            onContainerScaleZoomRangeChanged:
                                _controller.setContainerScaleZoomRange,
                            containerScalePreset:
                                _controller.containerScalePreset,
                            onContainerScalePresetChanged:
                                _controller.applyContainerScalePreset,
                            dragMode: _controller.dragMode,
                            onDragModeChanged: _controller.setDragMode,
                            labelBehavior: _controller.labelBehavior,
                            onLabelBehaviorChanged:
                                _controller.setLabelBehavior,
                          );

                          if (isWide) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(flex: 7, child: card),
                                const SizedBox(width: 16),
                                Expanded(flex: 4, child: panel),
                              ],
                            );
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              card,
                              const SizedBox(height: 16),
                              panel,
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 18),
                      InfoSection(profile: profile),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
