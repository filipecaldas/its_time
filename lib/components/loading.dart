import 'package:flutter/material.dart';

Widget loadingScreen() {
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        Text("Carregando"),
      ],
    ),
  );
}
