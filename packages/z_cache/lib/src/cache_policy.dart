part of z.cache;

///
final class CachePolicy {
  CachePolicy({this.expireAfter = const Duration(minutes: 5)}) {
    invalidate();
  }

  final Duration expireAfter;
  late DateTime _validationTime;

  bool get isExpired =>
      DateTime.now().difference(_validationTime) > expireAfter;

  void validate() => _validationTime = DateTime.now();

  void invalidate() => _validationTime = DateTime.fromMillisecondsSinceEpoch(0);
}
