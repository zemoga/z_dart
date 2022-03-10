part of z.dart.ddd;

abstract class Entity<T extends ValueObject> implements Identifiable<T> {
  const Entity(this.id);

  @override
  final T id;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Entity && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
