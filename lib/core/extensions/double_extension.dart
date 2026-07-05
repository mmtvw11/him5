extension DoubleExtension on double {
  String toCurrencyFormat() {
    return toStringAsFixed(2);
  }

  String toPercentageFormat() {
    return toStringAsFixed(1);
  }

  int toRating() {
    return toInt();
  }
}
