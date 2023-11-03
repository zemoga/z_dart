part of z.dart.core;

extension DateTimeExt on DateTime {
  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }

  bool isBetween(DateTime start, DateTime end) {
    return isAtSameMomentAs(start) ||
        isAtSameMomentAs(end) ||
        (isAfter(start) & isBefore(end));
  }
}
