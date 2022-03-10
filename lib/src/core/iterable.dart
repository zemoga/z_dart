part of z.dart.core;

extension IterableExt<E> on Iterable<E> {
  bool containsEvery(Iterable<E>? other) {
    if (other == null) return false;

    return other.every((element) => contains(element));
  }

  bool containsAny(Iterable<E>? other) {
    if (other == null) return false;

    return other.any((element) => contains(element));
  }
}
