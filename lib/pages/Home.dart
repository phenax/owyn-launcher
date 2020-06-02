import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeView extends StatelessWidget {
  Stream<DateTime> time$;
  DateTime defaultTime;

  final timeFormat = new DateFormat.jm(); // hm fr 24 hrs
  final dateFormat = DateFormat('d MMMM');

  HomeView({ this.time$, this.defaultTime }): super();

  @override
  Widget build(BuildContext ctx) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
      child: Column(
          children: [
            StreamBuilder<DateTime>(
              stream: time$,
              initialData: defaultTime,
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

