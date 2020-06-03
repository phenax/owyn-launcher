import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

import '../components/FixedContainer.dart';
import '../components/SearchableAppList.dart';

import '../data/favorites.dart';

class Option extends StatelessWidget {
  void Function() onTap;
  Widget child;

  Option({ this.child, this.onTap }): super();

  @override
  build(BuildContext ctx) {
    return Column(
      children: [
        ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            title: child,
            onTap: () {
              onTap();
              Navigator.pop(ctx);
            },
        ),
        Divider(height: 1.0),
      ],
    );
  }
}

class AppsView extends StatelessWidget {
  void Function(Application) openApp;
  void Function(BuildContext, Application) openOptionsMenu;
  
  AppsView({ this.openApp, this.openOptionsMenu }): super();

  Future<List<Application>> appListF = DeviceApps.getInstalledApplications(
      includeSystemApps: true,
      onlyAppsWithLaunchIntent: true,
  );

  @override
  Widget build(BuildContext ctx) {
    return FixedContainer(
        padding: const EdgeInsets.symmetric(vertical: 36.0, horizontal: 16.0),
        child: SearchableAppList(
            appListF: appListF,
            openApp: openApp,
            openOptionsMenu: (app) => openOptionsMenu(ctx, app),
        ),
    );
  }
}

