import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

import '../components/FixedContainer.dart';
import '../components/SearchableAppList.dart';

import '../data/favorites.dart';

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

