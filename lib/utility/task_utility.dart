import 'package:intl/intl.dart';

class TaskUtility {
  static String formatStringDate(String dateString) {
    try {
      // This works for ISO 8601 strings (yyyy-MM-dd)
      DateTime dateTime = DateTime.parse(dateString);

      // You can use presets like yMMMd() or custom patterns like "dd/MM/yyyy"
      return DateFormat.yMMMd().format(dateTime);
    } catch (e) {
      return "Invalid Date";
    }
  }
}
