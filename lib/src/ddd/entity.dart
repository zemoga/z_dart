part of z.dart.ddd;

@Deprecated('Use custom type instead. This will be removed in a future version')
base class EntityId extends SingleValueObject<String>
    implements Comparable<EntityId> {
  const EntityId(String value) : super(value);

  bool get isValid => value.isNotEmpty;

  /// Check this ID is of numeric type, meaning, only
  /// digits compose the ID.
  ///
  /// Only positive integer values are considered a
  /// valid numeric ID.
  bool get isNumeric => !(int.tryParse(value) ?? -1).isNegative;

  /// Gets the numeric representation of this ID.
  ///
  /// If [value] is not of numeric type, throws a [FormatException].
  int get numericValue => isNumeric
      ? int.parse(value)
      : throw FormatException('ID is not a numeric value: $value');

  @override
  String toString() => value;

  @override
  int compareTo(EntityId other) => value.compareTo(other.value);
}

///
base class Entity<T> implements Identifiable<T> {
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
