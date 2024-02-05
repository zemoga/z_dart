part of '../../core.dart';

extension StringExt on String {
  bool get isValidPhoneNumber {
    final pattern = RegExp(
      r'(^([+]\d{2})?\d{10}$)',
    );
    return pattern.hasMatch(this);
  }

  bool get isValidEmail {
    final pattern = RegExp(
      r'[a-zA-Z0-9\+\.\_\%\-\+]{1,256}\@[a-zA-Z0-9][a-zA-Z0-9\-]{0,64}(\.[a-zA-Z0-9][a-zA-Z0-9\-]{0,25})+',
    );
    return pattern.hasMatch(this);
  }

  bool get isValidPassword {
    final pattern = RegExp(
      '^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%^&*])(?=.{8,})',
    );
    return pattern.hasMatch(this);
  }
}
