import 'package:intl/intl.dart';

class AppFormatter {
  static String formatDate(String dateStr) {
    if (dateStr.isEmpty) return '';
    try {
      DateTime date = DateTime.parse(dateStr).toLocal();
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  static String formatTime(String dateStr) {
    if (dateStr.isEmpty) return '';
    try {
      DateTime date = DateTime.parse(dateStr).toLocal();
      return DateFormat('h:mm a').format(date);
    } catch (e) {
      return dateStr;
    }
  }
}
