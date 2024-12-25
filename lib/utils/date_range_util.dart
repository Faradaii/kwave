import 'package:intl/intl.dart';
class DateRangeFormatter {
  static String formatDateRange(String startDate, String endDate) {
    final DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    final DateFormat outputFormat = DateFormat('d MMM yyyy');
    final DateFormat outputFormatShort = DateFormat('d MMM');

    final DateTime start = inputFormat.parse(startDate);
    final DateTime end = inputFormat.parse(endDate);

    if (start.year == end.year && start.month == end.month) {
      return '${DateFormat('d').format(start)} - ${outputFormat.format(end)}';
    }
    else if (start.year == end.year) {
      return '${outputFormatShort.format(start)} - ${outputFormat.format(end)}';
    }
    else {
      return '${outputFormat.format(start)} - ${outputFormat.format(end)}';
    }
  }
}
