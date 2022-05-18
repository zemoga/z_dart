import 'package:test/test.dart';
import 'package:z_dart/core.dart';

void main() {
  test('firstEither_noElementFound_eitherIsLeft', () {
    final iterable = [];
    final either = iterable.firstEither;

    expect(either.isLeft(), isTrue);
  });
  test('firstEither_elementFound_eitherIsRight', () {
    final iterable = ['A', 'B'];
    final expectedValue = iterable.first;
    final either = iterable.firstEither;

    expect(either.isRight(), isTrue);
    expect(either | '', expectedValue);
  });
  test('firstOption_noElementFound_optionIsNone', () {
    final iterable = [];
    final option = iterable.firstOption;

    expect(option.isNone(), isTrue);
  });
  test('firstOption_elementFound_optionIsSome', () {
    final iterable = ['A', 'B'];
    final expectedValue = iterable.first;
    final option = iterable.firstOption;

    expect(option.isSome(), isTrue);
    expect(option | '', expectedValue);
  });
  test('lastEither_noElementFound_eitherIsLeft', () {
    final iterable = [];
    final either = iterable.lastEither;

    expect(either.isLeft(), isTrue);
  });
  test('lastEither_elementFound_eitherIsRight', () {
    final iterable = ['A', 'B'];
    final expectedValue = iterable.last;
    final either = iterable.lastEither;

    expect(either.isRight(), isTrue);
    expect(either | '', expectedValue);
  });
  test('lastOption_noElementFound_optionIsNone', () {
    final iterable = [];
    final option = iterable.lastOption;

    expect(option.isNone(), isTrue);
  });
  test('lastOption_elementFound_optionIsSome', () {
    final iterable = ['A', 'B'];
    final expectedValue = iterable.last;
    final option = iterable.lastOption;

    expect(option.isSome(), isTrue);
    expect(option | '', expectedValue);
  });
  test('singleEither_noElementFound_eitherIsLeft', () {
    final iterable = [];
    final either = iterable.singleEither;

    expect(either.isLeft(), isTrue);
  });
  test('singleEither_elementFound_eitherIsRight', () {
    final iterable = ['A'];
    final expectedValue = iterable.single;
    final either = iterable.singleEither;

    expect(either.isRight(), isTrue);
    expect(either | '', expectedValue);
  });
  test('singleOption_noElementFound_optionIsNone', () {
    final iterable = [];
    final option = iterable.singleOption;

    expect(option.isNone(), isTrue);
  });
  test('singleOption_elementFound_optionIsSome', () {
    final iterable = ['A'];
    final expectedValue = iterable.single;
    final option = iterable.singleOption;

    expect(option.isSome(), isTrue);
    expect(option | '', expectedValue);
  });
  test('firstWhereEither_noElementFound_eitherIsLeft', () {
    final iterable = [];
    final expectedValue = 'C';
    final either = iterable.firstWhereEither((e) => e == expectedValue);

    expect(either.isLeft(), isTrue);
  });
  test('firstWhereEither_elementFound_eitherIsRight', () {
    final iterable = ['A', 'B'];
    final expectedValue = iterable.first;
    final either = iterable.firstWhereEither((e) => e == expectedValue);

    expect(either.isRight(), isTrue);
    expect(either | '', expectedValue);
  });
  test('firstWhereOption_noElementFound_optionIsNone', () {
    final iterable = [];
    final expectedValue = 'C';
    final option = iterable.firstWhereOption((e) => e == expectedValue);

    expect(option.isNone(), isTrue);
  });
  test('firstWhereOption_elementFound_optionIsSome', () {
    final iterable = ['A', 'B'];
    final expectedValue = iterable.first;
    final option = iterable.firstWhereOption((e) => e == expectedValue);

    expect(option.isSome(), isTrue);
    expect(option | '', expectedValue);
  });
  test('lastWhereEither_noElementFound_eitherIsLeft', () {
    final iterable = [];
    final expectedValue = 'C';
    final either = iterable.lastWhereEither((e) => e == expectedValue);

    expect(either.isLeft(), isTrue);
  });
  test('lastWhereEither_elementFound_eitherIsRight', () {
    final iterable = ['A', 'B'];
    final expectedValue = iterable.last;
    final either = iterable.lastWhereEither((e) => e == expectedValue);

    expect(either.isRight(), isTrue);
    expect(either | '', expectedValue);
  });
  test('lastWhereOption_noElementFound_optionIsNone', () {
    final iterable = [];
    final expectedValue = 'C';
    final option = iterable.lastWhereOption((e) => e == expectedValue);

    expect(option.isNone(), isTrue);
  });
  test('lastWhereOption_elementFound_optionIsSome', () {
    final iterable = ['A', 'B'];
    final expectedValue = iterable.last;
    final option = iterable.lastWhereOption((e) => e == expectedValue);

    expect(option.isSome(), isTrue);
    expect(option | '', expectedValue);
  });
  test('singleWhereEither_noElementFound_eitherIsLeft', () {
    final iterable = [];
    final expectedValue = 'C';
    final either = iterable.singleWhereEither((e) => e == expectedValue);

    expect(either.isLeft(), isTrue);
  });
  test('singleWhereEither_elementFound_eitherIsRight', () {
    final iterable = ['A', 'B'];
    final expectedValue = iterable.first;
    final either = iterable.singleWhereEither((e) => e == expectedValue);

    expect(either.isRight(), isTrue);
    expect(either | '', expectedValue);
  });
  test('singleWhereOption_noElementFound_optionIsNone', () {
    final iterable = [];
    final expectedValue = 'C';
    final option = iterable.singleWhereOption((e) => e == expectedValue);

    expect(option.isNone(), isTrue);
  });
  test('singleWhereOption_elementFound_optionIsSome', () {
    final iterable = ['A', 'B'];
    final expectedValue = iterable.first;
    final option = iterable.singleWhereOption((e) => e == expectedValue);

    expect(option.isSome(), isTrue);
    expect(option | '', expectedValue);
  });
  test('elementAtEither_emptyIterable_eitherIsLeft', () {
    final iterable = [];
    final either = iterable.elementAtEither(0);

    expect(either.isLeft(), isTrue);
  });
  test('elementAtEither_validIterable_eitherIsRight', () {
    final iterable = ['A', 'B'];
    final expectedValue = iterable[1];
    final either = iterable.elementAtEither(1);

    expect(either.isRight(), isTrue);
    expect(either | '', expectedValue);
  });
  test('elementAtOption_emptyIterable_optionIsNone', () {
    final iterable = [];
    final option = iterable.elementAtOption(0);

    expect(option.isNone(), isTrue);
  });
  test('elementAtOption_validIterable_optionIsSome', () {
    final iterable = ['A', 'B'];
    final expectedValue = iterable[1];
    final option = iterable.elementAtOption(1);

    expect(option.isSome(), isTrue);
    expect(option | '', expectedValue);
  });
}
