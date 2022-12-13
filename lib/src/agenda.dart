// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:agenda/src/models/agenda_event.dart';
import 'package:agenda/src/models/agenda_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_time_picker/flutter_date_time_picker.dart';
import 'package:timetable/timetable.dart';

class AgendaWidget extends StatefulWidget {
  /// [AgendaWidget] is a widget that displays a timetable with events.
  /// It is stateful and sorts the events based on the selected date.
  /// All styling can be configured through the [AgendaTheme] class.
  const AgendaWidget({
    required this.blocks,
    this.highlightedDates = const [],
    this.disabledDates = const [],
    this.initialDate,
    this.header,
    this.scrollController,
    this.scrollPhysics,
    this.onTapDay,
    this.startHour = 0,
    this.endHour = 24,
    this.hourHeight = 80,
    this.highlightToday = true,
    this.blockWidth = 50,
    this.blockColor = const Color(0x80FF0000),
    this.theme = const AgendaTheme(),
    super.key,
  });

  /// Header widget that is displayed above the datepicker.
  final Widget? header;

  /// The blocks that are displayed in the agenda
  final List<AgendaEvent> blocks;

  /// The highlighted dates that are displayed in the agenda
  final List<DateTime> highlightedDates;

  /// The disabled dates that are displayed in the agenda
  final List<DateTime> disabledDates;

  /// The date that is initially selected.
  final DateTime? initialDate;

  /// Function called when the user taps on a day in the datepicker.
  final Function(DateTime)? onTapDay;

  /// Whether to highlight the current date in the agenda.
  final bool highlightToday;

  /// Hour at which the timetable starts.
  final int startHour;

  /// Hour at which the timetable ends.
  final int endHour;

  /// The heigh of one hour in the timetable.
  final double hourHeight;

  /// The width of the agendaItem if there is no child
  final double blockWidth;

  /// The color of the agendaItem if there is no child
  final Color blockColor;

  /// The theme used by the agenda.
  /// The [TableTheme] used by the timetable is included.
  final AgendaTheme theme;

  /// The scroll controller to control the scrolling of the timetable.
  final ScrollController? scrollController;

  /// The scroll physics used for the SinglechildScrollView.
  final ScrollPhysics? scrollPhysics;

  @override
  State<AgendaWidget> createState() => _AgendaWidgetState();
}

class _AgendaWidgetState extends State<AgendaWidget> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    var events = _filterEventsOnDay(widget.blocks, _selectedDate);
    return DragDownDateTimePicker(
      initialDate: _selectedDate,
      pickTime: false,
      highlightToday: widget.highlightToday,
      header: widget.header,
      onTapDay: (p0) {
        setState(() {
          _selectedDate = p0;
        });
      },
      disabledDates: widget.disabledDates,
      markedDates: widget.highlightedDates,
      dateTimePickerTheme: widget.theme.timePickerTheme,
      child: Timetable(
        scrollPhysics: widget.scrollPhysics,
        scrollController: widget.scrollController,
        blockColor: widget.blockColor,
        startHour: widget.startHour,
        endHour: widget.endHour,
        timeBlocks: events,
        theme: widget.theme.tableTheme,
        combineBlocks: true,
        mergeBlocks: true,
      ),
    );
  }

  List<TimeBlock> _filterEventsOnDay(List<AgendaEvent> events, DateTime day) {
    return events
        .where(
          (e) =>
              (e.start.day == day.day &&
                  e.start.month == day.month &&
                  e.start.year == day.year) ||
              (e.end.day == day.day &&
                  e.end.month == day.month &&
                  e.end.year == day.year),
        )
        .map(
          (e) => TimeBlock(
            start: (e.start.day != day.day)
                ? TimeOfDay(hour: widget.startHour, minute: 0)
                : TimeOfDay(
                    hour: e.start.hour,
                    minute: e.start.minute,
                  ),
            end: (e.end.day != day.day)
                ? TimeOfDay(hour: widget.endHour, minute: 0)
                : TimeOfDay(
                    hour: e.end.hour,
                    minute: e.end.minute,
                  ),
            id: e.id ?? 0,
            child: e.content,
          ),
        )
        .toList();
  }
}
