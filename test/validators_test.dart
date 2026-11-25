import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_reservation_app/validators.dart';

void main() {
  group('validateName', () {
    test('rejects null', () {
      expect(validateName(null), 'Please enter your name');
    });

    test('rejects an empty or blank name', () {
      expect(validateName(''), 'Please enter your name');
      expect(validateName('   '), 'Please enter your name');
    });

    test('rejects a name with fewer than 3 characters', () {
      expect(validateName('Al'), 'Name must have at least 3 characters');
    });

    test('accepts a name with 3 or more characters', () {
      expect(validateName('Ali'), isNull);
      expect(validateName('  Siti Aminah  '), isNull);
    });
  });

  group('validateEmail', () {
    test('rejects empty and invalid emails', () {
      expect(validateEmail(''), 'Please enter your email');
      expect(validateEmail('ali@'), 'Enter a valid email address');
    });

    test('accepts a valid email', () {
      expect(validateEmail('ali@mail.com'), isNull);
    });
  });

  group('validatePhone', () {
    test('rejects empty or invalid phone numbers', () {
      expect(validatePhone(''), 'Please enter your phone number');
      expect(validatePhone('12345'), 'Use 10 or 11 digits, numbers only');
    });

    test('accepts 10 or 11 digits', () {
      expect(validatePhone('0123456789'), isNull);
      expect(validatePhone('01234567890'), isNull);
    });
  });

  group('validateCheckIn', () {
    test('rejects null date and accepts a date', () {
      expect(validateCheckIn(null), 'Choose a check-in date');
      expect(validateCheckIn(DateTime(2026, 11, 20)), isNull);
    });
  });

  group('validateAgreement', () {
    test('rejects false and accepts true', () {
      expect(validateAgreement(false), 'Please accept the hotel policy');
      expect(validateAgreement(true), isNull);
    });
  });
}
