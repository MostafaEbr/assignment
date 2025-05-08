import 'package:intl/intl.dart';

class AppDateFormater{
  static String dayMonthYear(DateTime date)=> '${date.day}/${date.month}/${date.year}';
  static String dayMonthYearString(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return formatDate(parsedDate);
  }
  /// For time need only to increase this part hh:mm a
  static String formatDate(DateTime date) => new DateFormat("dd/MM/yyyy ").format(date);

 }