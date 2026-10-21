import 'package:flutter/material.dart';

import '../tokens/vds_tokens.dart';

enum VdsButtonVariant { primary, secondary, ghost, danger }

enum VdsButtonSize { sm, md, lg }

/// Mirrors components/button. [onPressed] == null renders the disabled state.
class VdsButton extends StatelessWidget {
  const VdsButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = VdsButtonVariant.primary,
    this.size = VdsButtonSize.md,
    this.loading = false,
    this.fullWidth = false,
    this.icon,
  }) : _iconOnly = false;

  /// Icon-only button (Twig `icon_only`); [label] becomes the semantic label.
  const VdsButton.icon({
    super.key,
    required this.label,
    required IconData this.icon,
    this.onPressed,
    this.variant = VdsButtonVariant.secondary,
    this.size = VdsButtonSize.md,
  })  : loading = false,
        fullWidth = false,
        _iconOnly = true;

  final String label;
  final VoidCallback? onPressed;
  final VdsButtonVariant variant;
  final VdsButtonSize size;
  final bool loading;
  final bool fullWidth;
  final IconData? icon;
  final bool _iconOnly;

  @override
  Widget build(BuildContext context) {
    final (bg, bgHover, fg, border) = switch (variant) {
      VdsButtonVariant.primary => (VdsButtonTokens.primaryBg, VdsButtonTokens.primaryBgHover, VdsButtonTokens.primaryFg, VdsButtonTokens.primaryBorder),
      VdsButtonVariant.secondary => (VdsButtonTokens.secondaryBg, VdsButtonTokens.secondaryBgHover, VdsButtonTokens.secondaryFg, VdsButtonTokens.secondaryBorder),
      VdsButtonVariant.ghost => (VdsButtonTokens.ghostBg, VdsButtonTokens.ghostBgHover, VdsButtonTokens.ghostFg, VdsButtonTokens.ghostBorder),
      VdsButtonVariant.danger => (VdsButtonTokens.dangerBg, VdsButtonTokens.dangerBgHover, VdsButtonTokens.dangerFg, VdsButtonTokens.dangerBorder),
    };
    final (height, padX, fontSize) = switch (size) {
      VdsButtonSize.sm => (VdsButtonTokens.heightSm, VdsButtonTokens.paddingXSm, VdsButtonTokens.fontSizeSm),
      VdsButtonSize.md => (VdsButtonTokens.heightMd, VdsButtonTokens.paddingXMd, VdsButtonTokens.fontSizeMd),
      VdsButtonSize.lg => (VdsButtonTokens.heightLg, VdsButtonTokens.paddingXLg, VdsButtonTokens.fontSizeLg),
    };
    final enabled = onPressed != null && !loading;

    final child = loading
        ? SizedBox(
            width: fontSize,
            height: fontSize,
            child: CircularProgressIndicator(strokeWidth: 2, color: fg),
          )
        : _iconOnly
            ? Icon(icon, size: fontSize + 4)
            : Row(mainAxisSize: MainAxisSize.min, children: [
                if (icon != null) ...[Icon(icon, size: fontSize + 2), const SizedBox(width: VdsSpaceTokens.n2)],
                Text(label),
              ]);

    final button = TextButton(
      onPressed: enabled ? onPressed : null,
      style: ButtonStyle(
        minimumSize: WidgetStatePropertyAll(Size(_iconOnly ? height : 0, height)),
        fixedSize: _iconOnly ? WidgetStatePropertyAll(Size.square(height)) : null,
        padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: _iconOnly ? 0 : padX)),
        foregroundColor: WidgetStatePropertyAll(fg),
        backgroundColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.hovered) || s.contains(WidgetState.pressed) ? bgHover : bg,
        ),
        textStyle: WidgetStatePropertyAll(TextStyle(fontSize: fontSize, fontWeight: VdsButtonTokens.fontWeight)),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(VdsButtonTokens.radius),
          side: BorderSide(color: border),
        )),
      ),
      child: child,
    );

    return Semantics(
      button: true,
      label: _iconOnly ? label : null,
      child: Opacity(
        opacity: onPressed == null ? 0.5 : 1,
        child: fullWidth ? SizedBox(width: double.infinity, child: button) : button,
      ),
    );
  }
}
