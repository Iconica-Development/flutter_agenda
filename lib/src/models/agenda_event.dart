import 'package:flutter/material.dart';

class AgendaEvent {
  const AgendaEvent({
    required this.start,
    required this.end,
    this.id,
    this.content,
  });

  /// The start  time of the event.
  final DateTime start;

  /// The end time of the event.
  final DateTime end;
  
  /// 
  final Widget? content;

  /// The identifier of the event that is used to combine events
  /// with the same id. Leave empty or 0 if you don't want to combine events.
  final int? id;
}
