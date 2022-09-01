import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: AgendaDemo()));
}

class AgendaDemo extends StatelessWidget {
  const AgendaDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Text('AgendaDemo'));
  }
}
