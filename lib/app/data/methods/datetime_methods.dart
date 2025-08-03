import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';

class DateTimeMethods {
  static Logger log = Logger();

  static String timeAgo(int millisecondsSinceEpoch) {
    final timestamp =
        DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    final now = DateTime.now();
    final difference = now
        .difference(timestamp)
        .abs(); // Use abs() to get the absolute duration

    if (timestamp.isAfter(now)) {
      // If the timestamp is in the future
      return 'In the future';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }

  static  String mergeDateAndTimeToString(
      DateTime selectedDate, TimeOfDay selectedTime) {
    // Combine date and time into a DateTime object
    DateTime combinedDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    // Format the DateTime object to a string
    DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    return dateFormat.format(combinedDateTime);
  }

 static String formatDate(String date) {
  // Normalize the date string to use '-' as the separator
  String normalizedDate = date.replaceAll(RegExp(r'[-/]'), '-');

  // Parse the date from the normalized format
  DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(normalizedDate);

  // Format the date to the new format
  String formattedDate = DateFormat('dd MMM yyyy').format(parsedDate);

  return formattedDate;
}

  static String convertToAgo(String dateAsString) {
    // Convert string to DateTime object
    DateTime currentDate = DateTime.now();
    DateTime date =
        DateFormat("E MMM dd HH:mm:ss '${currentDate.timeZoneName}'yyyy")
            .parse(dateAsString);

    // Get the time difference
    Duration difference = DateTime.now().difference(date);

    // Convert the time difference to a human-readable format using timeago
    return timeago.format(DateTime.now().subtract(difference));
  }

  static String getDateTimeToDDMMYYYY(DateTime value) {
    return ('${value.day}/${value.month}/${value.year}');
  }

  static String? getDateTimeToYYYMMDD(DateTime? value) {
    if (value != null) {
      log.i(value);
      var date = ('${value.year}/${value.month}/${value.day}');
      return date;
    }
    log.w("convertTimeStampToDateTime(), time is null");
    return null;
  }

  static int? convertDateTimeToTimeStamp(DateTime? date) {
    if (date != null) {
      log.i(date);
      return date.millisecondsSinceEpoch;
    }
    log.w("convertDateTimeToTimeStamp(), date is null");
    return null;
  }

  static DateTime? convertTimeStampToDateTime(int? timeStamp) {
    if (timeStamp != null) {
      var date = DateTime.fromMillisecondsSinceEpoch(timeStamp);
      return date;
    }
    log.w("convertTimeStampToDateTime(), time is null");
    return null;
  }

  static String convertTimeStampToHumanDate(int? timeStamp) {
    if (timeStamp != null) {
      var date = DateTime.fromMillisecondsSinceEpoch(timeStamp);
      return DateFormat('dd/MM/yyyy').format(date);
    }
    log.w("convertTimeStampToHumanDate(), time is null");
    return 'unknown date';
  }

  static String convertDateTimeToHumanDate(DateTime? date) {
    if (date != null) {
      return DateFormat('MMM d, y').format(date);
    }
    log.w("convertDateTimeToHumanDate(), time is null");
    return 'unknown date';
  }

  static String convertTimeOfDayTo12HourFormat(TimeOfDay? time,
      {bool includeMinutes = true}) {
    if (time != null) {
      final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
      final period = time.period == DayPeriod.am ? 'am' : 'pm';
      final minutes =
          includeMinutes ? ':${time.minute.toString().padLeft(2, '0')}' : '';
      return '$hour$minutes $period';
    }
    log.w("convertTimeOfDayTo12HourFormat(), time is null");
    return 'unknown';
  }

  static String convertTimeStampToHumanDate3(int? timeStamp) {
    if (timeStamp != null) {
      var date = DateTime.fromMillisecondsSinceEpoch(timeStamp);
      return DateFormat('MMM d, hh:mm a').format(date);
    }

    log.w("convertTimeStampToHumanDate3(), timeStamp is null");
    return 'unknown';
  }

  static String convertTimeStampToHumanDate4(int? timeStamp) {
    if (timeStamp != null) {
      var date = DateTime.fromMillisecondsSinceEpoch(timeStamp);
      return DateFormat('E, d MMM, hh:mm a').format(date);
    }

    log.w("convertTimeStampToHumanDate3(), timeStamp is null");
    return 'unknown';
  }

  static String convertTimeStampToHumanDate2(int? timeStamp) {
    if (timeStamp != null) {
      var date = DateTime.fromMillisecondsSinceEpoch(timeStamp);
      return DateFormat('MMM d, y').format(date);
    }

    log.w("convertTimeStampToHumanDate2(), timeStamp is null");
    return 'unknown';
  }

  static String convertTimeStampToHumanDateTime(int? timeStamp) {
    if (timeStamp != null) {
      var date = DateTime.fromMillisecondsSinceEpoch(timeStamp);
      return DateFormat('MMM d, y, h:mm a').format(date);
    }

    log.w("convertTimeStampToHumanDateTime(), timeStamp is null");
    return 'unknown';
  }

  static String convertTimeStampToHumanHour(int timeStamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    return DateFormat('hh:mm a').format(date);
  }

  static String dmyToMMYY(String date) {
    List<String> splitData = date.split("-");
    int day = int.parse(splitData[0]);
    int month = int.parse(splitData[1]) - 1;
    int year = int.parse(splitData[2]);
    DateTime output = DateTime(year, month, day);
    return DateFormat('MMM y').format(output);
  }

  static String ymdToEEEEdMM(String date) {
    List<String> splitData = date.split("-");
    int year = int.parse(splitData[0]);
    int month = int.parse(splitData[1]);
    int day = int.parse(splitData[2]);
    DateTime output = DateTime(year, month, day);
    return DateFormat('EEEE, d MMM').format(output);
  }

  static String convertDateTimeToDDMMM(DateTime? dateTime) {
    if (dateTime != null) {
      String formattedDate = DateFormat('dd MMM').format(dateTime);
      return formattedDate;
    }
    log.w("convertTimeStampToHumanDateTime(), timeStamp is null");
    return 'unknown';
  }

  static String convertDateTimeToYYYYMMDDHHMMZ(DateTime? date) {
    if (date != null) {
      DateTime currentDate = DateTime.now();
      var withoutTimeZone = DateFormat('yyyy-MM-dd HH:mm').format(date);
      var withTimeZone =
          '$withoutTimeZone GMT${(currentDate.timeZoneOffset.isNegative ? '' : '+') + currentDate.timeZoneOffset.toString()}';
      return withTimeZone;
    }

    log.w("convertDateTimeToYYYYMMDDHHMMZ(), DateTime is null");
    return 'unknown';
  }

  static String convertDurationToHumanTime(num value) {
    final h = (value ~/ 3600);
    final m = ((value % 3600) ~/ 60);
    final s = (value % 60).round();

    final parts = <String>[
      if (h != 0) '$h hr',
      if (m > 9) '$m min',
      if (m <= 9 && h != 0) '0$m min',
      if (m == 0 && h == 0) '',
      if (s > 9) '$s sec',
      if (s <= 9) '0$s sec',
    ];

    return parts.join(' ');
  }

  static String timePassed(int days) {
    int years = days ~/ 365;
    int remainingDaysAfterYears = days % 365;

    int months = remainingDaysAfterYears ~/ 30;
    int remainingDaysAfterMonths = remainingDaysAfterYears % 30;

    String yearsStr = years > 0 ? '$years year${years > 1 ? 's' : ''} ' : '';
    String monthsStr =
        months > 0 ? '$months month${months > 1 ? 's' : ''} ' : '';
    String daysStr = remainingDaysAfterMonths > 0
        ? '$remainingDaysAfterMonths day${remainingDaysAfterMonths > 1 ? 's' : ''} '
        : '';

    return '$yearsStr$monthsStr$daysStr'.trim();
  }

  static String? convertTimeStampToTimeAgo(int? timestamp) {
    if (timestamp == null) {
      return null;
    }
    final now = DateTime.now();
    final time = DateTime.fromMillisecondsSinceEpoch(timestamp);

    final difference = now.difference(time);

    if (difference.inDays >= 3) {
      final daysAgo = difference.inDays;
      return '$daysAgo ${daysAgo == 1 ? 'day' : 'days'} ago';
    } else if (difference.inDays >= 1) {
      return '1 day ago';
    } else if (difference.inHours >= 1) {
      final hoursAgo = difference.inHours;
      return '$hoursAgo ${hoursAgo == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes >= 1) {
      final minutesAgo = difference.inMinutes;
      return '$minutesAgo ${minutesAgo == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'just now';
    }
  }

  static String formatDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:${twoDigitMinutes}:${twoDigitSeconds}";
  }

  String convertToMMMdd(String inputDate) {
    // Assuming inputDate is in 'yyyy-mm-dd' format
    DateTime dateTime = DateTime.parse(inputDate);

    // Format the DateTime to 'MMM dd' format
    String formattedDate = DateFormat('MMM dd').format(dateTime);

    return formattedDate;
  }

 static String convertDateFormatToddMMyyyy(String date) {
    // Define the input and output date formats
    DateFormat inputFormat = DateFormat('dd/MM/yyyy');
    DateFormat outputFormat = DateFormat('dd MMM yyyy');

    // Parse the input date string to a DateTime object
    DateTime dateTime = inputFormat.parse(date);

    // Format the DateTime object to the desired output format
    String formattedDate = outputFormat.format(dateTime);

    return formattedDate;
  }

  String convertDateFormatToDotData(String date) {
    // Define the input and output date formats
    DateFormat inputFormat = DateFormat('yyyy-dd-MM');
    DateFormat outputFormat = DateFormat('dd.MM.yyyy');

    // Parse the input date string to a DateTime object
    DateTime dateTime = inputFormat.parse(date);

    // Format the DateTime object to the desired output format
    String formattedDate = outputFormat.format(dateTime);

    return formattedDate;
  }

  static String formatYYYYMMDDToddMMMYYYY(String date) {
    // Parse the input date string to DateTime
    DateTime dateTime = DateTime.parse(date);
    
    // Format the DateTime to desired output format
    return DateFormat('dd MMM yyyy').format(dateTime);
  }
}
