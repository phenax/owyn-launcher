import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:device_apps/device_apps.dart';

import 'package:owyn/components/AppList.dart';

import '../utils.dart';

void main() {
  List<Application> appList = <Application>[
    makeApp('Reddit', 'org.example.reddit'),
    makeApp('Spotify', 'org.example.spotify'),
    makeApp('Twitter', 'org.example.twitter'),
    makeApp('Youtube', 'org.example.youtube'),
  ];

  testWidgets('Should render nothing for empty list', (WidgetTester tester) async {
    await tester.pumpWidget(wrapper(AppList(appList: <Application>[])));

    expect(find.byType(ListTile), findsNothing);
  });

  testWidgets('Should render nothing for empty list', (WidgetTester tester) async {
    await tester.pumpWidget(wrapper(AppList(appList: appList)));

    expect(find.byType(ListTile), findsNWidgets(4));
  });

  testWidgets('Should open app on tap', (WidgetTester tester) async {
    bool wasAppOpened = false;
    Application openedApp;
    void mockOpenApp(Application app) {
      wasAppOpened = true;
      openedApp = app;
    }

    await tester.pumpWidget(wrapper(AppList(appList: appList, openApp: mockOpenApp)));

    var listTiles = find.byType(ListTile);

    await tester.tap(listTiles.at(1));
    await tester.pump();

    expect(wasAppOpened, equals(true));
    expect(openedApp.packageName, equals('org.example.spotify'));
  });

  testWidgets('Should open dialog menu on tap and hold', (WidgetTester tester) async {
    bool wasAppOpened = false;
    Application openedApp;
    void mockOpenOptionsMenu(Application app) {
      wasAppOpened = true;
      openedApp = app;
    }

    await tester.pumpWidget(wrapper(AppList(appList: appList, openOptionsMenu: mockOpenOptionsMenu)));

    var listTiles = find.byType(ListTile);

    await tester.longPress(listTiles.at(3));
    await tester.pump();

    expect(wasAppOpened, equals(true));
    expect(openedApp.packageName, equals('org.example.youtube'));
  });
}
