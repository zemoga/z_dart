part of z.dart.async;

sealed class AsyncValue<T> {
  const AsyncValue();

  const factory AsyncValue.loading() = AsyncValueLoading<T>;

  const factory AsyncValue.data(T t) = AsyncValueData<T>;

  const factory AsyncValue.error(Object error, StackTrace stackTrace) =
      AsyncValueError<T>;

  bool get isLoading {
    return switch (this) {
      AsyncValueLoading _ => true,
      AsyncValueData _ => false,
      AsyncValueError _ => false,
    };
  }

  bool get isData {
    return switch (this) {
      AsyncValueLoading _ => false,
      AsyncValueData _ => true,
      AsyncValueError _ => false,
    };
  }

  bool get isError {
    return switch (this) {
      AsyncValueLoading _ => false,
      AsyncValueData _ => false,
      AsyncValueError _ => true,
    };
  }

  bool isErrorOfType<E extends Exception>() {
    return switch (this) {
      AsyncValueLoading _ => false,
      AsyncValueData _ => false,
      AsyncValueError e => e.error is E,
    };
  }

  T? getOrNull() {
    return switch (this) {
      AsyncValueLoading _ => null,
      AsyncValueData d => d.data,
      AsyncValueError _ => null,
    };
  }

  T getOrElse(T Function() dflt) {
    return switch (this) {
      AsyncValueLoading _ => dflt(),
      AsyncValueData d => d.data,
      AsyncValueError _ => dflt(),
    };
  }

  T operator |(T dflt) => getOrElse(() => dflt);

  AsyncValue<R> map<R>(R Function(T t) mapper) {
    return switch (this) {
      AsyncValueLoading _ => AsyncValue.loading(),
      AsyncValueData d => AsyncValue.data(mapper(d.data)),
      AsyncValueError e => AsyncValue.error(e.error, e.stackTrace),
    };
  }

  void when({
    void Function()? isLoading,
    void Function(T data)? isData,
    void Function(Object error, StackTrace stackTrace)? isError,
  }) {
    return switch (this) {
      AsyncValueLoading _ => (isLoading ?? () {}).call(),
      AsyncValueData d => (isData ?? (d) {}).call(d.data),
      AsyncValueError e => (isError ?? (e, st) {}).call(e.error, e.stackTrace),
    };
  }

  @override
  String toString() {
    return switch (this) {
      AsyncValueLoading _ => 'Loading',
      AsyncValueData d => 'Data(${d.data})',
      AsyncValueError e => 'Error(${e.error}, ${e.stackTrace})',
    };
  }
}

class AsyncValueLoading<T> extends AsyncValue<T> {
  const AsyncValueLoading();

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
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AsyncValueError &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          stackTrace == other.stackTrace;

  @override
  int get hashCode => Object.hash(error, stackTrace);
}
