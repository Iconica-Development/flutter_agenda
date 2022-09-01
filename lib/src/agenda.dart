import 'package:agenda/src/models/agenda_event.dart';
import 'package:agenda/src/models/agenda_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_time_picker/flutter_date_time_picker.dart';
import 'package:timetable/timetable.dart';

class AgendaWidget extends StatefulWidget {
  const AgendaWidget({
    required this.blocks,
    this.highlightedDates = const [],
    this.disabledDates = const [],
    this.initialDate,
    this.header,
    this.scrollController,
    this.scrollPhysics,
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

  final List<AgendaEvent> blocks;

  final List<DateTime> highlightedDates;

  final List<DateTime> disabledDates;

  /// The date that is initially selected.
  final DateTime? initialDate;

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
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    // filter out the blocks that are not on the selected date.
    var events =
        widget.blocks.where((block) => block.start.day == _selectedDate?.day);
    return DateTimePicker(
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
        blockWidth: widget.blockWidth,
        hourHeight: widget.hourHeight,
        startHour: widget.startHour,
        endHour: widget.endHour,
        timeBlocks: events.isEmpty
            ? []
            : events
                .map(
                  (e) => TimeBlock(
                    start: TimeOfDay(
                      hour: e.start.hour,
                      minute: e.start.minute,
                    ),
                    end: TimeOfDay(
                      hour: e.end.hour,
                      minute: e.end.minute,
                    ),
                    id: e.id ?? 0,
                    child: e.content,
                  ),
                )
                .toList(),
        theme: widget.theme.tableTheme,
        combineBlocks: true,
        mergeBlocks: true,
      ),
    );
  }
}
