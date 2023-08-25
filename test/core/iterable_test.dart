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
  test('firstWhereOrNull_noElemendFound_resultIsNull', () {
    final iterable = [];
    final result = iterable.firstWhereOrNull((element) => element < 5);

    expect(result, isNull);
  });
  test('firstWhereOrNull_elementFound_resultIsFirstElement', () {
    final iterable = [1, 2, 3, 5, 6, 7];
    final expectedValue = 1;
    final result = iterable.firstWhereOrNull((element) => element < 5);

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
  test('lastWhereOrNull_noElemendFound_resultIsNull', () {
    final iterable = [];
    final result = iterable.lastWhereOrNull((element) => element < 5);

    expect(result, isNull);
  });
  test('lastWhereOrNull_elementFound_resultIsLastElement', () {
    final iterable = [1, 2, 3, 5, 6, 7];
    final expectedValue = 3;
    final result = iterable.lastWhereOrNull((element) => element < 5);

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
  test('singleWhereOrNull_noElemendFound_resultIsNull', () {
    final iterable = [2, 2, 10];
    final result = iterable.singleWhereOrNull((element) => element == 2);

    expect(result, isNull);
  });
  test('singleWhereOrNull_elementFound_resultIsSingleElement', () {
    final iterable = [2, 2, 10];
    final expectedValue = 10;
    final result = iterable.singleWhereOrNull((element) => element > 5);

    expect(result, isNotNull);
    expect(result, expectedValue);
  });
}
