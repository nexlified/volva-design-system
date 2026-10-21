import 'package:flutter/material.dart';

import '../tokens/vds_tokens.dart';

/// Mirrors components/search-bar. Keyword field + optional location field.
class VdsSearchBar extends StatelessWidget {
  const VdsSearchBar({
    super.key,
    this.queryController,
    this.locationController,
    this.showLocation = true,
    this.hint = 'Search vendors and products',
    this.onSubmitted,
  });

  final TextEditingController? queryController;
  final TextEditingController? locationController;
  final bool showLocation;
  final String hint;
  final VoidCallback? onSubmitted;

  @override
  Widget build(BuildContext context) {
    InputDecoration deco(String h, IconData i) => InputDecoration(
          hintText: h,
          prefixIcon: Icon(i, color: VdsColorTokens.textSubtle),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          filled: false,
        );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: VdsSpaceTokens.n2),
      decoration: BoxDecoration(
        color: VdsColorTokens.surfaceDefault,
        border: Border.all(color: VdsColorTokens.borderStrong),
        borderRadius: BorderRadius.circular(VdsRadiusTokens.full),
        boxShadow: const [VdsShadowTokens.md],
      ),
      child: Row(children: [
        Expanded(
          child: TextField(
            controller: queryController,
            textInputAction: TextInputAction.search,
            onSubmitted: (_) => onSubmitted?.call(),
            decoration: deco(hint, Icons.search),
          ),
        ),
        if (showLocation) ...[
          Container(width: 1, height: VdsSpaceTokens.n6, color: VdsColorTokens.borderDefault),
          Expanded(
            child: TextField(
              controller: locationController,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => onSubmitted?.call(),
              decoration: deco('Location', Icons.place_outlined),
            ),
          ),
        ],
      ]),
    );
  }
}
