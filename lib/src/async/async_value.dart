part of z.dart.async;

sealed class AsyncValue<T> {
  const AsyncValue();

  const factory AsyncValue.loading() = AsyncLoading<T>;

  const factory AsyncValue.data(T t) = AsyncData<T>;

  const factory AsyncValue.error(Object error, StackTrace stackTrace) =
      AsyncError<T>;

  bool get isLoading {
    return switch (this) {
      AsyncLoading _ => true,
      AsyncData _ => false,
      AsyncError _ => false,
    };
  }

  bool get isData {
    return switch (this) {
      AsyncLoading _ => false,
      AsyncData _ => true,
      AsyncError _ => false,
    };
  }

  bool get isError {
    return switch (this) {
      AsyncLoading _ => false,
      AsyncData _ => false,
      AsyncError _ => true,
    };
  }

  bool isErrorOfType<E extends Exception>() {
    return switch (this) {
      AsyncLoading _ => false,
      AsyncData _ => false,
      AsyncError e => e.error is E,
    };
  }

  T? getOrNull() {
    return switch (this) {
      AsyncLoading _ => null,
      AsyncData d => d.data,
      AsyncError _ => null,
    };
  }

  T getOrElse(T Function() dflt) {
    return switch (this) {
      AsyncLoading _ => dflt(),
      AsyncData d => d.data,
      AsyncError _ => dflt(),
    };
  }

  T operator |(T dflt) => getOrElse(() => dflt);

  AsyncValue<R> map<R>(R Function(T t) mapper) {
    return switch (this) {
      AsyncLoading _ => AsyncValue.loading(),
      AsyncData d => AsyncValue.data(mapper(d.data)),
      AsyncError e => AsyncValue.error(e.error, e.stackTrace),
    };
  }

  void when({
    void Function()? isLoading,
    void Function(T data)? isData,
    void Function(Object error, StackTrace stackTrace)? isError,
  }) {
    return switch (this) {
      AsyncLoading _ => (isLoading ?? () {}).call(),
      AsyncData d => (isData ?? (d) {}).call(d.data),
      AsyncError e => (isError ?? (e, st) {}).call(e.error, e.stackTrace),
    };
  }

  @override
  String toString() {
    return switch (this) {
      AsyncLoading _ => 'Loading',
      AsyncData d => 'Data(${d.data})',
      AsyncError e => 'Error(${e.error}, ${e.stackTrace})',
    };
  }
}

class AsyncLoading<T> extends AsyncValue<T> {
  const AsyncLoading();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AsyncLoading && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class AsyncData<T> extends AsyncValue<T> {
  const AsyncData(this.data);

  final T data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AsyncData &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
}

class AsyncError<T> extends AsyncValue<T> {
  const AsyncError(this.error, this.stackTrace);

  final Object error;
  final StackTrace stackTrace;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AsyncError &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          stackTrace == other.stackTrace;

  @override
  int get hashCode => Object.hash(error, stackTrace);
}
