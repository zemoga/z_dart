part of '../../async.dart';

extension FutureDoExtensions<T> on Future<T> {
  Future<T> doOnValue(
    void Function(T value) onValue,
  ) {
    return then((value) {
      onValue(value);
      return this;
    });
  }

  Future<T> doOnError(
    void Function(Object error, StackTrace stackTrace) onError,
  ) {
    return catchError((error, stackTrace) {
      onError(error, stackTrace);
      return this;
    });
  }
}
