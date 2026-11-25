import 'package:flutter/material.dart';

import 'booking_form_page.dart';

void main() => runApp(const HotelReservationApp());

class HotelReservationApp extends StatelessWidget {
  const HotelReservationApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF0F5C6E),
      secondary: const Color(0xFFD9822B),
      brightness: Brightness.light,
    );

    return MaterialApp(
      title: 'Hotel Reservation App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: const Color(0xFFF4F7F8),
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          centerTitle: false,
          elevation: 1,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: colorScheme.outlineVariant),
          ),
          color: Colors.white,
        ),
      ),
      home: const BookingFormPage(),
    );
  }
}
