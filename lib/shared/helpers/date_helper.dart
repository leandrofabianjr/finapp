import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateHelper {
  static void setDefaultLocale() async {
    Intl.defaultLocale = 'pt_BR';
    await initializeDateFormatting();
  }

  static DateTime unixToDateTime(int unix) {
    if (unix != null) {
      return DateTime.fromMicrosecondsSinceEpoch(unix * 1000);
    }
    return null;
  }

  static int dateTimeToUnix(DateTime dateTime) {
    if (dateTime != null) {
      String strUnixMilliseconds =
          dateTime.toUtc().millisecondsSinceEpoch.toString();
      String strUnixSeconds =
          strUnixMilliseconds.substring(0, strUnixMilliseconds.length - 3);
      return int.parse(strUnixSeconds);
    }
    return null;
  }

  static String formatDateWeek(DateTime date) {
    return DateFormat.yMMMMEEEEd().format(date);
  }

  static String formatDate(DateTime date) {
    return DateFormat.yMd().format(date);
  }
}
