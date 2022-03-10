part of z.dart.core;

class PagedList<E> {
  final int totalElements;
  final List<E> elements;

  const PagedList(this.totalElements, this.elements);

  const PagedList.empty() : this(0, const []);

  PagedList<T> map<T>(T Function(E e) mapper) => PagedList(
        totalElements,
        elements.map(mapper).toList(),
      );
}
