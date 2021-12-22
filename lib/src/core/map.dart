extension MapExtension<K, V> on Map<K, V> {
  Iterable<MapEntry<K, V>> where(
    bool Function(MapEntry<K, V> entry) test,
  ) {
    return entries.where(test);
  }

  MapEntry<K, V> firstWhere(
    bool Function(MapEntry<K, V> entry) test, {
    MapEntry<K, V> Function()? orElse,
  }) {
    return entries.firstWhere(
      test,
      orElse: orElse,
    );
  }

  V firstValueWhere(
    bool Function(K key) test, {
    V Function()? orElse,
  }) {
    try {
      return firstWhere((entry) => test(entry.key)).value;
    } catch (e) {
      if (orElse != null) return orElse();
      rethrow;
    }
  }
}
