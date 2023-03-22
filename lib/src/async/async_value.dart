part of z.dart.async;

abstract class AsyncValue<T> {
  const AsyncValue();

  const factory AsyncValue.loading() = AsyncValueLoading<T>;

  const factory AsyncValue.data(T t) = AsyncValueData<T>;

  const factory AsyncValue.error(Object error, StackTrace stackTrace) =
      AsyncValueError<T>;

  R fold<R>(
    R Function() ifLoading,
    R Function(T data) ifData,
    R Function(Object error, StackTrace stackTrace) ifError,
  );

  bool get isLoading => fold(() => true, (_) => false, (e, st) => false);

  bool get isData => fold(() => false, (_) => true, (e, st) => false);

  bool get isError => fold(() => false, (_) => false, (e, st) => true);

  bool isErrorOfType<E extends Exception>() =>
      fold(() => false, (_) => false, (error, _) => error is E);

  T? getOrNull() {
    return fold(() => null, (data) => data, (e, st) => null);
  }

  T getOrElse(T Function() dflt) {
    return fold(dflt, (data) => data, (e, st) => dflt());
  }

  T operator |(T dflt) => getOrElse(() => dflt);

  AsyncValue<R> map<R>(R Function(T t) mapper) {
    return fold(
      AsyncValue.loading,
      (t) => AsyncValue.data(mapper(t)),
      AsyncValue.error,
    );
  }

  void when({
    void Function()? isLoading,
    void Function(T data)? isData,
    void Function(Object error, StackTrace stackTrace)? isError,
  }) {
    fold(isLoading ?? () {}, isData ?? (d) {}, isError ?? (e, st) {});
  }

  @override
  String toString() => fold(
        () => 'Loading',
        (t) => 'Data($t)',
        (e, st) => 'Error($e, $st)',
      );
}

class AsyncValueLoading<T> extends AsyncValue<T> {
  const AsyncValueLoading();

  @override
  R fold<R>(
    R Function() ifLoading,
    R Function(T data) ifData,
    R Function(Object error, StackTrace stackTrace) ifError,
  ) {
    return ifLoading();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AsyncValueLoading && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class AsyncValueData<T> extends AsyncValue<T> {
  const AsyncValueData(this.data);

  final T data;

  @override
  R fold<R>(
    R Function() ifLoading,
    R Function(T data) ifData,
    R Function(Object error, StackTrace stackTrace) ifError,
  ) {
    return ifData(data);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AsyncValueData &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
}

class AsyncValueError<T> extends AsyncValue<T> {
  const AsyncValueError(this.error, this.stackTrace);

  final Object error;
  final StackTrace stackTrace;

  @override
  R fold<R>(
    R Function() ifLoading,
    R Function(T data) ifData,
    R Function(Object error, StackTrace stackTrace) ifError,
  ) {
    return ifError(error, stackTrace);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AsyncValueError &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          stackTrace == other.stackTrace;

  @override
  int get hashCode => Object.hash(error, stackTrace);
}
