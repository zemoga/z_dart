part of z.dart.ddd;

///
@Deprecated('Use IdentifiableCollectionCacheMixin instead.')
mixin EntityCollectionCacheMixin<T extends Entity>
    implements CollectionCacheMixin<T> {
  Future<bool> containsEntity(T entity) {
    return contains(entity.id.toString());
  }

  Future<void> addEntity(T entity) {
    return add(entity.id.toString(), entity);
  }

  Future<void> addAllEntities(List<T> otherEntities) {
    return addAll(otherEntities.toMap());
  }

  Future<void> replaceAllEntities(List<T> otherEntities) {
    return replaceAll(otherEntities.toMap());
  }

  Future<void> removeEntity(T entity) {
    return remove(entity.id.toString());
  }
}

///
@Deprecated('Use IdentifiableCollectionCache instead.')
class EntityCollectionCache<T extends Entity> extends CollectionCache<T>
    with EntityCollectionCacheMixin<T> {
  EntityCollectionCache() : super();

  EntityCollectionCache.from(Iterable<T> entities)
      : super.from(entities.toMap());
}

@Deprecated('This will be removed in a future version')
extension LegacyCacheExt<K extends ValueObject, V extends Entity<K>>
    on LegacyCache<K, V> {
  @Deprecated("Use 'addObject' instead.")
  Future<void> putEntity(V entity) => this.put(entity.id, entity);

  Future<void> addObject(V other) => putEntity(other);

  @Deprecated("Use 'addAllObjects' instead.")
  Future<void> putEntities(List<V> entityList) {
    final entityMap = {for (var entity in entityList) entity.id: entity};
    return putAll(entityMap);
  }

  Future<void> addAllObjects(List<V> others) => putEntities(others);

  @Deprecated("Use 'replaceAllObjects' instead.")
  Future<void> replaceAllEntitiesBy(List<V> entityList) {
    final entityMap = {for (var entity in entityList) entity.id: entity};
    return replaceAll(entityMap);
  }

  Future<void> replaceAllObjects(List<V> others) =>
      replaceAllEntitiesBy(others);
}
