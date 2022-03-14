part of z.dart.ddd;

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
