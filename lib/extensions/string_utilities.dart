extension StringUtilities on String {
  bool isNumeric() {
    return double.tryParse(this) != null;
  }

  String removeExceptionPrefix() {
    return substring(indexOf(' '));
  }

  String seperateNumberByThousands() {
    String number = _seperator();

    if (number[0] == ',') {
      return number.substring(1);
    }

    return number;
  }

  String _seperator() {
    if (length == 1) {
      return this;
    }
    String firstDigit = substring(0, 1);
    String restofDigits = substring(1)._seperator();
    if ('$firstDigit$restofDigits'.replaceAll(',', '').length % 3 == 0) {
      return ',$firstDigit$restofDigits';
    }
    return '$firstDigit$restofDigits';
  }
}