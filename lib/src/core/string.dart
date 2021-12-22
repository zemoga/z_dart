extension StringExt on String {
  bool get isValidPassword =>
      RegExp('^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%^&*])(?=.{8,})')
          .hasMatch(this);
}
