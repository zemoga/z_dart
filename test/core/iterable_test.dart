import 'package:test/test.dart';
import 'package:z_dart/core.dart';

void main() {
  test('firstOrNull_noElemendFound_resultIsNull', () {
    final iterable = [];
    final result = iterable.firstOrNull;

    expect(result, isNull);
  });
  test('firstOrNull_elementFound_resultIsFirstElement', () {
    final iterable = ['A', 'B'];
    final expectedValue = iterable.first;
    final result = iterable.firstOrNull;

    expect(result, isNotNull);
    expect(result, expectedValue);
  });
  test('lastOrNull_noElemendFound_resultIsNull', () {
    final iterable = [];
    final result = iterable.lastOrNull;

    expect(result, isNull);
  });
  test('lastOrNull_elementFound_resultIsLastElement', () {
    final iterable = ['A', 'B'];
    final expectedValue = iterable.last;
    final result = iterable.lastOrNull;

    expect(result, isNotNull);
    expect(result, expectedValue);
  });
  test('singleOrNull_noElementFound_resultIsNull', () {
    final iterable = [];
    final result = iterable.singleOrNull;

    expect(result, isNull);
  });
  test('singleOrNull_elementFound_resultIsSingleElement', () {
    final iterable = ['A'];
    final expectedValue = iterable.single;
    final result = iterable.singleOrNull;

    expect(result, isNotNull);
    expect(result, expectedValue);
  });
}
