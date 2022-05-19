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
@Deprecated('Use Cache instead. This will be removed in a future version')
class CollectionCache<T> extends Cache<Map<String, T>> {
  CollectionCache({
    Map<String, T> initialData = const {},
  }) : super(initialData);

  static CollectionCache<Ti> identifiable<Ti extends Identifiable>({
    Iterable<Ti> identifiableList = const [],
  }) {
    return CollectionCache()..addAllObjects(identifiableList);
  }
}

///
extension ListCacheExt<T> on Cache<List<T>> {
  void mutateList(void Function(List<T> data) block) {
    data = data.toList().also(block);
  }
}

///
extension MapCacheExt<K, V> on Cache<Map<K, V>> {
  Stream<List<V>> get values => stream.map((event) => event.values.toList());

  Stream<List<V>> valuesWhere(
    bool Function(V value) test,
  ) {
    return values.map((event) => event.where(test).toList());
  }

  Stream<V?> valueOrNull(String key) {
    return stream.map((event) => event[key]);
  }

  Stream<V> valueOrElse(
    String key, {
    required V Function() orElse,
  }) {
    return valueOrNull(key).map((event) => event ?? orElse());
  }

  void mutateMap(void Function(Map<K, V> data) block) {
    data = Map.of(data).also(block);
  }
}

///
extension CollectionCacheExt<T> on Cache<Map<String, T>> {
  @Deprecated('Use data directly. This will be removed in a future version')
  bool contains(String key) {
    return data.containsKey(key);
  }

  @Deprecated('Use mutateMap instead. This will be removed in a future version')
  void add(String key, T value) {
    mutateMap((data) => data[key] = value);
  }

  @Deprecated('Use mutateMap instead. This will be removed in a future version')
  void addAll(Map<String, T> other) {
    mutateMap((data) => data.addAll(other));
  }

  @Deprecated('Use mutateMap instead. This will be removed in a future version')
  void replaceAll(Map<String, T> other) {
    data = Map.of(other);
  }

  @Deprecated('Use mutateMap instead. This will be removed in a future version')
  void remove(String key) {
    mutateMap((data) => data.remove(key));
  }

  @Deprecated('Use mutateMap instead. This will be removed in a future version')
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
