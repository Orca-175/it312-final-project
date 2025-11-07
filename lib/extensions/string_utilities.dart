extension StringUtilities on String {
  bool isNumeric() {
    return double.tryParse(this) != null;
  }

  String removeExceptionPrefix() {
    return substring(indexOf(' '));
  }
}