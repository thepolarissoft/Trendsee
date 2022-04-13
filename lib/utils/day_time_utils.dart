import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/data/models/business_user_response.dart';
import 'package:trendoapp/providers/business_user_provider.dart';
import 'package:timezone/timezone.dart' as tz;

class DayTimeUtils {
  String convertToAgo(DateTime date) {
    Duration difference = DateTime.now().difference(date);
    // print("DIFF->> $difference");
    if (difference.inDays >= 8) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);
      return formattedDate.toString();
    } else if ((difference.inDays / 7).floor() >= 1) {
      return 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return 'Yesterday';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }

  String getDay(int i) {
    switch (i) {
      case 0:
        return "Sunday";
        break;
      case 1:
        return "Monday";
        break;
      case 2:
        return "Tuesday";
        break;
      case 3:
        return "Wednesday";
        break;
      case 4:
        return "Thursday";
        break;
      case 5:
        return "Friday";
        break;
      case 6:
        return "Saturday";
        break;
      default:
        return "Sunday";
    }
  }

  void convertLocalToUtc({
    @required List<BusinessHoursResponse> list,
    @required BuildContext context,
    @required bool isOpenTime,
  }) {
    var provider = Provider.of<BusinessUserProvider>(context, listen: false);
    print("TimeZone-> ${provider.selectedTimeZone.value}");
    if (isOpenTime) {
      // for (var i = 0; i < provider.listOpenTime.length; i++) {
      //   print("OPEN Time From DateTimeUtils $i ${provider.listOpenTime[i]}");
      // }
      provider.listOpenTime.clear();
      DateTime date = new DateTime.now();
      for (var i = 0; i < list.length; i++) {
        print("LIST business Hours openTime ${list[i].openTime}");
        if (list[i].openTime == "-1") {
          provider.listOpenTime.add("-1");
        } else {
          date = new DateTime(
              date.year,
              date.month,
              date.day,
              list[i].openTime != "-1"
                  ? int.parse(list[i].openTime.split(":")[0])
                  : 0,
              list[i].openTime != "-1"
                  ? int.parse(list[i].openTime.split(":")[1])
                  : 0);
          // print("Selected Hour-> ${date.hour}");
          // print("Selected Minute-> ${date.minute}");
          final timeZone = tz.getLocation(provider.selectedTimeZone.utc[0]);
          DateTime dateTimeConverted = tz.TZDateTime.from(date, timeZone);
          // print("Converted Hour-> ${dateTimeConverted.toUtc().hour}");
          // print("Converted Minute-> ${dateTimeConverted.toUtc().minute}");
          String open =
              dateTimeConverted.toUtc().hour.toString().padLeft(2, "0") +
                  ":" +
                  dateTimeConverted.toUtc().minute.toString().padLeft(2, "0");
          provider.listOpenTime.add(open);
        }

        print("listOpenTime-> ${provider.listOpenTime.join(",")}");
      }
    } else {
      // for (var i = 0; i < provider.listCloseTime.length; i++) {
      //   print("CLOSE Time From DateTimeUtils $i ${provider.listCloseTime[i]}");
      // }
      provider.listCloseTime.clear();
      DateTime date = new DateTime.now();
      for (var i = 0; i < list.length; i++) {
        print("LIST business Hours closeTime ${list[i].closeTime}");
        if (list[i].closeTime == "-1") {
          provider.listCloseTime.add("-1");
        } else {
          date = new DateTime(
              date.year,
              date.month,
              date.day,
              list[i].closeTime != "-1"
                  ? int.parse(list[i].closeTime.split(":")[0])
                  : 0,
              list[i].closeTime != "-1"
                  ? int.parse(list[i].closeTime.split(":")[1])
                  : 0);
          final timeZone = tz.getLocation(provider.selectedTimeZone.utc[0]);
          DateTime dateTimeConverted = tz.TZDateTime.from(date, timeZone);
          // print("Time-> ${dateTimeConverted.toUtc().hour}");
          // print("Time-> ${dateTimeConverted.toUtc().minute}");
          String close =
              dateTimeConverted.toUtc().hour.toString().padLeft(2, "0") +
                  ":" +
                  dateTimeConverted.toUtc().minute.toString().padLeft(2, "0");
          provider.listCloseTime.add(close);
        }
        print("listCloseTime-> ${provider.listCloseTime.join(",")}");
      }
    }
  }

  void convertUtcToLocal({
    @required List<BusinessHoursResponse> list,
    @required BuildContext context,
    @required bool isOpenTime,
  }) {
    var provider = Provider.of<BusinessUserProvider>(context, listen: false);

    if (isOpenTime) {
      // provider.listOpenTime.clear();
      DateTime date;
      DateTime utcDate = DateTime.now().toUtc();
      for (var i = 0; i < list.length; i++) {
        if (list[i].openTime == "-1") {
          list[i].openTime = "-1";
        } else {
          date = DateTime.utc(
              utcDate.year,
              utcDate.month,
              utcDate.day,
              list[i].openTime != "-1"
                  ? int.parse(list[i].openTime.split(":")[0])
                  : 0,
              list[i].openTime != "-1"
                  ? int.parse(list[i].openTime.split(":")[1])
                  : 0);
          print("Selected Hour==-> ${date.hour}");
          print("Selected Minute==-> ${date.minute}");
          final timeZone = tz.getLocation(provider.selectedTimeZone.utc[0]);
          print("Timezone----> ${timeZone.name}");
          DateTime dateTimeConverted = tz.TZDateTime.from(date, timeZone);
          print("Converted Hour==-> ${dateTimeConverted.hour}");
          print("Converted Minute==-> ${dateTimeConverted.minute}");
          String open = dateTimeConverted.hour.toString() +
              ":" +
              dateTimeConverted.minute.toString();
          list[i].openTime = open;
          // provider.listOpenTime.add(open);
          // print("listOpenTime-> ${provider.listOpenTime.join(",")}");
          // convertLocalToUtc(list: list, context: context, isOpenTime: true);
        }
      }
    } else {
      // provider.listCloseTime.clear();
      DateTime date;
      DateTime utcDate = DateTime.now().toUtc();
      for (var i = 0; i < list.length; i++) {
        if (list[i].closeTime == "-1") {
          list[i].closeTime = "-1";
        } else {
          date = DateTime.utc(
              utcDate.year,
              utcDate.month,
              utcDate.day,
              list[i].closeTime != "-1"
                  ? int.parse(list[i].closeTime.split(":")[0])
                  : 0,
              list[i].closeTime != "-1"
                  ? int.parse(list[i].closeTime.split(":")[1])
                  : 0);
          final timeZone = tz.getLocation(provider.selectedTimeZone.utc[0]);
          DateTime dateTimeConverted = tz.TZDateTime.from(date, timeZone);
          print("Time-> ${dateTimeConverted.hour}");
          print("Time-> ${dateTimeConverted.minute}");
          String close = dateTimeConverted.hour.toString() +
              ":" +
              dateTimeConverted.minute.toString();
          list[i].closeTime = close;
          // provider.listCloseTime.add(close);
          // print("listCloseTime-> ${provider.listCloseTime.join(",")}");
          // convertLocalToUtc(list: list, context: context, isOpenTime: false);
        }
      }
    }
  }
}
