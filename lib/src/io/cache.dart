import 'package:z_dart/async.dart';

///
class CachePolicy {
  final Duration expireAfter;
  late DateTime _validationTime;

  CachePolicy({this.expireAfter = const Duration(minutes: 5)}) {
    invalidate();
  }

  bool get isExpired =>
      DateTime.now().difference(_validationTime) > expireAfter;

  void validate() => _validationTime = DateTime.now();

  void invalidate() => _validationTime = DateTime.fromMillisecondsSinceEpoch(0);
}

///
class Cache<T> {
  Cache(T initialData) {
    emit(initialData);
  }

  // This Subject is intended to be broadcasting while
  // the app is active so new events are propagated in a reactive way
  //
  // This analyzer warning is safe to ignore.
  // ignore: close_sinks
  final Subject<T> _subject = BehaviorSubject<T>();

  late T _data;

  /// The current [data].
  T get data => _data;

  /// The current value stream.
  Stream<T> get stream => _subject.stream;

  /// Updates the [data] to the provided [data].
  void emit(T data) {
    _data = data;
    _subject.add(data);
  }
}
