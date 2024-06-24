part of '../../core.dart';

sealed class AsyncResult<T> {}

class AsyncResultLoading<T> implements AsyncResult<T> {
  const AsyncResultLoading();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AsyncResultLoading && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class AsyncResultSuccess<T> implements AsyncResult<T> {
  const AsyncResultSuccess(this.value);

  final T value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AsyncResultSuccess &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

class AsyncResultFailure<T> implements AsyncResult<T> {
  const AsyncResultFailure(this.error, this.stackTrace);

  final Object error;
  final StackTrace stackTrace;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AsyncResultFailure &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          stackTrace == other.stackTrace;

  @override
  int get hashCode => Object.hash(error, stackTrace);
}

extension AsyncResultExt<T> on AsyncResult<T> {
  AsyncResult<R> map<R>(R Function(T value) transform) {
    return switch (this) {
      AsyncResultLoading() => AsyncResultLoading<R>(),
      AsyncResultSuccess(value: final v) => AsyncResultSuccess(transform(v)),
      AsyncResultFailure(error: final e, stackTrace: final s) =>
        AsyncResultFailure(e, s),
    };
  }

  AsyncResult<R> flatMap<R>(AsyncResult<R> Function(T value) transform) {
    return switch (this) {
      AsyncResultLoading() => AsyncResultLoading<R>(),
      AsyncResultSuccess(value: final v) => transform(v),
      AsyncResultFailure(error: final e, stackTrace: final s) =>
        AsyncResultFailure(e, s),
    };
  }

  bool get isLoading {
    return switch (this) { AsyncResultLoading() => true, _ => false };
  }

  bool get isSuccess {
    return switch (this) { AsyncResultSuccess() => true, _ => false };
  }

  bool get isFailure {
    return switch (this) { AsyncResultFailure() => true, _ => false };
  }

  bool isFailureOfType<E extends Exception>() {
    return switch (this) {
      AsyncResultLoading() => false,
      AsyncResultSuccess() => false,
      AsyncResultFailure(error: final e) => e is E,
    };
  }

  T? getOrNull() {
    return switch (this) { AsyncResultSuccess(value: final v) => v, _ => null };
  }

  T getOrDefault(T defaultValue) => getOrNull() ?? defaultValue;
}
