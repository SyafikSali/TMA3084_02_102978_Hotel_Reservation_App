import 'package:flutter_test/flutter_test.dart';

class Reservation {
  final String guestName;
  final DateTime checkIn;
  final DateTime checkOut;
  final int guests;
  final int maxGuests;
  final double nightlyRate;
  final double addOnsTotal;
  String status;
  String? bookingRef;

  Reservation({
    required this.guestName,
    required this.checkIn,
    required this.checkOut,
    required this.guests,
    this.maxGuests = 4,
    required this.nightlyRate,
    this.addOnsTotal = 0,
    this.status = 'draft',
    this.bookingRef,
  });

  int get nights => checkOut.difference(checkIn).inDays;

  bool isValid() {
    if (guestName.trim().isEmpty) return false;
    if (!checkOut.isAfter(checkIn)) return false;
    if (guests <= 0 || guests > maxGuests) return false;
    return true;
  }

  double calculateTotal({double taxRate = 0.1}) {
    final base = (nightlyRate * nights) + addOnsTotal;
    final total = base * (1 + taxRate);
    return double.parse(total.toStringAsFixed(2));
  }

  void confirm() {
    if (!isValid()) {
      throw StateError('Invalid reservation');
    }
    status = 'confirmed';
    bookingRef = 'PHS-${checkIn.millisecondsSinceEpoch}';
  }

  void cancel() {
    status = 'cancelled';
  }
}

void main() {
  test('AC1: valid reservation', () {
    final r = Reservation(
      guestName: 'Syafik',
      checkIn: DateTime(2026, 12, 10),
      checkOut: DateTime(2026, 12, 13),
      guests: 2,
      nightlyRate: 450.0,
    );
    expect(r.isValid(), true);
  });

  test('AC2: invalid dates or guests', () {
    final badDates = Reservation(
      guestName: 'Syafik',
      checkIn: DateTime(2026, 12, 12),
      checkOut: DateTime(2026, 12, 12),
      guests: 2,
      nightlyRate: 450.0,
    );
    expect(badDates.isValid(), false);

    final zeroGuests = Reservation(
      guestName: 'Syafik',
      checkIn: DateTime(2026, 12, 10),
      checkOut: DateTime(2026, 12, 12),
      guests: 0,
      nightlyRate: 450.0,
    );
    expect(zeroGuests.isValid(), false);
  });

  test('AC3: total calculation', () {
    final r = Reservation(
      guestName: 'Syafik',
      checkIn: DateTime(2026, 12, 10),
      checkOut: DateTime(2026, 12, 12),
      guests: 2,
      nightlyRate: 300.0,
      addOnsTotal: 50.0,
    );
    expect(r.calculateTotal(taxRate: 0.1), closeTo(715.0, 0.01));
  });

  test('AC4: confirm sets status and ref', () {
    final r = Reservation(
      guestName: 'Syafik',
      checkIn: DateTime(2026, 12, 10),
      checkOut: DateTime(2026, 12, 11),
      guests: 1,
      nightlyRate: 500.0,
    );
    r.confirm();
    expect(r.status, 'confirmed');
    expect(r.bookingRef!.startsWith('PHS-'), true);
  });

  test('AC5: cancel sets status', () {
    final r = Reservation(
      guestName: 'Syafik',
      checkIn: DateTime(2026, 12, 10),
      checkOut: DateTime(2026, 12, 11),
      guests: 1,
      nightlyRate: 500.0,
    );
    r.confirm();
    r.cancel();
    expect(r.status, 'cancelled');
  });
}
