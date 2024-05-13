import "package:flutter/material.dart";

class MaterialTheme {
  const MaterialTheme();

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff236488),
      surfaceTint: Color(0xff236488),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffc7e7ff),
      onPrimaryContainer: Color(0xff001e2e),
      secondary: Color(0xff1d6586),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffc4e7ff),
      onSecondaryContainer: Color(0xff001e2c),
      tertiary: Color(0xff6e5d0e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xfffae287),
      onTertiaryContainer: Color(0xff221b00),
      error: Color(0xff904a43),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad5),
      onErrorContainer: Color(0xff3b0907),
      background: Color(0xfff6fafe),
      onBackground: Color(0xff181c20),
      surface: Color(0xfff6fafe),
      onSurface: Color(0xff181c20),
      surfaceVariant: Color(0xffdde3ea),
      onSurfaceVariant: Color(0xff41484d),
      outline: Color(0xff71787e),
      outlineVariant: Color(0xffc1c7ce),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3135),
      inverseOnSurface: Color(0xffeef1f6),
      inversePrimary: Color(0xff93cdf6),
      primaryFixed: Color(0xffc7e7ff),
      onPrimaryFixed: Color(0xff001e2e),
      primaryFixedDim: Color(0xff93cdf6),
      onPrimaryFixedVariant: Color(0xff004c6d),
      secondaryFixed: Color(0xffc4e7ff),
      onSecondaryFixed: Color(0xff001e2c),
      secondaryFixedDim: Color(0xff90cef4),
      onSecondaryFixedVariant: Color(0xff004c69),
      tertiaryFixed: Color(0xfffae287),
      onTertiaryFixed: Color(0xff221b00),
      tertiaryFixedDim: Color(0xffddc66e),
      onTertiaryFixedVariant: Color(0xff544600),
      surfaceDim: Color(0xffd7dadf),
      surfaceBright: Color(0xfff6fafe),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f4f9),
      surfaceContainer: Color(0xffebeef3),
      surfaceContainerHigh: Color(0xffe5e8ed),
      surfaceContainerHighest: Color(0xffdfe3e7),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xff93cdf6),
      surfaceTint: Color(0xff93cdf6),
      onPrimary: Color(0xff00344c),
      primaryContainer: Color(0xff004c6d),
      onPrimaryContainer: Color(0xffc7e7ff),
      secondary: Color(0xff90cef4),
      onSecondary: Color(0xff00344a),
      secondaryContainer: Color(0xff004c69),
      onSecondaryContainer: Color(0xffc4e7ff),
      tertiary: Color(0xffddc66e),
      onTertiary: Color(0xff3a3000),
      tertiaryContainer: Color(0xff544600),
      onTertiaryContainer: Color(0xfffae287),
      error: Color(0xffffb4ab),
      onError: Color(0xff561e19),
      errorContainer: Color(0xff73342d),
      onErrorContainer: Color(0xffffdad5),
      background: Color(0xff101417),
      onBackground: Color(0xffdfe3e7),
      surface: Color(0xff101417),
      onSurface: Color(0xffdfe3e7),
      surfaceVariant: Color(0xff41484d),
      onSurfaceVariant: Color(0xffc1c7ce),
      outline: Color(0xff8b9198),
      outlineVariant: Color(0xff41484d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdfe3e7),
      inverseOnSurface: Color(0xff2d3135),
      inversePrimary: Color(0xff236488),
      primaryFixed: Color(0xffc7e7ff),
      onPrimaryFixed: Color(0xff001e2e),
      primaryFixedDim: Color(0xff93cdf6),
      onPrimaryFixedVariant: Color(0xff004c6d),
      secondaryFixed: Color(0xffc4e7ff),
      onSecondaryFixed: Color(0xff001e2c),
      secondaryFixedDim: Color(0xff90cef4),
      onSecondaryFixedVariant: Color(0xff004c69),
      tertiaryFixed: Color(0xfffae287),
      onTertiaryFixed: Color(0xff221b00),
      tertiaryFixedDim: Color(0xffddc66e),
      onTertiaryFixedVariant: Color(0xff544600),
      surfaceDim: Color(0xff101417),
      surfaceBright: Color(0xff353a3d),
      surfaceContainerLowest: Color(0xff0a0f12),
      surfaceContainerLow: Color(0xff181c20),
      surfaceContainer: Color(0xff1c2024),
      surfaceContainerHigh: Color(0xff262a2e),
      surfaceContainerHighest: Color(0xff313539),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
      );
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}
