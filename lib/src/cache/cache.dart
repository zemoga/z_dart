part of z.dart.cache;

///
class Cache<T> {
  Cache(T initialData) {
    data = initialData;
  }

  final _subject = BehaviorSubject<T>();

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
class CollectionCache<T> extends Cache<Map<String, T>> {
  CollectionCache({
    Map<String, T> initialData = const {},
  }) : super(Map.of(initialData));

  static CollectionCache<Ti> identifiable<Ti extends Identifiable>({
    Iterable<Ti> identifiableList = const [],
  }) {
    return CollectionCache()..addAllObjects(identifiableList);
  }
}

///
extension CollectionCacheExt<T> on Cache<Map<String, T>> {
  void emit(Map<String, T> data) => this.data = data;

  Stream<List<T>> get values => stream.map((event) => event.values.toList());

  Stream<List<T>> valuesWhere(
    bool Function(T value) test,
  ) {
    return values.map((event) => event.where(test).toList());
  }

  Stream<T?> valueOrNull(String key) {
    return stream.map((event) => event[key]);
  }

  Stream<T> valueOrElse(
    String key, {
    required T Function() orElse,
  }) {
    return valueOrNull(key).map((event) => event ?? orElse());
  }

  bool contains(String key) {
    return data.containsKey(key);
  }

  void add(String key, T value) {
    data = data..[key] = value;
  }

  void addAll(Map<String, T> other) {
    data = data..addAll(other);
  }

  void replaceAll(Map<String, T> other) {
    data = data
      ..clear()
      ..addAll(other);
  }

  void remove(String key) {
    data = data..remove(key);
  }

  void clear() {
    data = data..clear();
  }
}

///
extension IdentifiableCollectionCacheExt<T extends Identifiable>
    on Cache<Map<String, T>> {
  bool containsObject(T object) {
    return contains(object.id.toString());
  }

  void addObject(T other) {
    return add(other.id.toString(), other);
  }

  void addAllObjects(Iterable<T> others) {
    return addAll(others.associateBy((e) => e.id.toString()));
  }

  void replaceAllObjects(Iterable<T> others) {
    return replaceAll(others.associateBy((e) => e.id.toString()));
  }

  void removeObject(T other) {
    return remove(other.id.toString());
  }
}
