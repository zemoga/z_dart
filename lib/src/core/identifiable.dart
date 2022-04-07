part of z.dart.core;

/// Interface used by types that have an unique identifier.
abstract class Identifiable<T> {
  T get id;
}

extension IdentifiableIterableExt<E extends Identifiable> on Iterable<E> {
  /// Creates a [Map] containing the elements of this [Iterable] of
  ///  [Identifiable] objects.
  ///
  /// The map uses the [String] representation of the IDs
  /// of this iterable as keys, and the corresponding elements as values.
  Map<String, E> toMap() {
    return associateBy((element) => element.id.toString());
  }
}
