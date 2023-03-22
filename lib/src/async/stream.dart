part of z.dart.async;

extension MapListExtensions<E> on Stream<List<E>> {
  Stream<List<E>> mapWhere(bool Function(E element) test) =>
      map((event) => event.where(test).toList());
}

extension StreamGuard<T> on Stream<T> {
  Stream<AsyncValue<T>> guard() {
    return map(AsyncValue.data).onErrorReturnWith(AsyncValue<T>.error);
  }
}
