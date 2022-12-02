part of z.dart.core;

extension IterableExt<E> on Iterable<E> {
  E? get firstOrNull {
    return isEmpty ? null : first;
  }

  @Deprecated('The dartz package will be removed in a future release.')
  Either<dynamic, E> get firstEither {
    return catching(() => first);
  }

  @Deprecated('The dartz package will be removed in a future release.')
  Option<E> get firstOption {
    return firstEither.toOption();
  }

  E? get lastOrNull {
    return isEmpty ? null : last;
  }

  @Deprecated('The dartz package will be removed in a future release.')
  Either<dynamic, E> get lastEither {
    return catching(() => last);
  }

  @Deprecated('The dartz package will be removed in a future release.')
  Option<E> get lastOption {
    return lastEither.toOption();
  }

  E? get singleOrNull {
    return length != 1 ? null : single;
  }

  @Deprecated('The dartz package will be removed in a future release.')
  Either<dynamic, E> get singleEither {
    return catching(() => single);
  }

  @Deprecated('The dartz package will be removed in a future release.')
  Option<E> get singleOption {
    return singleEither.toOption();
  }

  @Deprecated('The dartz package will be removed in a future release.')
  Either<dynamic, E> firstWhereEither(bool Function(E element) test) {
    return catching(() => firstWhere(test));
  }

  @Deprecated('The dartz package will be removed in a future release.')
  Option<E> firstWhereOption(bool Function(E element) test) {
    return firstWhereEither(test).toOption();
  }

  @Deprecated('The dartz package will be removed in a future release.')
  Either<dynamic, E> lastWhereEither(bool Function(E element) test) {
    return catching(() => lastWhere(test));
  }

  @Deprecated('The dartz package will be removed in a future release.')
  Option<E> lastWhereOption(bool Function(E element) test) {
    return lastWhereEither(test).toOption();
  }

  @Deprecated('The dartz package will be removed in a future release.')
  Either<dynamic, E> singleWhereEither(bool Function(E element) test) {
    return catching(() => singleWhere(test));
  }

  @Deprecated('The dartz package will be removed in a future release.')
  Option<E> singleWhereOption(bool Function(E element) test) {
    return singleWhereEither(test).toOption();
  }

  @Deprecated('The dartz package will be removed in a future release.')
  Either<dynamic, E> elementAtEither(int index) {
    return catching(() => elementAt(index));
  }

  @Deprecated('The dartz package will be removed in a future release.')
  Option<E> elementAtOption(int index) {
    return elementAtEither(index).toOption();
  }

  bool containsEvery(Iterable<E>? other) {
    if (other == null) return false;

    return other.every((element) => contains(element));
  }

  bool containsAny(Iterable<E>? other) {
    if (other == null) return false;

    return other.any((element) => contains(element));
  }

  /// Returns a [Map] containing the elements from the given collection
  /// indexed by the key returned from [keySelector] function applied
  /// to each element.
  ///
  /// If any two elements would have the same key returned by [keySelector]
  /// the last one gets added to the map.
  ///
  /// The returned map preserves the entry iteration order of the original
  /// collection.
  Map<K, E> associateBy<K>(K Function(E e) keySelector) {
    return {for (var element in this) keySelector(element): element};
  }
}
