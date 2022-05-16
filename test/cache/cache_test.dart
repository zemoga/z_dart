import 'package:test/test.dart';
import 'package:z_dart/cache.dart';

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
      collectionCache = CollectionCache();
    });
    tearDown(() {
      collectionCache.close();
    });
    test('.add() adds a data entry to cache', () async {
      final key = 'key';
      final value = 45;

      await collectionCache.add(key, value);

      final cacheValues = await collectionCache.values.first;
      expect(cacheValues, isNotEmpty);
      expect(cacheValues.first, equals(value));
    });
    test('.addAll() adds a data map to cache', () async {
      final other = {'keyA': 25, 'keyB': 50, 'keyC': 75, 'keyD': 100};

      await collectionCache.addAll(other);

      final cacheValues = await collectionCache.values.first;
      expect(cacheValues, isNotEmpty);
      expect(cacheValues, hasLength(4));
      expect(cacheValues, equals(other.values));
    });
    test('.replaceAll() replaces all cache data with a new data map', () async {
      final oldData = {'key': 0};

      await collectionCache.addAll(oldData);

      final oldCacheValues = await collectionCache.values.first;
      expect(oldCacheValues, isNotEmpty);
      expect(oldCacheValues, hasLength(1));
      expect(oldCacheValues, equals(oldData.values));

      final newData = {'keyA': 25, 'keyB': 50, 'keyC': 75, 'keyD': 100};

      await collectionCache.replaceAll(newData);

      final cacheValues = await collectionCache.values.first;
      expect(cacheValues, isNotEmpty);
      expect(cacheValues, hasLength(4));
      expect(cacheValues, equals(newData.values));
    });
  });
  group('Prepopulated CollectionCache', () {
    late CollectionCache collectionCache;
    setUp(() {
      final data = {'dftlKey': 100};
      collectionCache = CollectionCache(initialData: data);
    });
    tearDown(() {
      collectionCache.clear();
    });
    test('.add() adds a value to cache', () async {
      final key = 'key';
      final value = 30;

      await collectionCache.add(key, value);

      final cacheValues = await collectionCache.values.first;
      expect(cacheValues, isNotEmpty);
      expect(cacheValues, hasLength(2));
      expect(cacheValues[1], equals(value));
    });
    test('.remove() removes a value from cache', () async {
      final other = {'keyA': 25, 'keyB': 50, 'keyC': 75, 'keyD': 100};

      await collectionCache.addAll(other);
      await collectionCache.remove('keyB');

      final cacheData = await collectionCache.stream.first;
      expect(cacheData, isNotEmpty);
      expect(cacheData, hasLength(4));
      expect(cacheData.containsKey('keyB'), isFalse);
    });
    test('.clear() clears the cache', () async {
      await collectionCache.clear();

      final cacheValues = await collectionCache.values.first;
      expect(cacheValues, isEmpty);
    });
  });
  group('Prepopulated CollectionCache with immutable data', () {
    late CollectionCache collectionCache;
    setUp(() {
      final data = Map<String, int>.unmodifiable({'dftlKey': 100});
      collectionCache = CollectionCache(initialData: data);
    });
    tearDown(() {
      collectionCache.clear();
    });
    test('.add() adds a value to cache', () async {
      final key = 'key';
      final value = 30;

      await collectionCache.add(key, value);

      final cacheValues = await collectionCache.values.first;
      expect(cacheValues, isNotEmpty);
      expect(cacheValues, hasLength(2));
      expect(cacheValues[1], equals(value));
    });
  });
}
