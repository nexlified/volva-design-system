import 'package:flutter/material.dart';

import '../tokens/vds_tokens.dart';

enum VdsAvatarSize { sm, md, lg, xl }

/// Mirrors components/avatar. Falls back to [initials] when [src] is null or fails to load.
class VdsAvatar extends StatelessWidget {
  const VdsAvatar({
    super.key,
    this.src,
    this.initials = '',
    this.size = VdsAvatarSize.md,
    this.square = false,
    this.semanticLabel,
  });

  final String? src;
  final String initials;
  final VdsAvatarSize size;
  final bool square;
  final String? semanticLabel;

  double get _px => switch (size) {
        VdsAvatarSize.sm => 28,
        VdsAvatarSize.md => 40,
        VdsAvatarSize.lg => 56,
        VdsAvatarSize.xl => 96,
      };

  @override
  Widget build(BuildContext context) {
    final fallback = Center(
      child: Text(initials,
          style: TextStyle(
            color: VdsColorTokens.brandHover,
            fontWeight: VdsFontTokens.weightSemibold,
            fontSize: _px * .38,
          )),
    );
    return Semantics(
      label: semanticLabel,
      image: true,
      child: Container(
        width: _px,
        height: _px,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: VdsColorTokens.brandSubtle,
          border: Border.all(color: VdsColorTokens.borderDefault),
          borderRadius: BorderRadius.circular(square ? VdsRadiusTokens.lg : VdsRadiusTokens.full),
        ),
        child: src == null
            ? fallback
            : Image.network(src!, fit: BoxFit.cover, errorBuilder: (_, __, ___) => fallback),
      ),
    );
  }
}
