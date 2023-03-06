import 'package:intl/intl.dart';

String getDateTime() {
  final dateTime = DateTime.now();
  final dateFormat = DateFormat('dd.MM.yyyy');
  final newDate = dateFormat.format(dateTime);
  return newDate;
}
