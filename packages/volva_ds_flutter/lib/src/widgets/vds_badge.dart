import 'package:flutter/material.dart';

import '../tokens/vds_tokens.dart';

enum VdsBadgeTone { neutral, brand, success, warning, danger, info }

/// Mirrors components/badge.
class VdsBadge extends StatelessWidget {
  const VdsBadge({super.key, required this.label, this.tone = VdsBadgeTone.neutral});

  final String label;
  final VdsBadgeTone tone;

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (tone) {
      VdsBadgeTone.neutral => (VdsBadgeTokens.neutralBg, VdsBadgeTokens.neutralFg),
      VdsBadgeTone.brand => (VdsBadgeTokens.brandBg, VdsBadgeTokens.brandFg),
      VdsBadgeTone.success => (VdsBadgeTokens.successBg, VdsBadgeTokens.successFg),
      VdsBadgeTone.warning => (VdsBadgeTokens.warningBg, VdsBadgeTokens.warningFg),
      VdsBadgeTone.danger => (VdsBadgeTokens.dangerBg, VdsBadgeTokens.dangerFg),
      VdsBadgeTone.info => (VdsBadgeTokens.infoBg, VdsBadgeTokens.infoFg),
    };
    return DecoratedBox(
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(VdsBadgeTokens.radius)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: VdsBadgeTokens.paddingX, vertical: VdsBadgeTokens.paddingY),
        child: Text(label, style: TextStyle(color: fg, fontSize: VdsBadgeTokens.fontSize, fontWeight: VdsBadgeTokens.fontWeight, height: 1)),
      ),
    );
  }
}
