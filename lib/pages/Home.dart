import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatusInfoCard extends StatelessWidget {
  Stream<DateTime> time$;
  DateTime defaultTime;

  StatusInfoCard(this.time$, { this.defaultTime }): super();

  final timeFormat = new DateFormat.jm(); // hm fr 24 hrs
  final dateFormat = DateFormat('d MMMM');
  
  @override
  Widget build(BuildContext ctx) {
    return StreamBuilder<DateTime>(
        stream: time$,
        initialData: defaultTime,
        builder: (BuildContext context, AsyncSnapshot<DateTime> snapshot) {
          Widget child = Text('Loading...', key: Key('loading'));

          if (snapshot.hasData) {
            child = Column(children: [
              Text(timeFormat.format(snapshot.data), key: Key('time')),
              Text(dateFormat.format(snapshot.data), key: Key('date')),
            ]);
          }

          return Container(
            height: 300,
            child: child,
          );
        },
    );
  }
}

class HomeView extends StatelessWidget {
  Stream<DateTime> time$;
  DateTime defaultTime;

  HomeView(this.time$, { this.defaultTime }): super();

  @override
  Widget build(BuildContext ctx) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
           child: ConstrainedBox(
             constraints: BoxConstraints(
               minHeight: viewportConstraints.maxHeight,
             ),
             child: IntrinsicHeight(
               child: Container(
                   padding: const EdgeInsets.symmetric(vertical: 36.0, horizontal: 16.0),
                   height: viewportConstraints.maxHeight,
                   child: Column(
                       children: [
                         StatusInfoCard(time$, defaultTime: defaultTime),
                         Expanded(child: Text('Content')),
                       ],
                   ),
               )
             ),
            ),
          );
        }
    );
  }
}

