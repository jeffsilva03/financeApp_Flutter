import 'package:intl/intl.dart';

class AppFormatters {
  static final currencyFormatter = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
    decimalDigits: 2,
  );
  
  static final dateFormatter = DateFormat('dd/MM/yyyy', 'pt_BR');
  static final shortDateFormatter = DateFormat('dd/MM', 'pt_BR');
  static final monthYearFormatter = DateFormat('MMMM yyyy', 'pt_BR');
  static final dayMonthFormatter = DateFormat('dd MMM', 'pt_BR');
  
  static String formatCurrency(double value) {
    return currencyFormatter.format(value);
  }
  
  static String formatDate(DateTime date) {
    return dateFormatter.format(date);
  }
  
  static String formatShortDate(DateTime date) {
    return shortDateFormatter.format(date);
  }
  
  static String formatMonthYear(DateTime date) {
    final formatted = monthYearFormatter.format(date);
    return formatted[0].toUpperCase() + formatted.substring(1);
  }
  
  static String formatDayMonth(DateTime date) {
    return dayMonthFormatter.format(date);
  }
  
  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
  
  static DateTime getNextPaymentDate(int day) {
    final now = DateTime.now();
    final currentMonth = DateTime(now.year, now.month, day);
    
    if (currentMonth.isAfter(now)) {
      return currentMonth;
    } else {
      return DateTime(now.year, now.month + 1, day);
    }
  }
  
  static String formatPercentage(double value) {
    return '${value.toStringAsFixed(1)}%';
  }
  
  static double parseDouble(String value) {
    if (value.isEmpty) return 0.0;
    return double.tryParse(value.replaceAll('.', '').replaceAll(',', '.')) ?? 0.0;
  }
}