import 'package:flutter/material.dart';

import 'pages/Home.dart';
import 'pages/Apps.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
          body: PageView(
              controller: PageViewController(),
              children: [
                HomeView(),
                AppView(),
              ],
          ),
      ),
    );
  }
}
