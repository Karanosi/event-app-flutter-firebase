import 'package:flutter/material.dart';

class MyEventsListPage extends StatefulWidget {
  const MyEventsListPage({super.key});

  @override
  State<MyEventsListPage> createState() => _MyEventsListPageState();
}

class _MyEventsListPageState extends State<MyEventsListPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('my Events list page'),
    );
  }
}
