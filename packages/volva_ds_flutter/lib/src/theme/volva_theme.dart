import 'package:flutter/material.dart';

import '../tokens/vds_tokens.dart';

/// Global config for Flutter: ThemeData built only from generated tokens.
/// Per-component styling lives in each widget, reading its own Vds<Component> tokens.
abstract final class VolvaTheme {
  static ThemeData light() {
    final scheme = ColorScheme.light(
      primary: VdsColorTokens.brandDefault,
      onPrimary: VdsColorTokens.brandOn,
      surface: VdsColorTokens.surfaceDefault,
      onSurface: VdsColorTokens.textDefault,
      error: VdsColorTokens.statusDanger,
      outline: VdsColorTokens.borderStrong,
      outlineVariant: VdsColorTokens.borderDefault,
    );
    final text = TextTheme(
      displaySmall: _t(VdsFontTokens.size4xl, VdsFontTokens.weightBold, VdsFontTokens.lineHeightTight),
      headlineMedium: _t(VdsFontTokens.size3xl, VdsFontTokens.weightBold, VdsFontTokens.lineHeightTight),
      headlineSmall: _t(VdsFontTokens.size2xl, VdsFontTokens.weightBold, VdsFontTokens.lineHeightTight),
      titleLarge: _t(VdsFontTokens.sizeXl, VdsFontTokens.weightSemibold, VdsFontTokens.lineHeightTight),
      titleMedium: _t(VdsFontTokens.sizeLg, VdsFontTokens.weightSemibold, VdsFontTokens.lineHeightTight),
      bodyLarge: _t(VdsFontTokens.sizeLg, VdsFontTokens.weightRegular, VdsFontTokens.lineHeightNormal),
      bodyMedium: _t(VdsFontTokens.sizeMd, VdsFontTokens.weightRegular, VdsFontTokens.lineHeightNormal),
      bodySmall: _t(VdsFontTokens.sizeSm, VdsFontTokens.weightRegular, VdsFontTokens.lineHeightNormal),
      labelLarge: _t(VdsFontTokens.sizeMd, VdsFontTokens.weightSemibold, VdsFontTokens.lineHeightTight),
      labelSmall: _t(VdsFontTokens.sizeXs, VdsFontTokens.weightSemibold, VdsFontTokens.lineHeightTight),
    ).apply(bodyColor: VdsColorTokens.textDefault, displayColor: VdsColorTokens.textDefault);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: VdsColorTokens.surfaceDefault,
      fontFamily: VdsFontTokens.familySans,
      textTheme: text,
      dividerColor: VdsColorTokens.borderDefault,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: VdsInputTokens.bg,
        hintStyle: TextStyle(color: VdsInputTokens.placeholder, fontSize: VdsInputTokens.fontSize),
        contentPadding: EdgeInsets.symmetric(horizontal: VdsInputTokens.paddingX),
        border: _border(VdsInputTokens.border),
        enabledBorder: _border(VdsInputTokens.border),
        focusedBorder: _border(VdsInputTokens.borderFocus, width: 2),
        errorBorder: _border(VdsInputTokens.borderError),
        focusedErrorBorder: _border(VdsInputTokens.borderError, width: 2),
      ),
    );
  }

  static TextStyle _t(double size, FontWeight weight, double height) =>
      TextStyle(fontFamily: VdsFontTokens.familySans, fontSize: size, fontWeight: weight, height: height);

  static OutlineInputBorder _border(Color c, {double width = 1}) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(VdsInputTokens.radius),
        borderSide: BorderSide(color: c, width: width),
      );
}
