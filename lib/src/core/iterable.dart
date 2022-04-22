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

  /// Returns a [Map] containing the elements from the given collection
  /// indexed by the key returned from [keySelector] function applied
  /// to each element.
  ///
  /// If any two elements would have the same key returned by [keySelector]
  /// the last one gets added to the map.
  ///
  /// The returned map preserves the entry iteration order of the original
  /// collection.
  Map<K, E> associateBy<K>(K Function(E e) keySelector) {
    return {for (var element in this) keySelector(element): element};
  }
}
