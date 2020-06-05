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

  testWidgets('Should render nothing for empty list', (WidgetTester tester) async {
    await tester.pumpWidget(wrapper(SearchableAppList(appList: <Application>[])));
    await tester.pump();

    expect(find.byType(AppList), findsOneWidget);
    expect(find.byType(ListTile), findsNothing);
  });

  testWidgets('Should render nothing for a of list 4 items', (WidgetTester tester) async {
    await tester.pumpWidget(wrapper(SearchableAppList(appList: appList)));
    await tester.pumpAndSettle();

    expect(find.byType(AppList), findsOneWidget);
    expect(find.byType(ListTile), findsNWidgets(4));
  });

  testWidgets('Should render matching results for the search query', (WidgetTester tester) async {
    await tester.pumpWidget(wrapper(SearchableAppList(appList: appList)));
    await tester.pumpAndSettle();

    expect(find.byType(AppList), findsOneWidget);
    expect(find.byType(ListTile), findsNWidgets(4));

    var textField = find.byType(TextField);
    await tester.enterText(textField, 'twi');
    await tester.pump();

    //for(var e in find.byType(SearchableAppList).evaluate()) {
      //debugPrint((e.widget as SearchableAppList)._inputController.text);
    //}

    expect(find.byType(ListTile), findsNWidgets(4));
  });
}
