import 'package:flutter/material.dart';

import '../tokens/vds_tokens.dart';
import 'vds_badge.dart';
import 'vds_price.dart';
import 'vds_rating.dart';

/// Mirrors components/product-card (vertical; horizontal via [horizontal]).
class VdsProductCard extends StatelessWidget {
  const VdsProductCard({
    super.key,
    required this.title,
    this.onTap,
    this.image,
    this.vendorName,
    this.price,
    this.compareAt,
    this.unit,
    this.onRequest = false,
    this.rating,
    this.reviewCount,
    this.badge,
    this.badgeTone = VdsBadgeTone.brand,
    this.available = true,
    this.horizontal = false,
  });

  final String title;
  final VoidCallback? onTap;
  final String? image;
  final String? vendorName;
  final String? price;
  final String? compareAt;
  final String? unit;
  final bool onRequest;
  final double? rating;
  final int? reviewCount;
  final String? badge;
  final VdsBadgeTone badgeTone;
  final bool available;
  final bool horizontal;

  @override
  Widget build(BuildContext context) {
    Widget media = ColoredBox(
      color: VdsColorTokens.surfaceMuted,
      child: image == null
          ? null
          : Image.network(image!, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const SizedBox()),
    );
    if (!available) {
      media = ColorFiltered(
        colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.saturation),
        child: Opacity(opacity: .6, child: media),
      );
    }
    final mediaStack = Stack(fit: StackFit.expand, children: [
      media,
      if (badge != null) Positioned(top: VdsSpaceTokens.n3, left: VdsSpaceTokens.n3, child: VdsBadge(label: badge!, tone: badgeTone)),
      if (!available) const Positioned(top: VdsSpaceTokens.n3, right: VdsSpaceTokens.n3, child: VdsBadge(label: 'Unavailable')),
    ]);

    final body = Padding(
      padding: const EdgeInsets.all(VdsCardTokens.padding),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
        if (vendorName != null)
          Text(vendorName!.toUpperCase(),
              style: TextStyle(fontSize: VdsFontTokens.sizeXs, letterSpacing: .5, color: VdsColorTokens.textSubtle)),
        Text(title, maxLines: 2, overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: VdsFontTokens.sizeMd, fontWeight: VdsFontTokens.weightMedium, color: VdsColorTokens.textDefault)),
        if (rating != null) ...[const SizedBox(height: VdsSpaceTokens.n1), VdsRating(value: rating!, count: reviewCount, compact: true)],
        const SizedBox(height: VdsSpaceTokens.n2),
        VdsPrice(amount: price, compareAt: compareAt, unit: unit, onRequest: onRequest),
      ]),
    );

    final content = horizontal
        ? IntrinsicHeight(
            child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              SizedBox(width: 120, child: mediaStack),
              Expanded(child: body),
            ]),
          )
        : Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.min, children: [
            AspectRatio(aspectRatio: 1, child: mediaStack),
            body,
          ]);

    return Semantics(
      container: true,
      button: onTap != null,
      label: title,
      child: Material(
        color: VdsCardTokens.bg,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(VdsCardTokens.radius),
          side: BorderSide(color: VdsCardTokens.border),
        ),
        child: InkWell(onTap: onTap, child: content),
      ),
    );
  }
}
