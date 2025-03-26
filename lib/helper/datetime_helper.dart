import 'dart:math';

class DateTimeHelper{

  static const _daysInMonth = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

  bool isLeapYear(int value) =>
      value % 400 == 0 || (value % 4 == 0 && value % 100 != 0);

  int daysInMonth(int year, int month) {
    var result = _daysInMonth[month];
    if (month == 2 && isLeapYear(year)) result++;
    return result;
  }

  DateTime addMonths(DateTime dt, int value) {
    var r = value % 12;
    var q = (value - r) ~/ 12;
    var newYear = dt.year + q;
    var newMonth = dt.month + r;
    if (newMonth > 12) {
      newYear++;
      newMonth -= 12;
    }
    var newDay = min(dt.day, daysInMonth(newYear, newMonth));
    if (dt.isUtc) {
      return DateTime.utc(
          newYear,
          newMonth,
          newDay,
          dt.hour,
          dt.minute,
          dt.second,
          dt.millisecond,
          dt.microsecond);
    } else {
      return DateTime(
          newYear,
          newMonth,
          newDay,
          dt.hour,
          dt.minute,
          dt.second,
          dt.millisecond,
          dt.microsecond);
    }
  }
}