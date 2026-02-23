import 'package:flutter/material.dart';

import '../platform/demo_platform_profile.dart';
import '../widgets/stat_pill.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({super.key, required this.profile});

  final DemoPlatformProfile profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFD6E2F6)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F0C254A),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Capabilities',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              const StatPill(text: 'Drag divider'),
              if (profile.isMobile) const StatPill(text: 'Pinch zoom'),
              if (!profile.isMobile)
                StatPill(text: '${profile.modifierLabel} + wheel'),
              const StatPill(text: 'Double-tap zoom'),
              const StatPill(text: 'Container scale demo'),
              const StatPill(text: 'Custom overlay'),
              const StatPill(text: 'Label behavior modes'),
            ],
          ),
        ],
      ),
    );
  }
}
