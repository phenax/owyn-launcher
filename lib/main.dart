import 'dart:async';
import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

import 'pages/Home.dart';
import 'pages/Apps.dart';

import 'data/config.dart';
import 'data/favorites.dart';
import 'helpers/StreamState.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyAppState extends StreamState<MyApp> {
  // Streams
  final Stream<DateTime> time$ =
      Stream.periodic(Duration(seconds: 1), (_x) => DateTime.now()).asBroadcastStream();

  // State
  final config = StreamStateValue<Config>(
      stream$: getConfig$(),
      value: Config(),
  );
  final favoriteApps = StreamStateValue<List<Application>>(
      stream$: getFavorites$(),
      value: [],
  );
  void initState() {
    super.initState();
    initStateValue(config);
    initConfig();
    initStateValue(favoriteApps);
    initFavorites();

    SharedPreferences.getInstance().then((instance) {
      var val = instance.getString('favorites');
      debugPrint('Hello |${val}| ${val.length}');
    });
  }

  @override
  void dispose() {
    super.dispose();
    time$.drain();
  }

  ThemeData getLightTheme() {
    return ThemeData(brightness: Brightness.light);
  }

  ThemeData getDarkTheme() {
    Color fg = Color(0xFFD8DEE9);
    return ThemeData(
          backgroundColor: Color(0xFF1F2225),
          scaffoldBackgroundColor: Color(0xFF0F1215),
          accentColor: fg,
          primaryColor: Color(0xFF5E81AC),
          textTheme: TextTheme(
              headline1: TextStyle(color: fg),
              headline2: TextStyle(color: fg),
              headline3: TextStyle(color: fg),
              headline4: TextStyle(color: fg),
              headline5: TextStyle(color: fg),
              headline6: TextStyle(color: fg),
              subtitle1: TextStyle(color: fg),
              subtitle2: TextStyle(color: fg),
              bodyText1: TextStyle(color: fg),
              bodyText2: TextStyle(color: fg),
              button: TextStyle(color: fg),
              caption: TextStyle(color: fg),
              overline: TextStyle(color: fg),
          ),
      );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'owyn launcher',
      theme: getLightTheme(),
      darkTheme: getDarkTheme(),
      themeMode: config.value.isDarkMode() ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
          body: PageView(
              controller: PageController(keepPage: true),
              children: [
                HomeView(
                    time$: time$,
                    defaultTime: DateTime.now(),
                    favoriteApps: favoriteApps.value,
                ),
                AppsView(),
              ],
          ),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  MyAppState createState() => MyAppState();
}
