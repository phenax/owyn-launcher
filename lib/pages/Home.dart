import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:device_apps/device_apps.dart';

import '../components/AppList.dart';
import '../components/FixedContainer.dart';
import '../data/config.dart';

class StatusInfoCard extends StatelessWidget {
  DateTime dateTime;

  StatusInfoCard({ this.dateTime }): super();

  final timeFormat = DateFormat('h:mm a'); // H fr 24 hrs
  final dateFormat = DateFormat('EEEE, d MMM');

  @override
  Widget build(BuildContext ctx) {
    ThemeData theme = Theme.of(ctx);

    return Container(
        height: 100,
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Align(
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(timeFormat.format(dateTime),
                          key: Key('time'),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold,
                          ),
                      ),
                      Text(dateFormat.format(dateTime),
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
            ),
        ),
    );
  }
}

class HomeView extends StatelessWidget {
  DateTime dateTime;
  List<Application> favoriteApps;
  void Function(Application) openApp;
  void Function(BuildContext, Application) openOptionsMenu;

  HomeView({ this.dateTime, this.favoriteApps, this.openApp, this.openOptionsMenu }): super();

  @override
  Widget build(BuildContext ctx) {
    return FixedContainer(
        padding: const EdgeInsets.symmetric(vertical: 36.0, horizontal: 16.0),
        child: Column(
            children: [
              StatusInfoCard(dateTime: dateTime),
              Expanded(child: Container(
                child: AppList(
                    appList: favoriteApps,
                    openApp: openApp,
                    openOptionsMenu: (app) => openOptionsMenu(ctx, app),
                ),
              )),
            ],
        )
    );
  }
}

