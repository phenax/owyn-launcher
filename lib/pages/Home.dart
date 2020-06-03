import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:device_apps/device_apps.dart';

import '../components/AppList.dart';
import '../components/FixedContainer.dart';
import '../data/config.dart';

class StatusInfoCard extends StatelessWidget {
  Stream<DateTime> time$;
  DateTime defaultTime;

  StatusInfoCard(this.time$, { this.defaultTime }): super();

  final timeFormat = DateFormat('h:mm a'); // H fr 24 hrs
  final dateFormat = DateFormat('EEEE, d MMM');

  @override
  Widget build(BuildContext ctx) {
    ThemeData theme = Theme.of(ctx);

    return StreamBuilder<DateTime>(
        stream: time$,
        initialData: defaultTime,
        builder: (BuildContext context, AsyncSnapshot<DateTime> snapshot) {
          Widget child = Text('Loading...', key: Key('loading'));

          if (snapshot.hasData) {
            child = Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(timeFormat.format(snapshot.data),
                          key: Key('time'),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold,
                          ),
                      ),
                      Text(dateFormat.format(snapshot.data),
                          key: Key('date'),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w300,
                          ),
                      ),
                    ]
                )),
                Container(
                    width: 40,
                    height: 30,
                    child: IconButton(
                        padding: const EdgeInsets.all(0.0),
                        visualDensity: const VisualDensity(vertical: 0.0, horizontal: 0.0),
                        icon: Icon(
                            Icons.brightness_4,
                            color: theme.primaryColor,
                            size: 16.0,
                            semanticLabel: 'Toggle dark mode',
                        ),
                        tooltip: 'Toggle dark mode',
                        enableFeedback: true,
                        onPressed: () { toggleTheme(); }
                    ),
                ),
              ],
            );
          }

          return Container(
            height: 100,
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Align(alignment: Alignment.topLeft, child: child),
          );
        },
    );
  }
}

class HomeView extends StatelessWidget {
  Stream<DateTime> time$;
  DateTime defaultTime;
  List<Application> favoriteApps;

  HomeView({ this.time$, this.defaultTime, this.favoriteApps }): super();

  void noop(Application app) {}

  @override
  Widget build(BuildContext ctx) {
    return FixedContainer(
        padding: const EdgeInsets.symmetric(vertical: 36.0, horizontal: 16.0),
        child: Column(
            children: [
              StatusInfoCard(time$, defaultTime: defaultTime),
              Expanded(child: Container(
                child: AppList(appList: favoriteApps, openApp: noop, openOptionsMenu: noop),
              )),
            ],
        )
    );
  }
}

