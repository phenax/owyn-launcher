import 'package:flutter/material.dart';

Widget wrapper(Widget view) {
  return MaterialApp(
      title: 'owyn test',
      home: Scaffold(
          body: PageView(
              controller: PageController(),
              children: [ view ],
          ),
      ),
    );
}
