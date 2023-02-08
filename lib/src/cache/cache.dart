part of z.dart.cache;

///
class Cache<T> {
  Cache(T initialData) : _subject = BehaviorSubject<T>.seeded(initialData);

  final BehaviorSubject<T> _subject;

  /// The current stream of [data] elements.
  Stream<T> get stream => _subject.stream;

  /// The current [data].
  T get data => _subject.value;

  /// Updates the [data] to a new value.
  set data(T data) => _subject.add(data);

  /// Closes the instance.
  /// This method should be called when the instance is no longer needed.
  /// Once [close] is called, the instance can no longer be used.
  void close() => _subject.close();
}

///
extension MapCacheExt<K, V> on Cache<Map<K, V>> {
  Stream<V?> get(K key) => stream.map((event) => event[key]);

  Stream<List<V>> getAll() => stream.map((event) => event.values.toList());

  Stream<List<V>> where(bool Function(MapEntry<K, V> entry) test) {
    return stream.map((event) => event.where(test).values.toList());
  }

  bool contains(K key) {
    return data.containsKey(key);
  }

  void update(void Function(Map<K, V> data) block) {
    data = Map.of(data).also(block);
  }

  void put(K key, V value) {
    update((data) => data[key] = value);
  }

  void addAll(Map<K, V> other) {
    update((data) => data.addAll(other));
  }

  void remove(K key) {
    update((data) => data.remove(key));
  }

  void removeWhere(bool Function(K key, V value) test) {
    update((data) => data.removeWhere(test));
  }

  void clear() {
    data = {};
  }
}
