part of z.dart.convert;

List jsonFilterTreeList(
  List nodes,
  String subNodesEntryKey,
  bool Function(Map<String, dynamic> node) condition,
) {
  final filterNodes = [];
  // Ensure nodes are valid JSON objects
  final _nodes = nodes.whereType<Map<String, dynamic>>().toList();
  // Traverse the nodes
  for (var node in _nodes) {
    final filterNode = Map.of(node);
    // Process sub-nodes from unfiltered parent
    if (condition(filterNode)) {
      // Add node to results
      filterNodes.add(filterNode);
      // Traverse the sub-nodes
      final subNodes = filterNode.remove(subNodesEntryKey);
      if (subNodes is List && subNodes.isNotEmpty) {
        // Process sub-nodes recursively
        filterNode[subNodesEntryKey] =
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
  String nodeIdKey,
  String subNodesEntryKey,
) {
  /// Generate the ID used to bidirectionally link nodes to sub-nodes
  String generateId(Map<String, dynamic> node) {
    final ancestorIds = node.ancestorIds;
    final id = node[nodeIdKey];
    return [...ancestorIds, id].join('_').hashCode.toString();
  }

  final flatNodes = <Map<String, dynamic>>[];
  // Ensure nodes are valid JSON objects
  final _nodes = nodes.whereType<Map<String, dynamic>>().toList();
  // Traverse the nodes
  for (var node in _nodes) {
    // Clone node and add the relational "id" entry to it.
    final _node = Map.of(node);
    _node.id = generateId(_node);
    // Add node to results
    flatNodes.add(_node);
    // Traverse the sub-nodes
    final subNodes = _node.remove(subNodesEntryKey);
    if (subNodes is List && subNodes.isNotEmpty) {
      // Clone sub-nodes and add the relational entries to it.
      final _subNodes =
          subNodes.whereType<Map<String, dynamic>>().map((subNode) {
        final _subNode = Map.of(subNode);
        _subNode.parentId = _node.id;
        _subNode.ancestorIds = [..._node.ancestorIds, _node.id];
        return _subNode;
      }).toList();
      // Add sub-nodes IDs to node to create parent-to-child relationship
      _node.childIds = _subNodes.map(generateId).toList();
      // Process sub-nodes recursively
      final flatSubNodes = jsonFlattenTreeList(
        _subNodes,
        nodeIdKey,
        subNodesEntryKey,
      );
      // Add sub-nodes to results
      flatNodes.addAll(flatSubNodes);
    }
  }

  return flatNodes;
}

mixin JsonMapper<T> {
  T fromJson(Map jsonObj);

  Map toJson(T t);

  List<T> fromJsonArray(List jsonArray) =>
      jsonArray.map((e) => fromJson(e)).toList();
}
