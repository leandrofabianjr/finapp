import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateHelper {

  static void setDefaultLocale() async {
    Intl.defaultLocale = 'pt_BR';
    await initializeDateFormatting();
  }

  static DateTime stringToDateTime(String str) {
    if (str != null && str != 'null' && str.isNotEmpty) {
      return DateTime.parse(str);
    }
    return null;
  }

  static String formatDateWeek(DateTime date) {
    return DateFormat.yMMMMEEEEd().format(date);
  }
}
