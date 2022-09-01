import 'package:flutter_date_time_picker/flutter_date_time_picker.dart';
import 'package:timetable/timetable.dart';

class AgendaTheme {
  const AgendaTheme({
    this.tableTheme = const TableTheme(),
    this.timePickerTheme = const DateTimePickerTheme(),
  });

  /// The theme for the timetable.
  final TableTheme tableTheme;

  /// The theme for the datetime picker.
  final DateTimePickerTheme timePickerTheme;
}
