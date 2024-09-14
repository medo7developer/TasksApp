import 'package:intl/intl.dart';

extension TimeExtensions on DateTime{

  String get toFormateTime{

    DateFormat formater = DateFormat('dd / MM / yy');
    return formater.format(this);
  }

  String get dayName{
    List<String> dayes = ['mon', 'tus', 'wed', 'thurs', 'fri', 'sat', 'sun'];
    return dayes[weekday - 1];
  }

}