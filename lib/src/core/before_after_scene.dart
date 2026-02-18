part of '../before_after.dart';

class _BeforeAfterScene extends StatelessWidget {
  const _BeforeAfterScene({
    required this.fullSize,
    required this.visual,
    required this.progress,
    required this.sideContent,
    required this.enableZoom,
    required this.showLabels,
    required this.labelBehavior,
    required this.enableReverseZoomVisualEffect,
    required this.reverseZoomEffectBorderRadius,
    required this.overlayBuilder,
    required this.overlayStyle,
    required this.zoomController,
  });

  final Size fullSize;
  final _VisualGeometry visual;
  final double progress;
  final _SideContent sideContent;
  final bool enableZoom;
  final bool showLabels;
  final LabelBehavior labelBehavior;
  final bool enableReverseZoomVisualEffect;
  final double reverseZoomEffectBorderRadius;
  final Widget Function(Size size, Offset position)? overlayBuilder;
  final OverlayStyle overlayStyle;
  final ZoomController zoomController;

  @override
  Widget build(BuildContext context) {
    final dividerScreenX = visual.offsetX + progress * visual.width;
    final rawDividerLocalX = dividerScreenX - visual.offsetX;
    final dividerLocalX = rawDividerLocalX.clamp(0.0, visual.width);
    final containerScale = visual.containerScale;
    final scaleProgress = (containerScale - 1.0).clamp(0.0, 1.0);
    final contentScaleY = 1.0 + scaleProgress * 1.4;
    const contentScaleX = 1.0;
    final centerX = visual.width / 2;
    final expandedHeight = visual.height * contentScaleY;
    final overflowY =
        (expandedHeight - visual.height).clamp(0.0, double.infinity) / 2;
    final dividerLocalXForScaledContent = containerScale == 1.0
        ? dividerLocalX
        : ((dividerLocalX - centerX) / contentScaleX + centerX)
            .clamp(0.0, visual.width);
    final isAttachedLabels = labelBehavior == LabelBehavior.attachedToContent;
    final isStaticLabels = labelBehavior == LabelBehavior.staticOverlaySafe;

    Widget buildZoomableContent(double dividerContentX) {
      Widget content = RepaintBoundary(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(child: sideContent.rightChild),
            Positioned.fill(
              child: ClipRect(
                clipper: _LeftRectClipper(dividerContentX),
                child: sideContent.leftChild,
              ),
            ),
          ],
        ),
      );

      if (enableZoom) {
        content = Transform(
          transform: zoomController.transformationMatrix,
          alignment: Alignment.center,
          child: content,
        );
      }
      return content;
    }

    final zoomableContent = enableZoom
        ? AnimatedBuilder(
            animation: zoomController,
            builder: (context, _) {
              final dividerContentX = ((dividerLocalXForScaledContent -
                              centerX -
                              zoomController.pan.dx) /
                          zoomController.effectiveZoom +
                      centerX)
                  .clamp(0.0, visual.width);
              return buildZoomableContent(dividerContentX);
            },
          )
        : buildZoomableContent(dividerLocalXForScaledContent);

    final overlayVerticalOverflow = overflowY;
    final overlayHeight = visual.height + overlayVerticalOverflow * 2;
    final overlaySize = Size(visual.width, overlayHeight);
    final overlayPos = Offset(dividerLocalX, overlayHeight / 2);

    final overlay = overlayBuilder?.call(
          overlaySize,
          overlayPos,
        ) ??
        DefaultOverlay(
          width: overlaySize.width,
          height: overlaySize.height,
          position: overlayPos,
          style: overlayStyle,
        );

    final shrinkStrength =
        (1.0 - visual.width / fullSize.width).clamp(0.0, 1.0);
    final shadowAlpha = enableReverseZoomVisualEffect
        ? (0.05 + shrinkStrength * 0.18).clamp(0.0, 0.3)
        : 0.0;
    final radius = reverseZoomEffectBorderRadius;

    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        Center(
          child: Builder(
            builder: (context) {
              final contentLayer = ClipRRect(
                borderRadius: BorderRadius.circular(radius),
                child: zoomableContent,
              );
              final sceneBody = SizedBox(
                width: visual.width,
                height: visual.height,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: shadowAlpha),
                        blurRadius: 22,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: [
                      Stack(
                        fit: StackFit.expand,
                        children: [
                          if (containerScale == 1.0)
                            contentLayer
                          else
                            OverflowBox(
                              alignment: Alignment.center,
                              minWidth: visual.width,
                              maxWidth: visual.width,
                              minHeight: expandedHeight,
                              maxHeight: expandedHeight,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(radius),
                                child: SizedBox(
                                  width: visual.width,
                                  height: expandedHeight,
                                  child: Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.diagonal3Values(
                                      contentScaleX,
                                      contentScaleY,
                                      1.0,
                                    ),
                                    child: contentLayer,
                                  ),
                                ),
                              ),
                            ),
                          if (showLabels && isAttachedLabels)
                            Positioned.fill(
                              child: OverflowBox(
                                alignment: Alignment.center,
                                minWidth: visual.width,
                                maxWidth: visual.width,
                                minHeight: expandedHeight,
                                maxHeight: expandedHeight,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(radius),
                                  child: SizedBox(
                                    width: visual.width,
                                    height: expandedHeight,
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        ClipRect(
                                          clipper:
                                              _LeftRectClipper(dividerLocalX),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: RepaintBoundary(
                                              child: sideContent.leftLabel,
                                            ),
                                          ),
                                        ),
                                        ClipRect(
                                          clipper:
                                              _RightRectClipper(dividerLocalX),
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: RepaintBoundary(
                                              child: sideContent.rightLabel,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      Positioned.fill(
                        child: OverflowBox(
                          alignment: Alignment.center,
                          minWidth: overlaySize.width,
                          maxWidth: overlaySize.width,
                          minHeight: overlaySize.height,
                          maxHeight: overlaySize.height,
                          child: RepaintBoundary(child: overlay),
                        ),
                      ),
                      if (showLabels && isStaticLabels)
                        Align(
                          alignment: Alignment.topLeft,
                          child: RepaintBoundary(
                            child: sideContent.leftLabel,
                          ),
                        ),
                      if (showLabels && isStaticLabels)
                        Align(
                          alignment: Alignment.topRight,
                          child: RepaintBoundary(
                            child: sideContent.rightLabel,
                          ),
                        ),
                    ],
                  ),
                ),
              );
              return sceneBody;
            },
          ),
        ),
      ],
    );
  }
}
