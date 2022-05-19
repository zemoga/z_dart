import 'package:test/test.dart';
import 'package:z_dart/cache.dart';

typedef CollectionCache<T> = Cache<Map<String, T>>;

void main() {
  group('Cache', () {
    final initialData = 100;
    late Cache cache;
    setUp(() {
      cache = Cache(initialData);
    });
    tearDown(() {
      cache.close();
    });
    test('.emit() initial value', () {
      expect(cache.data, initialData);
    });
    test('.emit() emits a new value', () {
      final value = 50;

      cache.data = value;

      expect(cache.data, value);
    });
  });
  group('Empty CollectionCache', () {
    late CollectionCache collectionCache;
    setUp(() {
      collectionCache = CollectionCache({});
    });
    tearDown(() {
      collectionCache.close();
    });
    test('.add() adds a data entry to cache', () async {
      final key = 'key';
      final value = 45;

      collectionCache.add(key, value);

      final cacheValues = await collectionCache.values.first;
      expect(cacheValues, isNotEmpty);
      expect(cacheValues.first, equals(value));
    });
    test('.addAll() adds a data map to cache', () async {
      final other = {'keyA': 25, 'keyB': 50, 'keyC': 75, 'keyD': 100};

      collectionCache.addAll(other);

      final cacheValues = await collectionCache.values.first;
      expect(cacheValues, isNotEmpty);
      expect(cacheValues, hasLength(4));
      expect(cacheValues, equals(other.values));
    });
    test('.replaceAll() replaces all cache data with a new data map', () async {
      final oldData = {'key': 0};

      collectionCache.addAll(oldData);

      final oldCacheValues = await collectionCache.values.first;
      expect(oldCacheValues, isNotEmpty);
      expect(oldCacheValues, hasLength(1));
      expect(oldCacheValues, equals(oldData.values));

      final newData = {'keyA': 25, 'keyB': 50, 'keyC': 75, 'keyD': 100};

      collectionCache.replaceAll(newData);

      final cacheValues = await collectionCache.values.first;
      expect(cacheValues, isNotEmpty);
      expect(cacheValues, hasLength(4));
      expect(cacheValues, equals(newData.values));
    });
  });
  group('Prepopulated CollectionCache', () {
    late CollectionCache<int> collectionCache;
    setUp(() {
      final data = {'dftlKey': 100};
      collectionCache = CollectionCache(data);
    });
    tearDown(() {
      collectionCache.clear();
    });
    test('.add() adds a value to cache', () async {
      final key = 'key';
      final value = 30;

      collectionCache.add(key, value);

      final cacheValues = await collectionCache.values.first;
      expect(cacheValues, isNotEmpty);
      expect(cacheValues, hasLength(2));
      expect(cacheValues[1], equals(value));
    });
    test('.remove() removes a value from cache', () async {
      final other = {'keyA': 25, 'keyB': 50, 'keyC': 75, 'keyD': 100};

      collectionCache.addAll(other);
      collectionCache.remove('keyB');

      final cacheData = await collectionCache.stream.first;
      expect(cacheData, isNotEmpty);
      expect(cacheData, hasLength(4));
      expect(cacheData.containsKey('keyB'), isFalse);
    });
    test('.clear() clears the cache', () async {
      collectionCache.clear();

      final cacheValues = await collectionCache.values.first;
      expect(cacheValues, isEmpty);
    });
  });
  group('Prepopulated CollectionCache with immutable data', () {
    late CollectionCache<int> collectionCache;
    setUp(() {
      final data = Map<String, int>.unmodifiable({'dftlKey': 100});
      collectionCache = CollectionCache(data);
    });
    tearDown(() {
      collectionCache.clear();
    });
    test('.add() adds a value to cache', () async {
      final key = 'key';
      final value = 30;

      collectionCache.add(key, value);

      final cacheValues = await collectionCache.values.first;
      expect(cacheValues, isNotEmpty);
      expect(cacheValues, hasLength(2));
      expect(cacheValues[1], equals(value));
    });
  });
}
