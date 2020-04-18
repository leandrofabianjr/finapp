class DateHelper {
  static DateTime stringToDateTime(String str) {
    if (str != null && str != 'null' && str.isNotEmpty) {
      return DateTime.parse(str);
    }
    return null;
  }
}