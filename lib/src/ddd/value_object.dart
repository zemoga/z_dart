part of z.dart.ddd;

///
abstract class ValueObject {}

///
abstract class SingleValueObject<T extends Object> implements ValueObject {
  const SingleValueObject(this.value);

  final T value;

  @override
  String toString() {
    return 'SingleValueObject{value: $value}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SingleValueObject &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

///
abstract class EntityId extends SingleValueObject<String>
    implements Comparable<EntityId> {
  const EntityId(String value) : super(value);

  bool get isValid => value.isNotEmpty;

  /// Check this ID is of numeric type, meaning, only
  /// digits compose the ID.
  ///
  /// Only positive integer values are condisered a
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
@Deprecated('Use EntityId instead. This will be removed in a future version')
abstract class NumericId extends SingleValueObject<int>
    implements Comparable<NumericId> {
  const NumericId(int value) : super(value);

  @override
  String toString() => value.toString();

  @override
  int compareTo(NumericId other) => value.compareTo(other.value);
}

///
@Deprecated('Use EntityId instead. This will be removed in a future version')
typedef AlphanumericId = EntityId;
