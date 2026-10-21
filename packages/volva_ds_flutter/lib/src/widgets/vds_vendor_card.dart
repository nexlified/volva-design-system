import 'package:flutter/material.dart';

import '../tokens/vds_tokens.dart';
import 'vds_avatar.dart';
import 'vds_badge.dart';
import 'vds_rating.dart';

/// Mirrors components/vendor-card (vertical + horizontal + skeleton via [VdsVendorCard.skeleton]).
class VdsVendorCard extends StatelessWidget {
  const VdsVendorCard({
    super.key,
    required this.name,
    this.onTap,
    this.image,
    this.logo,
    this.category,
    this.location,
    this.distance,
    this.rating,
    this.reviewCount,
    this.verified = false,
    this.featured = false,
    this.openNow,
    this.horizontal = false,
  }) : _skeleton = false;

  const VdsVendorCard.skeleton({super.key, this.horizontal = false})
      : name = '',
        onTap = null,
        image = null,
        logo = null,
        category = null,
        location = null,
        distance = null,
        rating = null,
        reviewCount = null,
        verified = false,
        featured = false,
        openNow = null,
        _skeleton = true;

  final String name;
  final VoidCallback? onTap;
  final String? image;
  final String? logo;
  final String? category;
  final String? location;
  final String? distance;
  final double? rating;
  final int? reviewCount;
  final bool verified;
  final bool featured;
  final bool? openNow;
  final bool horizontal;
  final bool _skeleton;

  @override
  Widget build(BuildContext context) {
    final media = AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(fit: StackFit.expand, children: [
        ColoredBox(
          color: VdsColorTokens.surfaceMuted,
          child: image == null ? null : Image.network(image!, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const SizedBox()),
        ),
        if (featured)
          const Positioned(top: VdsSpaceTokens.n3, left: VdsSpaceTokens.n3, child: VdsBadge(label: 'Featured', tone: VdsBadgeTone.warning)),
      ]),
    );

    final meta = TextStyle(fontSize: VdsFontTokens.sizeSm, color: VdsColorTokens.textMuted);
    final body = _skeleton
        ? const Padding(
            padding: EdgeInsets.all(VdsCardTokens.padding),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _SkeletonLine(),
              SizedBox(height: VdsSpaceTokens.n2),
              _SkeletonLine(widthFactor: .55),
            ]),
          )
        : Padding(
            padding: const EdgeInsets.all(VdsCardTokens.padding),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
              Row(children: [
                VdsAvatar(src: logo, initials: name.isEmpty ? '' : name.substring(0, name.length < 2 ? name.length : 2).toUpperCase(), square: true),
                const SizedBox(width: VdsSpaceTokens.n3),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(name, maxLines: 1, overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: VdsFontTokens.sizeLg, fontWeight: VdsFontTokens.weightBold, color: VdsColorTokens.textDefault)),
                    if (category != null) Text(category!, style: meta),
                  ]),
                ),
              ]),
              if (rating != null) ...[
                const SizedBox(height: VdsSpaceTokens.n2),
                VdsRating(value: rating!, count: reviewCount, compact: true),
              ],
              if (location != null || distance != null) ...[
                const SizedBox(height: VdsSpaceTokens.n2),
                Text([location, distance].whereType<String>().join(' · '), style: meta),
              ],
              if (verified || openNow != null) ...[
                const SizedBox(height: VdsSpaceTokens.n2),
                Wrap(spacing: VdsSpaceTokens.n2, runSpacing: VdsSpaceTokens.n1, children: [
                  if (verified) const VdsBadge(label: 'Verified', tone: VdsBadgeTone.brand),
                  if (openNow != null) VdsBadge(label: openNow! ? 'Open now' : 'Closed', tone: openNow! ? VdsBadgeTone.success : VdsBadgeTone.neutral),
                ]),
              ],
            ]),
          );

    final content = horizontal
        ? IntrinsicHeight(
            child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              SizedBox(width: 140, child: Stack(fit: StackFit.expand, children: [
                ColoredBox(color: VdsColorTokens.surfaceMuted, child: image == null ? null : Image.network(image!, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const SizedBox())),
              ])),
              Expanded(child: body),
            ]),
          )
        : Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.min, children: [media, body]);

    return Semantics(
      container: true,
      button: onTap != null,
      label: _skeleton ? 'Loading' : name,
      child: Material(
        color: VdsCardTokens.bg,
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(VdsCardTokens.radius),
          side: BorderSide(color: VdsCardTokens.border),
        ),
        child: InkWell(onTap: onTap, child: content),
      ),
    );
  }
}

class _SkeletonLine extends StatelessWidget {
  const _SkeletonLine({this.widthFactor = 1});
  final double widthFactor;

  @override
  Widget build(BuildContext context) => FractionallySizedBox(
        widthFactor: widthFactor,
        child: DecoratedBox(
          decoration: BoxDecoration(color: VdsColorTokens.surfaceMuted, borderRadius: BorderRadius.circular(VdsRadiusTokens.sm)),
          child: const SizedBox(height: 14),
        ),
      );
}
