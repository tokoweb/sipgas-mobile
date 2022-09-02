import 'package:intl/intl.dart';

extension IntExtension on int {
  String toMoneyIdrFormat() {
    switch (this.toString().length) {
      case 4:
        return this.toString().substring(0, 1) +
            "." +
            this.toString().substring(1, 4);
      case 5:
        return this.toString().substring(0, 2) +
            "." +
            this.toString().substring(2, 5);
      case 6:
        return this.toString().substring(0, 3) +
            "." +
            this.toString().substring(3, 6);
      case 7:
        return this.toString().substring(0, 1) +
            "." +
            this.toString().substring(1, 4) +
            "." +
            this.toString().substring(4, 7);
      case 8:
        return this.toString().substring(0, 2) +
            "." +
            this.toString().substring(2, 5) +
            "." +
            this.toString().substring(5, 8);
      case 9:
        return this.toString().substring(0, 3) +
            "." +
            this.toString().substring(3, 6) +
            "." +
            this.toString().substring(6, 9);
      case 10:
        return this.toString().substring(0, 1) +
            "." +
            this.toString().substring(1, 4) +
            "." +
            this.toString().substring(4, 7) +
            "." +
            this.toString().substring(7, 10);
      case 11:
        return this.toString().substring(0, 2) +
            "." +
            this.toString().substring(2, 5) +
            "." +
            this.toString().substring(5, 8) +
            "." +
            this.toString().substring(8, 11);
      case 12:
        return this.toString().substring(0, 3) +
            "." +
            this.toString().substring(3, 6) +
            "." +
            this.toString().substring(6, 9) +
            "." +
            this.toString().substring(9, 12);
      case 13:
        return this.toString().substring(0, 1) +
            "." +
            this.toString().substring(1, 4) +
            "." +
            this.toString().substring(4, 7) +
            "." +
            this.toString().substring(7, 10) +
            "." +
            this.toString().substring(10, 13);
      case 14:
        return this.toString().substring(0, 2) +
            "." +
            this.toString().substring(2, 5) +
            "." +
            this.toString().substring(5, 8) +
            "." +
            this.toString().substring(8, 11) +
            "." +
            this.toString().substring(11, 14);
      case 15:
        return this.toString().substring(0, 3) +
            "." +
            this.toString().substring(3, 6) +
            "." +
            this.toString().substring(6, 9) +
            "." +
            this.toString().substring(9, 12) +
            "." +
            this.toString().substring(12, 15);
      default:
        this.toString();
    }
    return this.toString();
  }

  // Formatter Currency
  String toCurrencyFormat() =>
      NumberFormat.decimalPattern('id').format(int.parse(this.toString()));
  // String get currency =>
  //     NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;
}
