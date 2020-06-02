import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:owyn/pages/Home.dart';

import 'utils.dart';


void main() {
  Stream<DateTime> time$ = Stream.value(DateTime.utc(2020, DateTime.may, 7, 10, 25, 30)).asBroadcastStream();

  testWidgets('Should render with no errors', (WidgetTester tester) async {
    await tester.pumpWidget(wrapper(HomeView(time$: time$)));
  });

  testWidgets('Should show formatted date correctly', (WidgetTester tester) async {
    await tester.pumpWidget(wrapper(HomeView(time$: time$)));
    await tester.pump();

    expect(find.byKey(Key('time')), findsOneWidget);
    expect(find.byKey(Key('date')), findsOneWidget);
  });
}
