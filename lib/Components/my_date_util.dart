import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyDateUtil{
  static String getLastMessageTime(Timestamp time,BuildContext context){
    final DateTime sent = time.toDate();
    final DateTime now = DateTime.now();

    if (now.day == sent.day && now.month == sent.month && now.year == sent.year){
      return TimeOfDay.fromDateTime(sent).format(context);
    }

    return "${sent.day} ${_getMonthName(sent)}";
  }

  static String _getMonthName(DateTime sent) {
    switch (sent.month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return 'Invalid month';
    }
  }

  //todo get last seen time
  static String getLastSeenTime(Timestamp time,BuildContext context){
    final DateTime sent = time.toDate();
    final DateTime now = DateTime.now();

    if (now.day == sent.day && now.month == sent.month && now.year == sent.year){
      return "Today at ${TimeOfDay.fromDateTime(sent).format(context)}";
    }

    return "${sent.day} ${_getMonthName(sent)} at ${TimeOfDay.fromDateTime(sent).format(context)}";
  }
}