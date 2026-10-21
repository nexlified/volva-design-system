import 'package:flutter/material.dart';

import '../tokens/vds_tokens.dart';

/// Mirrors components/chip (filter toggle).
class VdsChip extends StatelessWidget {
  const VdsChip({super.key, required this.label, this.active = false, this.onTap, this.removable = false});

  final String label;
  final bool active;
  final bool removable;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final fg = active ? VdsChipTokens.fgActive : VdsChipTokens.fg;
    return Semantics(
      button: true,
      selected: active,
      child: Material(
        color: active ? VdsChipTokens.bgActive : VdsChipTokens.bg,
        shape: StadiumBorder(side: BorderSide(color: active ? VdsChipTokens.borderActive : VdsChipTokens.border)),
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: VdsChipTokens.height),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: VdsChipTokens.paddingX),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Text(label,
                    style: TextStyle(
                      fontSize: VdsChipTokens.fontSize,
                      color: fg,
                      fontWeight: active ? VdsFontTokens.weightMedium : VdsFontTokens.weightRegular,
                    )),
                if (removable) ...[const SizedBox(width: VdsSpaceTokens.n2), Icon(Icons.close, size: 14, color: fg)],
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
