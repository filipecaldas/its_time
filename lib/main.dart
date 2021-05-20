import 'package:flutter/material.dart';

void main() {
  runApp(ItsTimeApp());
}

class ItsTimeApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return (Text(
      "Hello World!",
      textDirection: TextDirection.ltr,
    ));
  }
}
