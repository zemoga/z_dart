import 'package:test/test.dart';
import 'package:z_dart/convert.dart';

void main() {
  test('filter JSON Tree', () {
    final tags = ['item_A', 'item_A-A', 'item_A-A-B', 'item_B'];
    final result = jsonFilterTreeList(
      jsonTreeList,
      'children',
      (node) => tags.any((tag) => node['name'] == tag),
    );

    expect(result, hasLength(2));
    expect(result[0]['children'], hasLength(1));
    expect(result[0]['children'][0]['children'], hasLength(1));
  });

  test('filter JSON Tree using invalid node key', () {
    final tags = ['item_A', 'item_A-A', 'item_A-A-B', 'item_B'];
    final result = jsonFilterTreeList(
      jsonTreeList,
      'children',
      (node) => tags.any((tag) => node['invalidKey'] == tag),
    );

    expect(result, isEmpty);
  });

  test('flatten JSON Tree List', () {
    final result = jsonFlattenTreeList(
      jsonTreeList,
      'children',
      _nodeIdGenerator,
    );

    expect(result, hasLength(8));

    // Root Node
    expect(result[0].containsKey('id'), isTrue);
    expect(result[0].containsKey('name'), isTrue);
    expect(result[0].containsKey('childId'), isTrue);
    expect(result[0].containsKey('parentId'), isFalse);
    expect(result[0].containsKey('ancestorId'), isFalse);

    // Branch Node
    expect(result[1].containsKey('id'), isTrue);
    expect(result[1].containsKey('name'), isTrue);
    expect(result[1].containsKey('childId'), isTrue);
    expect(result[1].containsKey('parentId'), isTrue);
    expect(result[1].containsKey('ancestorId'), isTrue);

    // Leaf Node
    expect(result[2].containsKey('id'), isTrue);
    expect(result[2].containsKey('name'), isTrue);
    expect(result[2].containsKey('childId'), isFalse);
    expect(result[2].containsKey('parentId'), isTrue);
    expect(result[2].containsKey('ancestorId'), isTrue);
  });

  test('flatten JSON Tree ignoring invalid children value', () {
    final result = jsonFlattenTreeList(
      jsonTreeWithInvalidChildrenValue,
      'children',
      _nodeIdGenerator,
    );

    expect(result[0].containsKey('childId'), isFalse);
    expect(result[1].containsKey('childId'), isTrue);
  });

  test('ignores invalid JSON Tree List', () {
    final result = jsonFlattenTreeList(
      jsonTreeListWithInvalidType,
      'children',
      _nodeIdGenerator,
    );

    expect(result, isEmpty);
  });
}

/// Generate the ID used to bidirectionally link nodes to sub-nodes
String _nodeIdGenerator(Map<String, dynamic> node) {
  final ancestorIds = node['ancestorId'] ?? [];
  final id = node['name'] ?? '';
  return [...ancestorIds, id].join('_').hashCode.toString();
}

const jsonTreeList = [
  {
    'name': 'item_A',
    'children': [
      {
        'name': 'item_A-A',
        'children': [
          {'name': 'item_A-A-A'},
          {'name': 'item_A-A-B'}
        ]
      },
      {
        'name': 'item_A-B',
        'children': [
          {'name': 'item_A-B-A'},
          {'name': 'item_A-B-B'}
        ]
      },
    ]
  },
  {'name': 'item_B', 'children': []}
];
const jsonTreeListWithInvalidType = [
  {43: 'dfd'},
  {'name': 'item'},
];
const jsonTreeWithInvalidChildrenValue = [
  {
    'name': 'itemInvalidChildren',
    'children': 'invalidChildren',
  },
  {
    'name': 'item',
    'children': [
      {'name': 'item_child'}
    ],
  }
];
