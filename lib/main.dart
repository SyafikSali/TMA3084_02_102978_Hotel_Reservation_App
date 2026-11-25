import 'package:flutter/material.dart';

import 'booking_form_page.dart';

void main() => runApp(const ParkHyattSeoulApp());

class ParkHyattSeoulApp extends StatelessWidget {
  const ParkHyattSeoulApp({super.key});

  @override
  Widget build(BuildContext context) {
    const obsidian = Color(0xFF14171A);
    const champagneGold = Color(0xFFC5A059);
    const ivorySurface = Color(0xFFFAF8F5);
    const warmSand = Color(0xFFF1ECE1);

    final colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: obsidian,
      onPrimary: const Color(0xFFFAF8F5),
      primaryContainer: warmSand,
      onPrimaryContainer: obsidian,
      secondary: champagneGold,
      onSecondary: obsidian,
      secondaryContainer: const Color(0xFFF6EFE0),
      onSecondaryContainer: const Color(0xFF3A2B0E),
      tertiary: const Color(0xFF5C4B32),
      onTertiary: Colors.white,
      error: const Color(0xFF9E2A2B),
      onError: Colors.white,
      surface: Colors.white,
      onSurface: obsidian,
      surfaceContainerHighest: warmSand,
      onSurfaceVariant: const Color(0xFF5A554E),
      outline: const Color(0xFFD6CEC0),
      outlineVariant: const Color(0xFFE6DFD3),
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: obsidian,
      onInverseSurface: ivorySurface,
      inversePrimary: champagneGold,
    );

    return MaterialApp(
      title: 'Park Hyatt Seoul',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: ivorySurface,
        appBarTheme: const AppBarTheme(
          backgroundColor: obsidian,
          foregroundColor: Color(0xFFFAF8F5),
          centerTitle: false,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(color: Color(0xFFE6DFD3)),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: obsidian,
            foregroundColor: champagneGold,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: obsidian,
            side: const BorderSide(color: champagneGold, width: 1.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: const BookingFormPage(),
    );
  }
}
