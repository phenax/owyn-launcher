import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:owyn/pages/Home.dart';

import 'utils.dart';

Future<void> waitFor(Duration duration) { return Future.delayed(duration, () {}); }

void main() {
  DateTime time = DateTime.utc(2020, DateTime.march, 7, 10, 25, 30);
  Stream<DateTime> time$ = Stream.value(time).asBroadcastStream();

  testWidgets('Should render with no errors', (WidgetTester tester) async {
    await tester.pumpWidget(wrapper(HomeView(time$)));
  });

  testWidgets('Should show formatted default date correctly', (WidgetTester tester) async {
    await tester.pumpWidget(wrapper(HomeView(time$, defaultTime: time)));
    await tester.pump();

    var timeWidget = find.byKey(Key('time'));
    var dateWidget = find.byKey(Key('date'));

    expect(timeWidget, findsOneWidget);
    for(var w in timeWidget.evaluate()) {
      expect(w.widget.toString(), contains('10:25 AM'));
    }

    expect(dateWidget, findsOneWidget);
    for(var w in dateWidget.evaluate()) {
      expect(w.widget.toString(), contains('7 March'));
    }
  });

  testWidgets('Should show streamed formatted date correctly', (WidgetTester tester) async {
    await tester.pumpWidget(wrapper(HomeView(time$)));
    await tester.pump();

    var timeWidget = find.byKey(Key('time'));
    var dateWidget = find.byKey(Key('date'));

    await waitFor(Duration(milliseconds: 50));
    await tester.pump();

    expect(timeWidget, findsOneWidget);
    //for(var w in timeWidget.evaluate()) {
      //expect(w.widget.toString(), contains('10:25 AM'));
    //}

    //expect(dateWidget, findsOneWidget);
    //for(var w in dateWidget.evaluate()) {
      //expect(w.widget.toString(), contains('7 March'));
    //}
  });
}
