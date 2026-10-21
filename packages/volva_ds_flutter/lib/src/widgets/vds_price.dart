import 'package:flutter/material.dart';

import '../tokens/vds_tokens.dart';

/// Mirrors components/price. [amount] is pre-formatted by the caller (locale logic stays in the app).
class VdsPrice extends StatelessWidget {
  const VdsPrice({
    super.key,
    this.amount,
    this.compareAt,
    this.unit,
    this.large = false,
    this.onRequest = false,
  });

  final String? amount;
  final String? compareAt;
  final String? unit;
  final bool large;
  final bool onRequest;

  @override
  Widget build(BuildContext context) {
    final muted = TextStyle(fontSize: VdsFontTokens.sizeSm, color: VdsColorTokens.textMuted);
    if (onRequest) return Text('Price on request', style: muted);
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(amount ?? '',
            style: TextStyle(
              fontSize: large ? VdsFontTokens.size3xl : VdsFontTokens.sizeLg,
              fontWeight: VdsFontTokens.weightBold,
              color: VdsColorTokens.textDefault,
            )),
        if (unit != null) ...[const SizedBox(width: VdsSpaceTokens.n2), Text(unit!, style: muted)],
        if (compareAt != null) ...[
          const SizedBox(width: VdsSpaceTokens.n2),
          Text(compareAt!, style: muted.copyWith(decoration: TextDecoration.lineThrough)),
        ],
      ],
    );
  }
}
