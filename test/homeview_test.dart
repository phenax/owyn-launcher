import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:device_apps/device_apps.dart';

import 'package:owyn/pages/Home.dart';

import 'utils.dart';

void main() {
  DateTime time = DateTime.utc(2020, DateTime.march, 7, 10, 25, 30);
  List<Application> favoriteApps = <Application>[
    makeApp('Reddit', 'org.example.reddit'),
    makeApp('Spotify', 'org.example.spotify'),
    makeApp('Twitter', 'org.example.twitter'),
    makeApp('Youtube', 'org.example.youtube'),
  ];

  testWidgets('Should render with no errors with 0 favorite items', (WidgetTester tester) async {
    await tester.pumpWidget(wrapper(HomeView(dateTime: time, favoriteApps: <Application>[])));
    await tester.pump();
  });

  testWidgets('Should render with no errors with some favorite items', (WidgetTester tester) async {
    await tester.pumpWidget(wrapper(HomeView(dateTime: time, favoriteApps: favoriteApps)));
    await tester.pump();
  });

  testWidgets('Should show formatted date correctly', (WidgetTester tester) async {
    await tester.pumpWidget(wrapper(HomeView(dateTime: time, favoriteApps: <Application>[])));
    await tester.pump();

    await tester.pump(Duration(seconds: 2));

    var timeWidget = find.byKey(Key('time'));
    var dateWidget = find.byKey(Key('date'));

    expect(timeWidget, findsOneWidget);
    for(var w in timeWidget.evaluate()) {
      expect(w.widget.toString(), contains('10:25 AM'));
    }

    expect(dateWidget, findsOneWidget);
    for(var w in dateWidget.evaluate()) {
      expect(w.widget.toString(), contains('Saturday, 7 Mar'));
    }
  });

  testWidgets('Should show list of favorite apps', (WidgetTester tester) async {
    await tester.pumpWidget(wrapper(HomeView(dateTime: time, favoriteApps: favoriteApps)));
    await tester.pump();

    var favoritesList = find.byType(ListTile);

    expect(favoritesList, findsNWidgets(4));
    var i = 0;
    for(var w in favoritesList.evaluate()) {
      var fav = favoriteApps[i++];
      w.visitChildren((Element e) {
        expect(e.toStringDeep(), contains(fav.appName));
      });
    }
  });
}
