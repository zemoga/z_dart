import 'package:test/test.dart';
import 'package:z_dart/ddd.dart';

void main() {
  group('EntityId', () {
    test('.numericValue valid numeric ID', () {
      final numericValue = 123456;
      final mockId = EntityId(numericValue.toString());

      expect(mockId.isNumeric, isTrue);
      expect(mockId.numericValue, equals(numericValue));
    });
    test('.numericValue invalid numeric ID using a negative value', () {
      final invalidNumericValue = -123456;
      final mockId = EntityId(invalidNumericValue.toString());

      expect(mockId.isNumeric, isFalse);
      expect(() => mockId.numericValue, throwsA(isA<FormatException>()));
    });
    test('.numericValue invalid numeric ID using a double value', () {
      final invalidNumericValue = 4.5;
      final mockId = EntityId(invalidNumericValue.toString());

      expect(mockId.isNumeric, isFalse);
      expect(() => mockId.numericValue, throwsA(isA<FormatException>()));
    });
    test('.numericValue invalid numeric ID using a string', () {
      final invalidNumericValue = 'invalid';
      final mockId = EntityId(invalidNumericValue.toString());

      expect(mockId.isNumeric, isFalse);
      expect(() => mockId.numericValue, throwsA(isA<FormatException>()));
    });
  });
}
