part of z.dart.convert;

List jsonFilterTreeList(
  List nodes,
  String subNodesEntryKey,
  bool Function(Map<String, dynamic> node) condition,
) {
  final filterNodes = [];
  // Ensure nodes are valid JSON objects
  final validNodes = nodes.whereType<Map<String, dynamic>>().toList();
  // Traverse the nodes
  for (var element in validNodes) {
    final node = Map.of(element);
    // Process sub-nodes from unfiltered parent
    if (condition(node)) {
      // Add node to results
      filterNodes.add(node);
      // Traverse the sub-nodes
      final subNodes = node.remove(subNodesEntryKey);
      if (subNodes is List && subNodes.isNotEmpty) {
        // Process sub-nodes recursively
        node[subNodesEntryKey] =
            jsonFilterTreeList(subNodes, subNodesEntryKey, condition);
      }
    }
  }
  // Filter the nodes
  return filterNodes;
}

extension _FlatNode on Map<String, dynamic> {
  String get id => this['id'];

  set id(String other) => this['id'] = other;

  String? get parentId => this['parentId'];

  set parentId(String? other) => this['parentId'] = other;

  List<String> get ancestorIds => this['ancestorId'] ?? [];

  set ancestorIds(List<String>? other) => this['ancestorId'] = other;

  List<String> get childIds => this['childId'] ?? [];

  set childIds(List<String>? other) => this['childId'] = other;
}

List<Map<String, dynamic>> jsonFlattenTreeList(
  List nodes,
  String subNodesEntryKey,
  String Function(Map<String, dynamic>) nodeIdGenerator,
) {
  final flatNodes = <Map<String, dynamic>>[];
  // Ensure nodes are valid JSON objects
  final validNodes = nodes.whereType<Map<String, dynamic>>().toList();
  // Traverse the nodes
  for (var element in validNodes) {
    // Clone node and add the relational "id" entry to it.
    final node = Map.of(element);
    node.id = nodeIdGenerator(node);
    // Add node to results
    flatNodes.add(node);
    // Traverse the sub-nodes
    final subNodes = node.remove(subNodesEntryKey);
    if (subNodes is List && subNodes.isNotEmpty) {
      // Clone sub-nodes and add the relational entries to it.
      final validSubNodes = subNodes.whereType<Map<String, dynamic>>().map((e) {
        final subNode = Map.of(e);
        subNode.parentId = node.id;
        subNode.ancestorIds = [...node.ancestorIds, node.id];
        return subNode;
      }).toList();
      // Add sub-nodes IDs to node to create parent-to-child relationship
      node.childIds = validSubNodes.map(nodeIdGenerator).toList();
      // Process sub-nodes recursively
      final flatSubNodes = jsonFlattenTreeList(
        validSubNodes,
        subNodesEntryKey,
        nodeIdGenerator,
      );
      // Add sub-nodes to results
      flatNodes.addAll(flatSubNodes);
    }
  }

  return flatNodes;
}

mixin JsonMapper<T> {
  T fromJson(Map jsonObj);

  Map toJson(T value);

  List<T> fromJsonArray(List jsonArray) {
    return jsonArray.map((e) => fromJson(e)).toList();
  }

  List toJsonArray(List<T> values) {
    return values.map((e) => toJson(e)).toList();
  }
}
