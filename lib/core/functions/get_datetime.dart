import 'package:intl/intl.dart';

String getDateTime() {
  final dateTime = DateTime.now();
  final dateFormat = DateFormat('dd.MM.yyyy hh:mm:ss');
  final newDate = dateFormat.format(dateTime);
  return newDate;
}
