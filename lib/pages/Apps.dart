import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

import '../components/FixedContainer.dart';
import '../components/SearchableAppList.dart';

class AppsView extends StatelessWidget {
  Future<List<Application>> appListF = DeviceApps.getInstalledApplications(
      includeSystemApps: false,
      onlyAppsWithLaunchIntent: true,
  );

  void openApp(Application app) {
    DeviceApps.openApp(app.packageName);
  }

  void openOptionsMenu(Application app) {
    debugPrint('Wow');
  }

  @override
  Widget build(BuildContext ctx) {
    return FixedContainer(
        padding: const EdgeInsets.symmetric(vertical: 36.0, horizontal: 16.0),
        child: SearchableAppList(
            appListF: appListF,
            openApp: openApp,
            openOptionsMenu: openOptionsMenu,
        ),
    );
  }
}

