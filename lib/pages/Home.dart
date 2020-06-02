import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeView extends StatelessWidget {
  Stream<DateTime> time$;

  final timeFormat = new DateFormat.jm();
  final dateFormat = DateFormat('d, MMM');

  HomeView({ this.time$ }): super();

  @override
  Widget build(BuildContext ctx) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
      child: Column(
          children: [
            StreamBuilder<DateTime>(
              stream: time$,
              initialData: DateTime.now(),
              builder: (BuildContext context, AsyncSnapshot<DateTime> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.active:
                  case ConnectionState.done:
                    return Column(children: [
                      Text(timeFormat.format(snapshot.data), key: Key('time')),
                      Text(dateFormat.format(snapshot.data), key: Key('date')),
                    ]);
                  default:
                    return Text('Loading...', key: Key('loading'));
                }
              },
            ),
            Expanded(child: Text('Content')),
          ],
      ),
    );
  }
}

