part of z.dart.io;

///
class CachePolicy {
  final Duration expireAfter;
  late DateTime _validationTime;

  CachePolicy({this.expireAfter = const Duration(minutes: 5)}) {
    invalidate();
  }

  bool get isExpired =>
      DateTime.now().difference(_validationTime) > expireAfter;

  void validate() => _validationTime = DateTime.now();

  void invalidate() => _validationTime = DateTime.fromMillisecondsSinceEpoch(0);
}

///
class Cache<T> {
  Cache(T initialData) {
    emit(initialData);
  }

  // This Subject is intended to be broadcasting while
  // the app is active so new events are propagated in a reactive way
  //
  // This analyzer warning is safe to ignore.
  // ignore: close_sinks
  final Subject<T> _subject = BehaviorSubject<T>();

  late T _data;

  /// The current [data].
  T get data => _data;

  /// The current stream of [data] elements.
  Stream<T> get stream => _subject.stream;

  /// Updates the [data] to the provided [data].
  void emit(T data) {
    _data = data;
    _subject.add(data);
  }
}

///
mixin CollectionCacheMixin<T> on Cache<Map<String, T>> {
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
class CollectionCache<T> extends Cache<Map<String, T>>
    with CollectionCacheMixin<T> {
  CollectionCache() : super({});

  CollectionCache.from(Map<String, T> data) : super(data);

  @override
  void emit(Map<String, T> data) {
    // Ensure cache is provided with a mutable data map.
    final _data = Map.of(data);
    super.emit(_data);
  }
}

///
mixin IdentifiableCollectionCacheMixin<T extends Identifiable>
    implements CollectionCacheMixin<T> {
  Future<bool> containsObject(T object) {
    return contains(object.id.toString());
  }

  Future<void> addObject(T other) {
    return add(other.id.toString(), other);
  }

  Future<void> addAllObjects(List<T> others) {
    return addAll(others.associateBy((e) => e.id.toString()));
  }

  Future<void> replaceAllObjects(List<T> others) {
    return replaceAll(others.associateBy((e) => e.id.toString()));
  }

  Future<void> removeObject(T other) {
    return remove(other.id.toString());
  }
}

///
class IdentifiableCollectionCache<T extends Identifiable>
    extends CollectionCache<T> with IdentifiableCollectionCacheMixin<T> {
  IdentifiableCollectionCache() : super();

  IdentifiableCollectionCache.from(Iterable<T> identifiableList)
      : super.from(identifiableList.associateBy((e) => e.id.toString()));
}
