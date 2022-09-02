import 'package:agenda/agenda.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: AgendaDemo()));
}

class AgendaDemo extends StatelessWidget {
  const AgendaDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AgendaWidget(
          header: Text('Agenda', style: Theme.of(context).textTheme.headline6),
          blockWidth: 50,
          highlightToday: false,
          blocks: [
            AgendaEvent(
              start: DateTime.now().subtract(const Duration(hours: 3)),
              end: DateTime.now().add(const Duration(hours: 2)),
            ),
            AgendaEvent(
              start: DateTime.now().subtract(const Duration(hours: 2)),
              end: DateTime.now().add(const Duration(hours: 1)),
            ),
            AgendaEvent(
              start: DateTime.now().subtract(const Duration(hours: 1)),
              end: DateTime.now().add(const Duration(hours: 1)),
            ),
            AgendaEvent(
              start: DateTime.now().add(const Duration(hours: 3)),
              end: DateTime.now().add(const Duration(hours: 4)),
              id: 4,
              content: const Text('event 4'),
            ),
            AgendaEvent(
              start: DateTime.now().add(const Duration(hours: 3)),
              end: DateTime.now().add(const Duration(hours: 4)),
              id: 4,
              content: const Text('event 5'),
            ),
            AgendaEvent(
              start: DateTime.now().add(const Duration(hours: 3)),
              end: DateTime.now().add(const Duration(hours: 4)),
              id: 4,
              content: const Text('event 6'),
            ),
            AgendaEvent(
              start: DateTime.now().add(const Duration(days: 1)),
              end: DateTime.now()
                  .add(const Duration(days: 1))
                  .add(const Duration(hours: 2)),
            ),
            AgendaEvent(
              start: DateTime.now().subtract(const Duration(hours: 2)),
              end: DateTime.now().add(const Duration(hours: 1)),
            ),
            AgendaEvent(
              start: DateTime.now().add(const Duration(days: 2)),
              end: DateTime.now().add(const Duration(days: 3)),
            ),
          ],
          disabledDates: [
            // yesterday
            DateTime.now().subtract(const Duration(days: 1)),
          ],
          highlightedDates: [
            // tomorrow
            DateTime.now().add(const Duration(days: 1)),
          ],
          theme: const AgendaTheme(
            tableTheme: TableTheme(
              blockPaddingBetween: 10,
            ),
          ),
        ),
      ),
    );
  }
}
