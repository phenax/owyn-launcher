import 'dart:async';
import 'package:flutter/material.dart';

import 'pages/Home.dart';
import 'pages/Apps.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Stream<DateTime> time$ = Stream.periodic(Duration(seconds: 1), (_x) => DateTime.now()).asBroadcastStream();

  @override
  void dispose() {
    time$.drain();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'owyn launcher',
      home: Scaffold(
          body: PageView(
              controller: PageController(keepPage: true),
              children: [
                HomeView(time$, defaultTime: DateTime.now()),
                AppsView(),
              ],
          ),
      ),
    );
  }
}
