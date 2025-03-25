class TimeUtils {
  static List<String> generateTimeSlots() {
    final List<String> timeSlots = <String>[];
    final DateTime now = DateTime.now();

    final int nextMinute = now.minute < 30 ? 30 : 0;
    final int nextHour = now.minute < 30 ? now.hour : now.hour + 1;

    DateTime startTime = DateTime(
      now.year,
      now.month,
      now.day,
      nextHour,
      nextMinute,
    );

    final DateTime lastSlotEndTime = DateTime(
      now.year,
      now.month,
      now.day,
      22,
    );

    while (startTime.isBefore(lastSlotEndTime)) {
      final DateTime endTime = startTime.add(
        const Duration(
          minutes: 30,
        ),
      );

      if (endTime.isAfter(lastSlotEndTime)) {
        break;
      }

      final String slot = '${_formatTime(startTime)} - ${_formatTime(endTime)}';
      timeSlots.add(slot);

      startTime = endTime;
    }

    return timeSlots;
  }

  static String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
