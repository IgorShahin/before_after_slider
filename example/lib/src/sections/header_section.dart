import 'package:flutter/material.dart';

import '../platform/demo_platform_profile.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key, required this.profile, required this.isWide});

  final DemoPlatformProfile profile;
  final bool isWide;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCompact = !isWide;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFFFFF), Color(0xFFF3F8FF)],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFD6E2F6)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x120C254A),
            blurRadius: 22,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  'before_after_slider',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              _miniBadge(profile.platformBadge),
              if (!isCompact) _miniBadge('Interactive'),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            profile.title,
            style: (isWide
                    ? theme.textTheme.headlineMedium
                    : theme.textTheme.headlineSmall)
                ?.copyWith(fontWeight: FontWeight.w800, height: 1.1),
          ),
          const SizedBox(height: 10),
          Text(
            'A polished interactive demo of divider drag, zoom behavior, and container expansion in an Expanded layout.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _miniBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4FB),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFDDE6F5)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Color(0xFF374151),
        ),
      ),
    );
  }
}
