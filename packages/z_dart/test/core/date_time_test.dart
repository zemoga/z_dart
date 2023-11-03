import 'package:test/test.dart';
import 'package:z_dart/core.dart';

void main() {
  test('isBetween_dateIsInRange_resultIsTrue', () {
    final start = DateTime(1987, 9, 23);
    final end = DateTime(2023, 9, 23);
    final date = DateTime(2022, 2, 10);
    final result = date.isBetween(start, end);

    expect(result, isTrue);
  });
  test('isBetween_dateIsSameAsStartDate_resultIsTrue', () {
    final start = DateTime(1987, 9, 23);
    final end = DateTime(2023, 9, 23);
    final date = start;
    final result = date.isBetween(start, end);

    expect(result, isTrue);
  });
  test('isBetween_dateIsSameAsEndDate_resultIsTrue', () {
    final start = DateTime(1987, 9, 23);
    final end = DateTime(2023, 9, 23);
    final date = end;
    final result = date.isBetween(start, end);

    expect(result, isTrue);
  });
  test('isBetween_dateIsBeforeStartDate_resultIsFalse', () {
    final start = DateTime(1987, 9, 23);
    final end = DateTime(2023, 9, 23);
    final date = DateTime(1950);
    final result = date.isBetween(start, end);

    expect(result, isFalse);
  });
  test('isBetween_dateIsAfterEndDate_resultIsFalse', () {
    final start = DateTime(1987, 9, 23);
    final end = DateTime(2023, 9, 23);
    final date = DateTime(2030);
    final result = date.isBetween(start, end);

    expect(result, isFalse);
  });
  test('isBetween_dateRangeIsInvalid_resultIsFalse', () {
    final start = DateTime(2023, 9, 23);
    final end = DateTime(1987, 9, 23);
    final date = DateTime(2022, 2, 10);
    final result = date.isBetween(start, end);

    expect(result, isFalse);
  });
}
