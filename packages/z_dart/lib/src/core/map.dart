part of '../../core.dart';

extension MapExtension<K, V> on Map<K, V> {
  Map<K, V> where(
    bool Function(MapEntry<K, V> entry) test,
  ) {
    return Map.fromEntries(entries.where(test));
  }
}
