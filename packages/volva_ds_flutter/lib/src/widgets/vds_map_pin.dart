import 'package:flutter/material.dart';

import '../tokens/vds_tokens.dart';

/// Mirrors components/map-pin. Use as marker child in the host's map widget (google_maps_flutter, flutter_map, ...).
class VdsMapPin extends StatelessWidget {
  const VdsMapPin({super.key, required this.label, this.cluster = false, this.active = false, this.visited = false, this.onTap});

  final String label;
  final bool cluster;
  final bool active;
  final bool visited;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Color bg;
    final Color fg;
    if (cluster) {
      bg = VdsMapTokens.clusterBg;
      fg = VdsMapTokens.clusterFg;
    } else if (active) {
      bg = VdsMapTokens.pinBgActive;
      fg = VdsMapTokens.pinFgActive;
    } else if (visited) {
      bg = VdsColorTokens.surfaceMuted;
      fg = VdsColorTokens.textSubtle;
    } else {
      bg = VdsMapTokens.pinBg;
      fg = VdsMapTokens.pinFg;
    }
    final size = cluster ? VdsMapTokens.clusterSize : VdsMapTokens.pinHeight;
    return Semantics(
      button: true,
      selected: active,
      label: label,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedScale(
          scale: active ? 1.12 : 1,
          duration: VdsMotionTokens.durationFast,
          child: Container(
            height: size,
            constraints: BoxConstraints(minWidth: size),
            padding: EdgeInsets.symmetric(horizontal: cluster ? 0 : VdsSpaceTokens.n3),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: bg,
              shape: cluster ? BoxShape.circle : BoxShape.rectangle,
              borderRadius: cluster ? null : BorderRadius.circular(VdsRadiusTokens.full),
              border: Border.all(
                color: cluster ? VdsColorTokens.surfaceDefault : (active ? bg : VdsMapTokens.pinBorder),
                width: cluster ? 3 : 1,
              ),
              boxShadow: const [VdsShadowTokens.md],
            ),
            child: Text(label, style: TextStyle(color: fg, fontSize: VdsFontTokens.sizeSm, fontWeight: VdsFontTokens.weightSemibold)),
          ),
        ),
      ),
    );
  }
}
