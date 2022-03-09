import 'value_object.dart';

abstract class Entity<T extends ValueObject> {
  const Entity(this.id);

  final T id;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Entity && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

extension IterableExt<E extends Entity> on Iterable<E> {
  /// Creates a [Map] containing the elements of this [Iterable].
  ///
  /// The map uses the [String] representation of the entities IDs
  /// of this iterable as keys, and the corresponding entities as values.
  Map<String, E> toMap() {
    return {for (var entity in this) entity.id.toString(): entity};
  }
}
