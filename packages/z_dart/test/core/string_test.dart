import 'package:test/test.dart';
import 'package:z_dart/core.dart';

void main() {
  group('String.isValidPhoneNumber', () {
    test('is valid when phone number is 10 digits with no country code', () {
      final phoneNumber = '3001234556';
      final result = phoneNumber.isValidPhoneNumber;

      expect(result, isTrue);
    });
    test('is valid when phone number is 10 digits with country code', () {
      final phoneNumber = '+573001234556';
      final result = phoneNumber.isValidPhoneNumber;

      expect(result, isTrue);
    });
    test('is invalid when phone number is less than 10 digits', () {
      final phoneNumber = '300123';
      final result = phoneNumber.isValidPhoneNumber;

      expect(result, isFalse);
    });
    test('is invalid when phone number is more than 10 digits', () {
      final phoneNumber = '300123456789';
      final result = phoneNumber.isValidPhoneNumber;

      expect(result, isFalse);
    });
    test('is invalid when phone number contains special characters', () {
      final phoneNumber = '(300)-123 4556';
      final result = phoneNumber.isValidPhoneNumber;

      expect(result, isFalse);
    });
    test('is invalid when phone number is empty', () {
      final phoneNumber = '';
      final result = phoneNumber.isValidPhoneNumber;

      expect(result, isFalse);
    });
  });
  group('isValidEmail', () {
    test('is valid when email has valid structure', () {
      final email = 'test@mail.com';
      final result = email.isValidEmail;

      expect(result, isTrue);
    });
    test('is valid when email with variant has valid structure', () {
      final email = 'test+1@mail.com';
      final result = email.isValidEmail;

      expect(result, isTrue);
    });
    test('is invalid when email has no domain', () {
      final email = 'test';
      final result = email.isValidEmail;

      expect(result, isFalse);
    });
    test('is invalid when email has incomplete domain', () {
      final email = 'test@mail.';
      final result = email.isValidEmail;

      expect(result, isFalse);
    });
    test('is invalid when email consists of domain only', () {
      final email = 'mail.com';
      final result = email.isValidEmail;

      expect(result, isFalse);
    });
    test('is invalid when email is empty', () {
      final email = '';
      final result = email.isValidEmail;

      expect(result, isFalse);
    });
  });
  group('isValidPassword', () {
    test('is valid when password follows a secure pattern', () {
      final password = 'Test123*';
      final result = password.isValidPassword;

      expect(result, isTrue);
    });
    test('is invalid when password has lowercase characters only', () {
      final password = 'abcde';
      final result = password.isValidPassword;

      expect(result, isFalse);
    });
    test('is invalid when password has uppercase characters only', () {
      final password = 'ABCDE';
      final result = password.isValidPassword;

      expect(result, isFalse);
    });
    test('is invalid when password has digits only', () {
      final password = '1234';
      final result = password.isValidPassword;

      expect(result, isFalse);
    });
    test('is invalid when password has no special characters', () {
      final password = 'Abc1234';
      final result = password.isValidPassword;

      expect(result, isFalse);
    });
    test('is invalid when password is empty', () {
      final password = '';
      final result = password.isValidPassword;

      expect(result, isFalse);
    });
  });
}
