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
