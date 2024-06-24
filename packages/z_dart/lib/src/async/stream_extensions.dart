part of '../../async.dart';

extension MapListExtensions<E> on Stream<List<E>> {
  Stream<List<E>> mapWhere(bool Function(E element) test) {
    return map((event) => event.where(test).toList());
  }
}

extension AsyncResultStream<T> on Stream<T> {
  Stream<AsyncResult<T>> asAsyncResultStream() async* {
    yield const AsyncResultLoading();
    yield* transform(
      StreamTransformer.fromHandlers(
        handleData: (data, sink) => sink.add(
          AsyncResultSuccess(data),
        ),
        handleError: (error, stackTrace, sink) => sink.add(
          AsyncResultFailure(error, stackTrace),
        ),
      ),
    );
  }
}
