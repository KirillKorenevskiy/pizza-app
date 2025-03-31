class CustomDateUtils {
  static String getCurrentDate() {
    final DateTime now = DateTime.now();

    final int year = now.year;
    final int month = now.month;
    final int day = now.day;
    final int hour = now.hour;
    final int minute = now.minute;

    final String formattedDate = '$year-$month-$day $hour:$minute';

    return formattedDate;
  }
}
