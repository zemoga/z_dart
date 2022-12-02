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
extension ListCacheExt<E> on Cache<List<E>> {
  @Deprecated('Use a map-based Cache instead.')
  Stream<List<E>> valuesWhere(bool Function(E value) test) {
    return stream.map((event) => event.where(test).toList());
  }

  @Deprecated('Use a map-based Cache instead.')
  Stream<E> find(
    bool Function(E value) test, {
    required E Function() orElse,
  }) {
    return stream.map((event) => event.firstWhere(test, orElse: orElse));
  }

  @Deprecated('Use a map-based Cache instead.')
  void update(void Function(List<E> data) block) {
    data = data.toList().also(block);
  }

  @Deprecated('Use a map-based Cache instead.')
  void add(E value) {
    update((data) => data.add(value));
  }

  @Deprecated('Use a map-based Cache instead.')
  void addAll(List<E> values) {
    update((data) => data.addAll(values));
  }

  @Deprecated('Use a map-based Cache instead.')
  void replaceAll(List<E> values) {
    data = List.of(values);
  }

  @Deprecated('Use a map-based Cache instead.')
  void removeWhere(bool Function(E value) test) {
    update((data) => data.removeWhere(test));
  }

  @Deprecated('Use a map-based Cache instead.')
  void clear() {
    data = [];
  }
}

///
extension MapCacheExt<K, V> on Cache<Map<K, V>> {
  Stream<V?> get(K key) => stream.map((event) => event[key]);

  Stream<List<V>> getAll() => stream.map((event) => event.values.toList());

  Stream<List<V>> where(bool Function(MapEntry<K, V> entry) test) {
    return stream.map((event) => event.where(test).values.toList());
  }

  @Deprecated('Use getAll() instead.')
  Stream<List<V>> get values => stream.map((event) => event.values.toList());

  @Deprecated('Use where() instead.')
  Stream<List<V>> valuesWhere(bool Function(V value) test) {
    return values.map((event) => event.where(test).toList());
  }

  @Deprecated('Use get(K key) instead.')
  Stream<V?> valueOrNull(K key) {
    return stream.map((event) => event[key]);
  }

  @Deprecated('Use get(K key) instead.')
  Stream<V> valueOrElse(K key, {required V Function() orElse}) {
    return valueOrNull(key).map((event) => event ?? orElse());
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

  @Deprecated('Use put instead.')
  void add(K key, V value) {
    put(key, value);
  }

  void addAll(Map<K, V> other) {
    update((data) => data.addAll(other));
  }

  @Deprecated('Set the data directly instead.')
  void replaceAll(Map<K, V> other) {
    data = Map.of(other);
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

///
extension IdentifiableCollectionCacheExt<T extends Identifiable>
    on Cache<Map<String, T>> {
  @Deprecated('Use data directly. This will be removed in a future version')
  bool containsObject(T object) {
    return contains(object.id.toString());
  }

  @Deprecated('Use mutateMap instead. This will be removed in a future version')
  void addObject(T other) {
    return add(other.id.toString(), other);
  }

  @Deprecated('Use mutateMap instead. This will be removed in a future version')
  void addAllObjects(Iterable<T> others) {
    return addAll(others.associateBy((e) => e.id.toString()));
  }

  @Deprecated('Use mutateMap instead. This will be removed in a future version')
  void replaceAllObjects(Iterable<T> others) {
    return replaceAll(others.associateBy((e) => e.id.toString()));
  }

  @Deprecated('Use mutateMap instead. This will be removed in a future version')
  void removeObject(T other) {
    return remove(other.id.toString());
  }
}
