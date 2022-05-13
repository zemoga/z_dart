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
extension CollectionCacheExt<T> on Cache<Map<String, T>> {
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
class CollectionCache<T> extends Cache<Map<String, T>> {
  CollectionCache({
    Map<String, T> initialData = const {},
  }) : super(Map.of(initialData));

  @Deprecated("Use default constructor instead")
  CollectionCache.from(Map<String, T> data) : this(initialData: data);

  static CollectionCache<Ti> identifiable<Ti extends Identifiable>({
    Iterable<Ti> identifiableList = const [],
  }) {
    return CollectionCache(
      initialData: identifiableList.associateBy((e) => e.id.toString()),
    );
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
@Deprecated("Use 'CollectionCache.identifiable' instead")
class IdentifiableCollectionCache<T extends Identifiable>
    extends CollectionCache<T> {
  IdentifiableCollectionCache({
    Map<String, T> initialData = const {},
  }) : super(initialData: initialData);

  IdentifiableCollectionCache.from(
    Iterable<T> identifiableList,
  ) : super(initialData: identifiableList.associateBy((e) => e.id.toString()));
}
