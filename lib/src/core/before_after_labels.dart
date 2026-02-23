part of '../before_after.dart';

extension _BeforeAfterLabelsX on _BeforeAfterState {
  LabelBehavior get _effectiveLabelBehavior => widget.labelsOptions.behavior;

  _SideContent _resolveSideContent(BuildContext context) {
    _ensureCachedLabels(context);
    if (widget.contentOrder == ContentOrder.beforeAfter) {
      return _SideContent(
        leftChild: widget.beforeChild,
        rightChild: widget.afterChild,
        leftLabel: _cachedLeftLabel!,
        rightLabel: _cachedRightLabel!,
      );
    }

    return _SideContent(
      leftChild: widget.afterChild,
      rightChild: widget.beforeChild,
      leftLabel: _cachedLeftLabel!,
      rightLabel: _cachedRightLabel!,
    );
  }
}
