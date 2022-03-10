import 'package:z_dart/core.dart';

import 'value_object.dart';

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
