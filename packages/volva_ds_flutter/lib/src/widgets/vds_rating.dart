import 'package:flutter/material.dart';

import '../tokens/vds_tokens.dart';

/// Mirrors components/rating. [compact] = single star + number.
class VdsRating extends StatelessWidget {
  const VdsRating({super.key, required this.value, this.count, this.compact = false});

  final double value;
  final int? count;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final label = '${value.toStringAsFixed(1)} out of 5${count != null ? ', $count reviews' : ''}';
    final style = TextStyle(fontSize: VdsFontTokens.sizeSm, color: VdsColorTokens.textDefault);
    return Semantics(
      label: label,
      excludeSemantics: true,
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        if (compact)
          Icon(Icons.star_rounded, size: VdsRatingTokens.size, color: VdsRatingTokens.starFilled)
        else
          for (var i = 0; i < 5; i++)
            Icon(
              value >= i + 1 ? Icons.star_rounded : (value > i ? Icons.star_half_rounded : Icons.star_outline_rounded),
              size: VdsRatingTokens.size,
              color: value > i ? VdsRatingTokens.starFilled : VdsRatingTokens.starEmpty,
            ),
        const SizedBox(width: VdsSpaceTokens.n1),
        Text(value.toStringAsFixed(1), style: style.copyWith(fontWeight: VdsFontTokens.weightSemibold)),
        if (count != null) ...[
          const SizedBox(width: VdsSpaceTokens.n1),
          Text('($count)', style: style.copyWith(color: VdsColorTokens.textMuted)),
        ],
      ]),
    );
  }
}
