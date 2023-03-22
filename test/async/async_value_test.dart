import 'package:test/test.dart';
import 'package:z_dart/async.dart';

void main() {
  group('map:', () {
    test('isLoading => keepsLoading', () async {
      final input = AsyncValue<String>.loading();
      final output = input.map((t) => t.hashCode);

      expect(output.isLoading, isTrue);
    });
    test('isData => transformsData', () async {
      final input = AsyncValueData('A');
      final output = input.map((t) => t.hashCode);

      expect(output.isData, isTrue);
      expect(output.getOrNull(), isNotNull);
      expect(output.getOrNull(), input.data.hashCode);
    });
    test('isError => keepsError', () async {
      final input = AsyncValueError(FormatException(), StackTrace.current);
      final output = input.map((t) => t.hashCode);

      expect(output.isError, isTrue);
      expect(output.isErrorOfType<FormatException>(), isTrue);
    });
  });

  group('when:', () {
    test('isLoading => invokesLoadingCallback', () {
      final input = AsyncValue.loading();
      final completer = Completer();
      input.when(isLoading: completer.complete);

      expect(completer.isCompleted, isTrue);
    });
    test('isData => invokesDataCallback', () {
      final input = AsyncValueData(10);
      final completer = Completer<int>();
      input.when(isData: completer.complete);

      expect(completer.isCompleted, isTrue);
      expect(completer.future, completion(input.data));
    });
    test('isError => invokesErrorCallback', () {
      final input = AsyncValueError(FormatException(), StackTrace.current);
      final completer = Completer();
      input.when(isError: completer.completeError);

      expect(completer.isCompleted, isTrue);
      expect(completer.future, throwsA(isA<FormatException>()));
    });
  });

  group('getOrNull:', () {
    test('isLoading  => returnsNull', () {
      final input = AsyncValue.loading();
      final output = input.getOrNull();

      expect(output, isNull);
    });
    test('isData  => returnsData', () {
      final input = AsyncValueData(10);
      final output = input.getOrNull();

      expect(output, isNotNull);
      expect(output, input.data);
    });
    test('isError  => returnsNull', () {
      final input = AsyncValueError(FormatException(), StackTrace.current);
      final output = input.getOrNull();

      expect(output, isNull);
    });
  });

  group('getOrElse:', () {
    test('isLoading  => returnsFallbackData', () {
      final fallbackData = 5;
      final input = AsyncValue.loading();
      final output = input | fallbackData;

      expect(output, isNotNull);
      expect(output, fallbackData);
    });
    test('isData  => returnsData', () {
      final fallbackData = 5;
      final input = AsyncValueData(10);
      final output = input | fallbackData;

      expect(output, isNotNull);
      expect(output, input.data);
    });
    test('isError  => returnsFallbackData', () {
      final fallbackData = 5;
      final input = AsyncValueError(FormatException(), StackTrace.current);
      final output = input | fallbackData;

      expect(output, isNotNull);
      expect(output, fallbackData);
    });
  });
}
