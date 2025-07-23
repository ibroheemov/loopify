extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  bool toBoolean() {
    if (toLowerCase() == "true" || toLowerCase() == "1") {
      return true;
    } else if (toLowerCase() == "false" || toLowerCase() == "0") {
      return false;
    } else {
      throw UnsupportedError(
          "Unsupported value for conversion to boolean: $this");
    }
  }
}

extension IntExtension on int {
  String addZero() {
    return this < 10 ? "0$this" : toString();
  }
}
