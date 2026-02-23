import 'package:before_after_slider/before_after_slider.dart';
import 'package:flutter/material.dart';

import '../platform/demo_platform_profile.dart';
import '../state/demo_controller.dart';

class ControlPanel extends StatelessWidget {
  const ControlPanel({
    super.key,
    required this.profile,
    required this.progress,
    required this.onResetZoom,
    required this.onPrepareWebDemo,
    required this.showLabels,
    required this.onShowLabelsChanged,
    required this.enableDoubleTapZoom,
    required this.onEnableDoubleTapZoomChanged,
    required this.enableContainerScale,
    required this.onEnableContainerScaleChanged,
    required this.containerScaleMax,
    required this.onContainerScaleMaxChanged,
    required this.containerScaleZoomRange,
    required this.onContainerScaleZoomRangeChanged,
    required this.containerScalePreset,
    required this.onContainerScalePresetChanged,
    required this.dragMode,
    required this.onDragModeChanged,
    required this.labelBehavior,
    required this.onLabelBehaviorChanged,
  });

  final DemoPlatformProfile profile;
  final ValueNotifier<double> progress;
  final VoidCallback onResetZoom;
  final VoidCallback onPrepareWebDemo;
  final bool showLabels;
  final ValueChanged<bool> onShowLabelsChanged;
  final bool enableDoubleTapZoom;
  final ValueChanged<bool> onEnableDoubleTapZoomChanged;
  final bool enableContainerScale;
  final ValueChanged<bool> onEnableContainerScaleChanged;
  final double containerScaleMax;
  final ValueChanged<double> onContainerScaleMaxChanged;
  final double containerScaleZoomRange;
  final ValueChanged<double> onContainerScaleZoomRangeChanged;
  final ContainerScalePreset containerScalePreset;
  final ValueChanged<ContainerScalePreset> onContainerScalePresetChanged;
  final SliderDragMode dragMode;
  final ValueChanged<SliderDragMode?> onDragModeChanged;
  final LabelBehavior labelBehavior;
  final ValueChanged<LabelBehavior?> onLabelBehaviorChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFD6E2F6)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x120C254A),
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Controls',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          ValueListenableBuilder<double>(
            valueListenable: progress,
            builder: (context, value, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Progress: ${(value * 100).round()}%'),
                  Slider(
                    value: value,
                    onChanged: (next) => progress.value = next,
                  ),
                ],
              );
            },
          ),
          if (profile.isMobile) ...[
            FilledButton.tonal(
              onPressed: onResetZoom,
              child: const Text('Reset'),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed:
                  profile.showPrepareSceneButton ? onPrepareWebDemo : null,
              child: Text(profile.prepareButtonLabel),
            ),
          ] else
            Row(
              children: [
                Expanded(
                  child: FilledButton.tonal(
                    onPressed: onResetZoom,
                    child: const Text('Reset'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: profile.showPrepareSceneButton
                        ? onPrepareWebDemo
                        : null,
                    child: Text(profile.prepareButtonLabel),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 10),
          _platformHowTo(),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 10),
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            title: const Text('Show labels'),
            value: showLabels,
            onChanged: onShowLabelsChanged,
          ),
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            title: const Text('Enable double-tap zoom'),
            value: enableDoubleTapZoom,
            onChanged: onEnableDoubleTapZoomChanged,
          ),
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            title: const Text('Container scale on zoom'),
            value: enableContainerScale,
            onChanged: onEnableContainerScaleChanged,
          ),
          if (enableContainerScale) ...[
            const SizedBox(height: 4),
            Text(
              'Container scale preset',
              style: theme.textTheme.labelLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('Subtle'),
                  selected: containerScalePreset == ContainerScalePreset.subtle,
                  onSelected: (_) => onContainerScalePresetChanged(
                      ContainerScalePreset.subtle),
                ),
                ChoiceChip(
                  label: const Text('Balanced'),
                  selected:
                      containerScalePreset == ContainerScalePreset.balanced,
                  onSelected: (_) => onContainerScalePresetChanged(
                      ContainerScalePreset.balanced),
                ),
                ChoiceChip(
                  label: const Text('Aggressive'),
                  selected:
                      containerScalePreset == ContainerScalePreset.aggressive,
                  onSelected: (_) => onContainerScalePresetChanged(
                      ContainerScalePreset.aggressive),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Current: max ${containerScaleMax.toStringAsFixed(2)}x, range ${containerScaleZoomRange.toStringAsFixed(2)}',
              style: theme.textTheme.bodySmall,
            ),
            ExpansionTile(
              tilePadding: EdgeInsets.zero,
              childrenPadding: EdgeInsets.zero,
              title: const Text('Advanced tuning'),
              children: [
                Text(
                    'Container scale max: ${containerScaleMax.toStringAsFixed(2)}x'),
                Slider(
                  min: 1.0,
                  max: 1.6,
                  divisions: 30,
                  value: containerScaleMax,
                  onChanged: onContainerScaleMaxChanged,
                ),
                Text(
                    'Container scale zoom range: ${containerScaleZoomRange.toStringAsFixed(2)}'),
                Slider(
                  min: 0.2,
                  max: 2.0,
                  divisions: 36,
                  value: containerScaleZoomRange,
                  onChanged: onContainerScaleZoomRangeChanged,
                ),
              ],
            ),
          ],
          const SizedBox(height: 6),
          DropdownButtonFormField<SliderDragMode>(
            initialValue: dragMode,
            decoration: const InputDecoration(
              labelText: 'Slider drag mode',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(
                value: SliderDragMode.fullOverlay,
                child: Text('fullOverlay'),
              ),
              DropdownMenuItem(
                value: SliderDragMode.thumbOnly,
                child: Text('thumbOnly'),
              ),
            ],
            onChanged: onDragModeChanged,
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<LabelBehavior>(
            initialValue: labelBehavior,
            decoration: const InputDecoration(
              labelText: 'Label behavior',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(
                value: LabelBehavior.staticOverlaySafe,
                child: Text('staticOverlaySafe'),
              ),
              DropdownMenuItem(
                value: LabelBehavior.attachedToContent,
                child: Text('attachedToContent'),
              ),
            ],
            onChanged: onLabelBehaviorChanged,
          ),
        ],
      ),
    );
  }

  Widget _platformHowTo() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7FAFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFDCE6F8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Platform steps',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          ...profile.stepByStep.map(Text.new),
        ],
      ),
    );
  }
}
