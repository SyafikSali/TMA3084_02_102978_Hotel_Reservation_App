import 'package:flutter/material.dart';

import 'booking_form_page.dart';

void main() => runApp(const HotelReservationApp());

class HotelReservationApp extends StatelessWidget {
  const HotelReservationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Hotel Reservation App',
      home: BookingFormPage(),
    );
  }
}
