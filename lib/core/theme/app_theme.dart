// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';
import '../../data/models/game_models.dart';

class AppTheme {
  static ThemeData createTheme(ColorPalette palette) {
    final primaryColor = parseColor(palette.primary);
    final secondaryColor = parseColor(palette.secondary);
    final backgroundColor = parseColor(palette.background);
    final surfaceColor = parseColor(palette.surface);
    
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
      primary: primaryColor,
      secondary: secondaryColor,
      surface: surfaceColor,
      background: backgroundColor,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      
      // ===== APP BAR THEME =====
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: primaryColor,
        foregroundColor: parseColor(palette.onPrimary),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: parseColor(palette.onPrimary),
          fontFamily: 'GameFont',
        ),
      ),

      // ===== CARD THEME =====
      cardTheme: CardThemeData(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: surfaceColor,
        shadowColor: primaryColor.withOpacity(0.2),
      ),

      // ===== ELEVATED BUTTON THEME =====
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: parseColor(palette.onPrimary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'GameFont',
          ),
        ),
      ),

      // ===== OUTLINED BUTTON THEME =====
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: BorderSide(color: primaryColor, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'GameFont',
          ),
        ),
      ),

      // ===== TEXT BUTTON THEME =====
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),

      // ===== INPUT DECORATION THEME =====
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        filled: true,
        fillColor: surfaceColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),

      // ===== TEXT THEMES =====
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: parseColor(palette.onBackground),
          fontFamily: 'GameFont',
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: parseColor(palette.onBackground),
          fontFamily: 'GameFont',
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: parseColor(palette.onBackground),
          fontFamily: 'GameFont',
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: parseColor(palette.onBackground),
          fontFamily: 'GameFont',
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: parseColor(palette.onBackground),
          fontFamily: 'GameFont',
        ),
        titleSmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: parseColor(palette.onBackground),
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: parseColor(palette.onBackground),
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: parseColor(palette.onBackground),
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          color: parseColor(palette.onBackground).withOpacity(0.7),
        ),
      ),

      // ===== ICON THEME =====
      iconTheme: IconThemeData(
        color: primaryColor,
        size: 24,
      ),

      // ===== FLOATING ACTION BUTTON THEME =====
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: secondaryColor,
        foregroundColor: parseColor(palette.onSecondary),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // ===== NAVIGATION BAR THEME =====
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surfaceColor,
        indicatorColor: primaryColor.withOpacity(0.2),
        iconTheme: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return IconThemeData(color: primaryColor);
          }
          return IconThemeData(color: primaryColor.withOpacity(0.6));
        }),
        labelTextStyle: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            );
          }
          return TextStyle(
            color: primaryColor.withOpacity(0.6),
            fontSize: 12,
          );
        }),
      ),

      // ===== DIALOG THEME =====
      dialogTheme: DialogThemeData(
        backgroundColor: surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 16,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: parseColor(palette.onSurface),
          fontFamily: 'GameFont',
        ),
        contentTextStyle: TextStyle(
          fontSize: 16,
          color: parseColor(palette.onSurface),
        ),
      ),

      // ===== BOTTOM SHEET THEME =====
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surfaceColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        elevation: 16,
      ),

      // ===== PROGRESS INDICATOR THEME =====
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: primaryColor,
        linearTrackColor: primaryColor.withOpacity(0.2),
        circularTrackColor: primaryColor.withOpacity(0.2),
      ),

      // ===== DIVIDER THEME =====
      dividerTheme: DividerThemeData(
        color: primaryColor.withOpacity(0.2),
        thickness: 1,
        space: 1,
      ),

      // ===== BACKGROUND COLOR =====
      scaffoldBackgroundColor: backgroundColor,
      canvasColor: backgroundColor,
    );
  }

  // ===== COLOR PARSING UTILITY =====
  static Color parseColor(String hexColor) {
    String hex = hexColor.replaceAll('#', '');
    if (hex.length == 6) hex = 'FF$hex';
    return Color(int.parse(hex, radix: 16));
  }

  // ===== GRADIENT UTILITIES =====
  static LinearGradient createPrimaryGradient(ColorPalette palette) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        parseColor(palette.primary),
        parseColor(palette.secondary),
      ],
    );
  }

  static LinearGradient createAccentGradient(ColorPalette palette) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        parseColor(palette.secondary),
        parseColor(palette.accent),
      ],
    );
  }

  static LinearGradient createBackgroundGradient(ColorPalette palette) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        parseColor(palette.background),
        parseColor(palette.surface),
      ],
    );
  }

  // ===== SHADOW UTILITIES =====
  static List<BoxShadow> createElevatedShadow(ColorPalette palette, {double elevation = 4}) {
    return [
      BoxShadow(
        color: parseColor(palette.primary).withOpacity(0.1),
        blurRadius: elevation * 2,
        offset: Offset(0, elevation),
      ),
      BoxShadow(
        color: parseColor(palette.primary).withOpacity(0.05),
        blurRadius: elevation,
        offset: Offset(0, elevation / 2),
      ),
    ];
  }

  static List<BoxShadow> createGlowShadow(ColorPalette palette, {double intensity = 0.3}) {
    return [
      BoxShadow(
        color: parseColor(palette.primary).withOpacity(intensity),
        blurRadius: 20,
        spreadRadius: 2,
      ),
    ];
  }

  // ===== ANIMATION CURVES =====
  static const Curve defaultCurve = Curves.easeInOutCubic;
  static const Curve bounceCurve = Curves.elasticOut;
  static const Curve quickCurve = Curves.easeOutQuart;
  static const Curve slowCurve = Curves.easeInOutQuart;

  // ===== ANIMATION DURATIONS =====
  static const Duration fastDuration = Duration(milliseconds: 150);
  static const Duration normalDuration = Duration(milliseconds: 300);
  static const Duration slowDuration = Duration(milliseconds: 500);
  static const Duration extraSlowDuration = Duration(milliseconds: 800);

  // ===== RESPONSIVE BREAKPOINTS =====
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;
  static const double largeDesktopBreakpoint = 1600;

  // ===== SPACING SYSTEM =====
  static const double spacingXS = 4;
  static const double spacingSM = 8;
  static const double spacingMD = 16;
  static const double spacingLG = 24;
  static const double spacingXL = 32;
  static const double spacingXXL = 48;

  // ===== BORDER RADIUS SYSTEM =====
  static const double radiusSM = 8;
  static const double radiusMD = 12;
  static const double radiusLG = 16;
  static const double radiusXL = 20;
  static const double radiusXXL = 24;

  // ===== RESPONSIVE UTILITY =====
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileBreakpoint;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileBreakpoint && width < desktopBreakpoint;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= desktopBreakpoint;
  }

  static bool isLargeDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= largeDesktopBreakpoint;
  }

  // ===== GAME SPECIFIC STYLES =====
  static BoxDecoration createCardDecoration(ColorPalette palette, {bool isFlipped = false}) {
    return BoxDecoration(
      gradient: isFlipped 
          ? createAccentGradient(palette)
          : createPrimaryGradient(palette),
      borderRadius: BorderRadius.circular(radiusMD),
      boxShadow: createElevatedShadow(palette),
      border: Border.all(
        color: parseColor(palette.accent).withOpacity(0.3),
        width: 2,
      ),
    );
  }

  static BoxDecoration createGameButtonDecoration(ColorPalette palette, {bool isPressed = false}) {
    return BoxDecoration(
      gradient: createPrimaryGradient(palette),
      borderRadius: BorderRadius.circular(radiusLG),
      boxShadow: isPressed 
          ? createElevatedShadow(palette, elevation: 2)
          : createElevatedShadow(palette, elevation: 6),
    );
  }

  static TextStyle createScoreTextStyle(ColorPalette palette) {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: parseColor(palette.primary),
      fontFamily: 'GameFont',
      shadows: [
        Shadow(
          offset: const Offset(0, 2),
          blurRadius: 4,
          color: parseColor(palette.primary).withOpacity(0.3),
        ),
      ],
    );
  }
}