abstract class UIUtils {
  static double parsePercentage(String percentage) {
    String numberString = percentage.replaceAll('%', '');

    double number = double.parse(numberString);

    double decimalValue = number / 100;
    double roundedValue = double.parse(decimalValue.toStringAsFixed(2));
    return roundedValue;
  }

  static String formatPercentage(String percentage) {
    String numberString = percentage.replaceAll('%', '');

    double number = double.parse(numberString);

    String roundedNumber = number.toStringAsFixed(2);

    String formattedPercentage = "$roundedNumber%";

    return formattedPercentage;
  }
}
