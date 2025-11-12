extension StringUtilities on String {
  bool isNumeric() {
    return double.tryParse(this) != null;
  }

  String removeExceptionPrefix() {
    return substring(indexOf(' '));
  }

  String seperateNumberByThousands() {
    if (length == 1) {
      return this;
    }
    String firstDigit = substring(0, 1);
    String restofDigits = substring(1).seperateNumberByThousands();
    if ('$firstDigit$restofDigits'.replaceAll(',', '').length % 3 == 0) {
      return ',$firstDigit$restofDigits';
    }
    return '$firstDigit$restofDigits';
  }
}