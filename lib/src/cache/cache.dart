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

  Future<bool> contains(String key) {
    return Future(() => data.containsKey(key));
  }

  Future<void> add(String key, T value) {
    return Future(() => data..[key] = value).then(emit);
  }

  Future<void> addAll(Map<String, T> other) {
    return Future(() => data..addAll(other)).then(emit);
  }

  Future<void> replaceAll(Map<String, T> other) {
    return Future(
      () => data
        ..clear()
        ..addAll(other),
    ).then(emit);
  }

  Future<void> remove(String key) {
    return Future(() => data..remove(key)).then(emit);
  }

  Future<void> clear() {
    return Future(() => data..clear()).then(emit);
  }
}

///
extension IdentifiableCollectionCacheExt<T extends Identifiable>
    on Cache<Map<String, T>> {
  Future<bool> containsObject(T object) {
    return contains(object.id.toString());
  }

  Future<void> addObject(T other) {
    return add(other.id.toString(), other);
  }

  Future<void> addAllObjects(Iterable<T> others) {
    return addAll(others.associateBy((e) => e.id.toString()));
  }

  Future<void> replaceAllObjects(Iterable<T> others) {
    return replaceAll(others.associateBy((e) => e.id.toString()));
  }

  Future<void> removeObject(T other) {
    return remove(other.id.toString());
  }
}
