import 'package:flutter/material.dart';

import 'EventAddPage.dart';
import 'EventsListPage.dart';
import 'MyEventsListPage.dart';
import 'UserUpdatePage.dart';

class PageTree extends StatefulWidget {
  final int index;
  const PageTree({super.key, required this.index});

  @override
  State<PageTree> createState() => _PageTreeState();
}

class _PageTreeState extends State<PageTree> {
  @override
  Widget build(BuildContext context) {
    switch (widget.index) {
      case 0:
        return EventsListPage();
      case 1:
        return EventAddPage();
      case 2:
        return MyEventsListPage();
      case 3:
        return UserUpdatePage();
      default:
        return EventsListPage();
    }
  }
}
