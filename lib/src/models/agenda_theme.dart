// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter_date_time_picker/flutter_date_time_picker.dart';
import 'package:flutter_timetable/flutter_timetable.dart';

class AgendaTheme {
  /// [AgendaTheme] is a class that contains all styling options
  /// for the [AgendaWidget].
  /// The underlying [TableTheme] is used for the timetable.
  /// The [DateTimePickerTheme] is used for the datepicker.
  const AgendaTheme({
    this.tableTheme = const TableTheme(),
    this.timePickerTheme = const DateTimePickerTheme(),
  });

  /// The theme for the timetable.
  final TableTheme tableTheme;

  /// The theme for the datetime picker.
  final DateTimePickerTheme timePickerTheme;
}
