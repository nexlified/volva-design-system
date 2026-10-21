import 'package:flutter/material.dart';

import '../tokens/vds_tokens.dart';
import 'vds_button.dart';

/// Mirrors components/empty-state.
class VdsEmptyState extends StatelessWidget {
  const VdsEmptyState({super.key, required this.title, this.description, this.actionLabel, this.onAction});

  final String title;
  final String? description;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: VdsSpaceTokens.n12, horizontal: VdsSpaceTokens.n6),
      decoration: BoxDecoration(
        border: Border.all(color: VdsColorTokens.borderStrong),
        borderRadius: BorderRadius.circular(VdsRadiusTokens.lg),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: VdsFontTokens.sizeXl, fontWeight: VdsFontTokens.weightBold, color: VdsColorTokens.textDefault)),
        if (description != null) ...[
          const SizedBox(height: VdsSpaceTokens.n3),
          Text(description!, textAlign: TextAlign.center, style: TextStyle(color: VdsColorTokens.textMuted)),
        ],
        if (actionLabel != null) ...[
          const SizedBox(height: VdsSpaceTokens.n3),
          VdsButton(label: actionLabel!, variant: VdsButtonVariant.secondary, onPressed: onAction),
        ],
      ]),
    );
  }
}
