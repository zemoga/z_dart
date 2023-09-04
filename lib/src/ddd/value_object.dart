part of z.dart.ddd;

@Deprecated('This will be removed in a future version')
base class ValueObject {}

///
base class SingleValueObject<T extends Object> {
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
