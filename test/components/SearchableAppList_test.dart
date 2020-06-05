import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:device_apps/device_apps.dart';

import 'package:owyn/components/SearchableAppList.dart';
import 'package:owyn/components/AppList.dart';

import '../utils.dart';

void main() {
  List<Application> appList = <Application>[
    makeApp('Reddit', 'org.example.reddit'),
    makeApp('Spotify', 'org.example.spotify'),
    makeApp('Twitter', 'org.example.twitter'),
    makeApp('Youtube', 'org.example.youtube'),
  ];
  var appListF = Future.value(appList);

  testWidgets('Should render nothing for empty list', (WidgetTester tester) async {
    await tester.pumpWidget(wrapper(SearchableAppList(appListF: Future.value(<Application>[]))));
    await tester.pump();

    expect(find.byType(AppList), findsOneWidget);
    expect(find.byType(ListTile), findsNothing);
  });

  //testWidgets('Should render nothing for a of list 4 items', (WidgetTester tester) async {
    //await tester.pumpWidget(wrapper(SearchableAppList(appListF: appListF)));
    //await tester.pumpAndSettle();

    //expect(find.byType(AppList), findsOneWidget);
    //expect(find.byType(ListTile), findsNWidgets(4));
  //});
}
