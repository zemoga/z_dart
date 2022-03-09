import '../../io.dart';
import 'entity.dart';
import 'value_object.dart';

extension LegacyCacheExt<K extends ValueObject, V extends Entity<K>>
    on LegacyCache<K, V> {
  Future<void> putEntity(V entity) => this.put(entity.id, entity);

  Future<void> putEntities(List<V> entityList) {
    final entityMap = {for (var entity in entityList) entity.id: entity};
    return putAll(entityMap);
  }

  Future<void> replaceAllEntitiesBy(List<V> entityList) {
    final entityMap = {for (var entity in entityList) entity.id: entity};
    return replaceAll(entityMap);
  }
}
