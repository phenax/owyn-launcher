import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

import 'AppList.dart';

class SearchableAppList extends StatelessWidget {
  Future<List<Application>> appListF;
  void Function(Application) openApp;
  void Function(Application) openOptionsMenu;
  
  SearchableAppList({ this.appListF, this.openApp, this.openOptionsMenu }): super();

  int _appSorter(Application a, Application b) {
    return a.appName.compareTo(b.appName);
  }

  @override
  Widget build(BuildContext ctx) {
    return Column(
        children: [
          Text('My text input'),
          Expanded(child: FutureBuilder(
            future: appListF,
            builder: (ctx, AsyncSnapshot<List<Application>> snap) {
              if (!snap.hasData) {
                return Text('Loading...');
              }

              snap.data.sort(_appSorter);
              return AppList(
                  appList: snap.data,
                  openApp: openApp,
                  openOptionsMenu: openOptionsMenu,
              );
            }
          )),
        ],
    );
  }
}

