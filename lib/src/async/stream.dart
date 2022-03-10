part of z.dart.async;

extension MapListExtensions<E> on Stream<List<E>> {
  Stream<List<E>> mapWhere(bool Function(E element) test) =>
      map((event) => event.where(test).toList());
}
