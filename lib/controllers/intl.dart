import 'package:intl/intl.dart';

String? sleepStartTime;

void setSleepStartTime() {
  final now = DateTime.now();
  final formatter = DateFormat('HH:mm');
  sleepStartTime = formatter.format(now);
}