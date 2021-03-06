import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateHelper {
  static DateTime get currentDate => DateTime.now();

  static void setDefaultLocale() async {
    Intl.defaultLocale = 'pt_BR';
    await initializeDateFormatting();
  }

  static DateTime unixToDateTime(int unixEpoch) {
    if (unixEpoch != null) {
      return DateTime.fromMillisecondsSinceEpoch(unixEpoch * 1000);
    }
    return null;
  }

  static int dateTimeToUnix(DateTime datetime) {
    if (datetime != null) {
      int unixEpoch = (datetime.toUtc().millisecondsSinceEpoch / 1000).round();
      return unixEpoch;
    }
    return null;
  }

  static String formatDateWeek(DateTime datetime) {
    return DateFormat.yMMMMEEEEd().format(datetime);
  }

  static String formatDate(DateTime datetime) {
    return DateFormat.yMd().format(datetime);
  }

  static String getMonthName(DateTime datetime) {
    return DateFormat.MMMM().format(datetime);
  }

  static bool isToday(DateTime datetime) {
    return DateTime.now().difference(datetime).inDays == 0;
  }

  static List<String> monthsOfTheYear() {
    return [
      'Janeiro',
      'Fevereiro',
      'Março',
      'Abril',
      'Maio',
      'Junho',
      'Julho',
      'Agosto',
      'Setembro',
      'Outubro',
      'Novembro',
      'Dezembro'
    ];
  }

  static DateTime firstMomentOfTheDay(DateTime datetime) {
    var duration = Duration(
      hours: datetime.hour,
      minutes: datetime.minute,
      seconds: datetime.second,
      milliseconds: datetime.millisecond,
      microseconds: datetime.microsecond,
    );
    return datetime.subtract(duration);
  }

  static DateTime lastMomentOfTheDay(DateTime datetime) {
    var duration = Duration(
      hours: datetime.hour,
      minutes: datetime.minute,
      seconds: datetime.second + 1,
      milliseconds: datetime.millisecond,
      microseconds: datetime.microsecond,
    );
    return datetime.add(Duration(days: 1)).subtract(duration);
  }

  static int firstMomentOfTheDayUnix(DateTime datetime) {
    return dateTimeToUnix(firstMomentOfTheDay(datetime));
  }

  static int lastMomentOfTheDayUnix(DateTime datetime) {
    return dateTimeToUnix(lastMomentOfTheDay(datetime));
  }
}
