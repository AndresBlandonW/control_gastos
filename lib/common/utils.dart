
String dateToExpiry(DateTime dateTime) {
  final day = dateTime.day.toString().padLeft(2, '0');
  final month = dateTime.month.toString().padLeft(2, '0');
  return '$day/$month';
}

String formatBalance(double balance) {
  final balanceStr = balance.toStringAsFixed(2);
  final integerPart = balanceStr.split('.')[0];
  String formatted = '';
  int count = 0;
  for (int i = integerPart.length - 1; i >= 0; i--) {
    formatted = integerPart[i] + formatted;
    count++;
    if (count % 3 == 0 && i != 0) {
      formatted = ' $formatted';
    }
  }
  return '\$$formatted${balanceStr.substring(integerPart.length)}';
}

String capitalize(String value) {
    return '${value[0].toUpperCase()}${value.substring(1).toLowerCase()}';
}


double offsetToScale(double offset) => 1 - (offset / 5000);
