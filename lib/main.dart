import 'package:flutter/material.dart';
import 'package:its_time/screens/dashboard.dart';
import 'package:its_time/screens/to_do_list.dart';

void main() {
  runApp(ItsTimeApp());
}

class ItsTimeApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ToDoList());
  }
}
