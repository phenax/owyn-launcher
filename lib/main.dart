import 'dart:async';
import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:android_intent/android_intent.dart';
import 'package:flutter/services.dart';

import 'pages/Home.dart';
import 'pages/Apps.dart';

import 'components/AppContextMenu.dart';

import 'data/config.dart';
import 'data/favorites.dart';
import 'data/applications.dart';
import 'helpers/StreamState.dart';

void main() {
  runApp(MyApp());
}

class MyAppState extends StreamState<MyApp> {
  // State
  final config = StreamStateValue<Config>(
      stream$: getConfig$(),
      value: Config(),
  );
  final favoriteApps = StreamStateValue<List<Application>>(
      stream$: getFavorites$(),
      value: [],
  );
  final applications = StreamStateValue<List<Application>>(
      stream$: getApplications$(),
      value: [],
  );
  final dateTime = StreamStateValue<DateTime>(
      stream$: Stream.periodic(Duration(seconds: 1), (_x) => DateTime.now()).asBroadcastStream(),
      value: DateTime.now(),
  );
  void initState() {
    super.initState();

    initStateValue(config);
    refreshConfig();
    
    initStateValue(favoriteApps);
    refreshFavorites();

    initStateValue(applications);
    refreshApplications();

    initStateValue(dateTime);
  }

  void openApp(Application app) {
    DeviceApps.openApp(app.packageName);
  }

  void openOptionsMenu(BuildContext ctx, Application app) {
    var isFavorite = -1 != favoriteApps.value.indexWhere((a) => a.packageName == app.packageName);

    showDialog(context: ctx, builder: (BuildContext ctx) => AppContextMenu(app: app, isFavorite: isFavorite));
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
  Widget build(BuildContext ctx) {
    return MaterialApp(
      title: 'owyn launcher',
      theme: getLightTheme(),
      darkTheme: getDarkTheme(),
      themeMode: config.value.isDarkMode() ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
          body: WillPopScope(
              onWillPop: () => Future.value(false),
              child: PageView(
                  controller: PageController(keepPage: true),
                  onPageChanged: (_x) {
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                  },
                  children: [
                    HomeView(
                        dateTime: dateTime.value,
                        favoriteApps: favoriteApps.value,
                        openApp: openApp,
                        openOptionsMenu: openOptionsMenu,
                    ),
                    AppsView(
                        appList: applications.value,
                        openApp: openApp,
                        openOptionsMenu: openOptionsMenu,
                    ),
                  ],
              ),
          ),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  MyAppState createState() => MyAppState();
}
