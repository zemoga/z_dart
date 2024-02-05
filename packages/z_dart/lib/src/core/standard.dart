part of '../../core.dart';

/// Calls the specified function [block] and returns its result.
R run<R>(R Function() block) {
  return block();
}

extension ScopeFunctions<T> on T {
  /// Calls the specified function [block] with `this` value
  /// as its argument and returns `this` value.
  T also(void Function(T it) block) {
    block(this);
    return this;
  }

  /// Calls the specified function [block] with `this` value
  /// as its argument and returns its result.
  R let<R>(R Function(T it) block) {
    return block(this);
  }
}
