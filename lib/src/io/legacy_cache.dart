part of z.dart.io;

///
@Deprecated('This will be removed in a future version')
abstract class LegacyCache<K, V> {
  // This Subject is intended to be broadcasting while
  // the app is active so new events are propagated in a reactive way
  //
  // This analyzer warning is safe to ignore.
  // ignore: close_sinks
  final _valuesSubject = BehaviorSubject<List<V>>();

  LegacyCache() {
    invalidate();
  }

  Stream<List<V>> get snapshots => _valuesSubject.stream;

  Future<void> invalidate() =>
      getAll().then((values) => _valuesSubject.sink.add(values));

  Future<bool> contains(K key);

  Future<V?> getOrNull(K key);

  Future<V> getOrElse(K key, {required FutureOr<V> Function() orElse}) =>
      getOrNull(key).then((value) => value ?? orElse());

  Future<List<V>> getAll();

  Future<void> put(K key, V value) =>
      onPut({key: value}).then((_) => invalidate());

  Future<void> putAll(Map<K, V> map) => onPut(map).then((_) => invalidate());

  Future<void> replaceAll(Map<K, V> map) =>
      onClear().then((_) => onPut(map)).then((_) => invalidate());

  Future<void> remove(K key) => onRemove(key).then((_) => invalidate());

  Future<void> clear() => onClear().then((_) => invalidate());

  Future<void> onPut(Map<K, V> map);

  Future<void> onRemove(K key);

  Future<void> onClear();
}

///
@Deprecated('Use CollectionCache instead')
class MemoryCache<K, V> extends LegacyCache<K, V> {
  final _memory = <K, V>{};

  @override
  Future<List<V>> getAll() => Future.value(_memory.values.toList());

  @override
  Future<V?> getOrNull(K key) => Future.microtask(() => _memory[key]);

  @override
  Future<bool> contains(K key) =>
      Future.microtask(() => _memory.containsKey(key));

  @override
  Future<void> onPut(Map<K, V> map) =>
      Future.microtask(() => _memory.addAll(map));

  @override
  Future<void> onRemove(K key) => Future.microtask(() => _memory.remove(key));

  @override
  Future<void> onClear() => Future.microtask(() => _memory.clear());
}
